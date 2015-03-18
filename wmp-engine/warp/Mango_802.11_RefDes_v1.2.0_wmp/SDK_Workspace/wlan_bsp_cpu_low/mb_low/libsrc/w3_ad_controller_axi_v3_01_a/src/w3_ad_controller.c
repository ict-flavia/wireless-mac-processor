/*****************************************************************
* File: w3_ad_controller.c
* Copyright (c) 2012 Mango Communications, all rights reseved
* Released under the WARP License
* See http://warp.rice.edu/license for details
*****************************************************************/

/** \file w3_ad_controller.c

\mainpage
This is the driver for the w3_ad_controller core, which implements an SPI master for controlling
the AD9963 analog converters for the WARP v3 RF interfaces.

@version 3.00.b
@author Patrick Murphy
@copyright (c) 2012 Mango Communications, Inc. All rights reserved.<br>
Released under the WARP open source license (see http://warp.rice.edu/license)

\brief Main source for w3_ad_controller driver

*/

#include "w3_ad_controller.h"


/**
\defgroup user_functions Functions
\brief Functions to call from user code
\addtogroup user_functions

Example:
\code{.c}
//Assumes user code sets AD_BASEADDR to base address of w3_ad_controller core, as set in xparameters.h

//Initialize the AD9963s
ad_init(AD_CONTROLLER, 3);

\endcode

@{
*/

/**
\brief Initializes the AD controller. This function must be called once at boot before any AD or RF operations will work
\param baseaddr Base memory address of w3_ad_controller pcore
\param clkdiv Clock divider for SPI serial clock (set to 3 for 160MHz bus)
*/
int ad_init(u32 baseaddr, u32 adSel, u8 clkdiv)
{
	u32 rstMask, reg5c, reg72, reg5c_check, reg72_check;
	
	if((adSel & AD_CTRL_ALL_RF_CS) == 0) {
		print("ad_init: Invalid adSel parameter!\n");
		return -1;
	}

	rstMask = 0;
	reg5c_check = 0;
	reg72_check = 0;
	if(adSel & RFA_AD_CS) {rstMask |= ADCTRL_REG_CONFIG_MASK_RFA_AD_RESET; reg5c_check |= 0x00000008; reg72_check |= 0x00000001;}
	if(adSel & RFB_AD_CS) {rstMask |= ADCTRL_REG_CONFIG_MASK_RFB_AD_RESET; reg5c_check |= 0x00000800; reg72_check |= 0x00000100;}
	if(adSel & RFC_AD_CS) {rstMask |= ADCTRL_REG_CONFIG_MASK_RFC_AD_RESET; reg5c_check |= 0x00080000; reg72_check |= 0x00010000;}
	if(adSel & RFD_AD_CS) {rstMask |= ADCTRL_REG_CONFIG_MASK_RFD_AD_RESET; reg5c_check |= 0x08000000; reg72_check |= 0x01000000;}
	
	//Toggle AD resets (active low), Set SPI clock divider
	Xil_Out32(baseaddr + ADCTRL_REG_CONFIG, 0);
	Xil_Out32(baseaddr + ADCTRL_REG_CONFIG, (clkdiv & ADCTRL_REG_CONFIG_MASK_CLKDIV) | rstMask);

	//Toggle soft reset, set SDIO pin to bidirectional (only way to do SPI reads)
	ad_spi_write(baseaddr, (adSel), 0x00, 0xBD); //SDIO=1, LSB_first=0, reset=1
	ad_spi_write(baseaddr, (adSel), 0x00, 0x99); //SDIO=1, LSB_first=0, reset=0

	//Confirm the SPI ports are working
	//AD9963 reg5C should be 0x08 always, reg72 is 0x1 on boot
	reg5c = (ad_spi_read(baseaddr,  (adSel), 0x5C))&reg5c_check;
	reg72 = (ad_spi_read(baseaddr,  (adSel), 0x72))&reg72_check;
	if((reg5c != reg5c_check) || (reg72 != reg72_check)) {
		xil_printf("First AD SPI read was wrong: addr[5C]=0x%08x (should be 0x%08x), addr[72]=0x%08x (should be 0x%08x)\n", reg5c, reg5c_check, reg72, reg72_check);
		print("Asserting AD9963 resets\n");
		Xil_Out32(baseaddr + ADCTRL_REG_CONFIG, 0);

		return -1;
	}
	
	/* Default AD9963 configuration:
		-External ref resistor (NOTE: apparent datasheet bug!)
		-Full-duplex mode (Tx data on TXD port, Rx data on TRXD port)
		-Power up everything except:
			-DAC12A, DAC12B, AUXADC (all unconnected on PCB)
			-DLL
		-Clocking:
			-DLL disabled
			-ADC clock = DAC clock = ext clock (nominally 80MHz)
		-Tx path:
			-Data in 2's complement (NOTE: datasheet bug!)
			-TXCLK is input at TXD sample rate
			-TXD is DDR, I/Q interleaved, I first
			-Tx interpolation filters bypassed
			-Tx gains:
				-Linear gain set to 100%
				-Linear-in-dB gain set to -3dB
				-DAC RSET set to 100%
			-Tx DCO DACs:
				-Enabled, configured for [0,+2]v range
				-Set to mid-scale output (approx equal to common mode voltage of I/Q diff pairs)
		-Rx path:
			-Data in 2's complement (NOTE: datasheet bug!)
			-TRXCLK is output at TRXD sample rate
			-TRXD is DDR, I/Q interleaved, I first
			-Decimation filter bypassed
			-RXCML output enabled (used by ADC driver diff amp)
			-ADC common mode buffer off (required for DC coupled inputs)
			-Rx I path negated digitally (to match swap of p/n traces on PCB)
	*/
		
	//Power on/off blocks
	ad_spi_write(baseaddr, (adSel), 0x40, 0x00); //DAC12A, DAC12B off
	ad_spi_write(baseaddr, (adSel), 0x60, 0x00); //DLL off, everything else on
	ad_spi_write(baseaddr, (adSel), 0x61, 0x03); //LDOs on, AUXADC off
	//xil_printf("AD TEST: reg61=0x%08x\n", ad_spi_read(baseaddr,  (adSel), 0x61));
	
	//Clocking setup
	// [7]=0: ADCCLK=ext clk
	// [6]=0: DACCLK=ext clk
	// [4]=0: disable DLL input ref
	// [3:0]: DLL divide ratio (only 1, 2, 3, 4, 5, 6, 8 valid)
	ad_spi_write(baseaddr, (adSel), 0x71, 0x01); //DLL ref input off, ADCCLK=extCLK, DACCLK=extCLK, DLL_DIV=1

	//Reference resistor selection
	// Datasheet says reg62[0]=0 for internal resistor, reg62[0]=1 for external resistor
	// But experimentally DAC currents are much more stable with temperature when reg62[0]=0
	// I'm guessing this bit is flipped in the datasheet
	ad_spi_write(baseaddr, (adSel), 0x62, 0x00);

	//Clock disables and DCS
	// [7:3]=0: Enable internal clocks to ADCs/DACs
	// [1:0]=0: Set ADCCLK=ext clock (no division)
	// [2]=0: Enable ADC duty cycle stabilizer (recommended for ADC rates > 75MHz)
	ad_spi_write(baseaddr, (adSel), 0x66, 0x00); //Enable internal clocks, enable DCS

	//Aux DACs (Tx DC offset adjustment)
	// DAC10B=Q DCO, DAC10A=I DCO
	// DAC outputs update after LSB write (configured by reg40[0])
	ad_spi_write(baseaddr, (adSel), 0x45, 0x88); //DAC10B on, full scale = [0,+2]v
	ad_spi_write(baseaddr, (adSel), 0x46, 0x80); //DAC10B data[9:2]
	ad_spi_write(baseaddr, (adSel), 0x47, 0x00); //DAC10B {6'b0, data[1:0]}

	ad_spi_write(baseaddr, (adSel), 0x48, 0x88); //DAC10A on, full scale = [0,+2]v
	ad_spi_write(baseaddr, (adSel), 0x49, 0x80); //DAC10A data[9:2]
	ad_spi_write(baseaddr, (adSel), 0x50, 0x00); //DAC10A {6'b0, data[1:0]}

	//ADC common mode buffer: disabled for DC coupled inputs
	ad_spi_write(baseaddr, (adSel), 0x7E, 0x01);

	//Spectral inversion
	// Invert RxI (reg3D[2]=1) to match PCB
	// TxI, TxQ also swapped on PCB, but ignored here since -1*(a+jb) is just one of many phase shifts the Tx signal sees
	ad_spi_write(baseaddr, (adSel), 0x3D, 0x04); //Invert RxI to match PCB (board swaps +/- for better routing)

	//Rx clock and data order/format
	// [7:1]=[0 x 1 0 1 0 1] to match design of ad_bridge input registers (TRXD DDR relative to TRXCLK, I data first)
	// [0]=1 for 2's compliment (Datasheet says reg32[0]=0 for 2's compliment, but experiments show 0 is really straight-binary)
	ad_spi_write(baseaddr, (adSel), 0x32, 0x2B);

	//Full-duplex mode (DACs/TXD and ADCs/TRXD both active all the time)
	ad_spi_write(baseaddr, (adSel), 0x3F, 0x01); //FD mode

	//Tx data format (datasheet bug! reg[31][0] is flipped; 1=2's complement, 0=straight binary)
	//0x17 worked great with latest ad_bridge (where TXCLK is ODDR(D1=1,D0=0,C=ad_ref_clk_90) and TXD are ODDR (D1=I,D2=Q,C=ad_ref_clk_0))
	ad_spi_write(baseaddr, (adSel), 0x31, 0x17); //Txdata=DDR two's complement,

	//Tx/Rx data paths
	ad_spi_write(baseaddr, (adSel), 0x30, 0x3F); //Bypass all rate change filters, enable Tx/Rx clocks
//	ad_spi_write(baseaddr, (adSel), 0x30, 0x37); //INT0 on, enable Tx/Rx clocks
//	ad_spi_write(baseaddr, (adSel), 0x30, 0x27); //INT0+INT1 on, enable Tx/Rx clocks
//	ad_spi_write(baseaddr, (adSel), 0x30, 0x23); //INT0+INT1+SRCC on, enable Tx/Rx clocks

	//ADC RXCML output buffer requires special register process (see AD9963 datasheet pg. 21 "sub serial interface communications")
	ad_spi_write(baseaddr, (adSel), 0x05, 0x03); //Address both ADCs
	ad_spi_write(baseaddr, (adSel), 0x0F, 0x02); //Enable RXCML output
	ad_spi_write(baseaddr, (adSel), 0x10, 0x00); //Set I/Q offset to 0
	ad_spi_write(baseaddr, (adSel), 0xFF, 0x01); //Trigger ADC param update
	ad_spi_write(baseaddr, (adSel), 0x05, 0x00); //De-Address both ADCs

	//REFIO adjustment: set to default of 0.8v
	ad_spi_write(baseaddr, (adSel), 0x6E, 0x40);

	//Tx gains (it seems these registers default to non-zero, and maybe non-I/Q-matched values; safest to set them explicitly after reset)
	//I/Q GAIN1[5:0]: Fix5_0 value, Linear-in-dB, 0.25dB per bit
	//  0-25=>0dB-+6dB, 25-32:+6dB, 33-41:-6dB, 41-63=>-6dB-0dB
	ad_spi_write(baseaddr, (adSel), 0x68, 0); //IGAIN1
	ad_spi_write(baseaddr, (adSel), 0x6B, 0); //QGAIN1

	//I/Q GAIN2[5:0]: Fix5_0 value, Linear +/-2.5%, 0.08% per bit
	// 0:+0, 31:+max, 32:-max, 63:-0
	ad_spi_write(baseaddr, (adSel), 0x69, 0); //IGAIN2
	ad_spi_write(baseaddr, (adSel), 0x6C, 0); //QGAIN2

	//I/Q RSET[5:0]: Fix5_0, Linear +/-20%, 0.625% per bit
	// 0:-0, 31:-max, 32:+max, 63:+0
	ad_spi_write(baseaddr, (adSel), 0x6A, 0); //IRSET
	ad_spi_write(baseaddr, (adSel), 0x6D, 0); //QRSET

	//Digital output drive strengths: all 8mA
	ad_spi_write(baseaddr, (adSel), 0x63, 0x55); //2 bits each: TRXD TRXIQ TRXCLK TXCLK
	
	//Disable Tx and Rx BIST modes
	ad_spi_write(baseaddr, (adSel), 0x50, 0x00); //Tx BIST control
	ad_spi_write(baseaddr, (adSel), 0x51, 0x00); //Rx BIST control
	
	return 0;
}

/**
\brief Reads the specified register from both AD9963s
\param baseaddr Base memory address of w3_ad_controller pcore
\param csMask OR'd combination of RFA_AD_CS and RFB_AD_CS
\param regAddr Address of register to read, in [0x00, 0x82]
\return Returns concatenation of current values of the specified register for both AD9963s; RFA is LSB
*/
u32 ad_spi_read(u32 baseaddr,  u32 csMask, u8 regAddr) {
//NOTE: reads from multiple SPI devices simultaneously
// return value is 4 bytes
// least-significant byte is RFA_AD, next is RFB_AD
	u32 txWord, rxWord;

	//SPI Tx register is 4 bytes:
	// [3]: chip selects (bitwise OR'd ADCTRL_REG_SPITX_ADx_CS)
	// [2]: {rnw n1 n0 5'b0}, rnw=1 for SPI write, n1=n0=0 for 1 byte write
	// [1]: reg addr[7:0]
	// [0]: ignored for read (read value captured in Rx register)
	txWord = (csMask & (AD_CTRL_ALL_RF_CS)) | //chip selects
			 (ADCTRL_REG_SPITX_RNW) | //spi_tx_byte[2] = {rnw n1 n0 5'b0}
			 ((regAddr & 0xFF)<<8) | //spi_tx_byte[1] = addr[7:0]
			 (0x00); //spi_tx_byte[0] = ignored for read (AD drives data pin during this byte)

	Xil_Out32(baseaddr + ADCTRL_REG_SPITX, txWord);

	rxWord = Xil_In32(baseaddr + ADCTRL_REG_SPIRX);

	return(rxWord);
}

/**
\brief Writes the specified register in selected AD9963s. Multiple AD9963s can be selected for simultaneous writes.
\param baseaddr Base memory address of w3_ad_controller pcore
\param csMask OR'd combination of RFA_AD_CS and RFB_AD_CS
\param regAddr Address of register to write, in [0x00, 0xFF]
\param txByte Byte value to write
*/
void ad_spi_write(u32 baseaddr, u32 csMask, u8 regAddr, u8 txByte) {
	u32 txWord;

	//SPI read process:
	// -Write full SPI word with RNW=1 and address of desired register
	// -Capture register value in last byte of SPI write process (handled automatically in logic)
	
	//SPI Tx register is 4 bytes:
	// [3]: chip selects (bitwise OR'd ADCTRL_REG_SPITX_ADx_CS)
	// [2]: {rnw n1 n0 5'b0}, rnw=0 for SPI write, n1=n0=0 for 1 byte write
	// [1]: reg addr[7:0]
	// [0]: reg data[7:0]
	txWord = (csMask & (AD_CTRL_ALL_RF_CS)) |  //byte[3]
			 (0x00) |
			 ((regAddr & 0xFF)<<8) |
			 (txByte & 0xFF); //byte[0]

	Xil_Out32(baseaddr + ADCTRL_REG_SPITX, txWord);
	
	return;
}


/**
\brief Sets the DC offset for the selected path (I or Q) in the selected AD9963s
\param baseaddr Base memory address of w3_ad_controller pcore
\param csMask OR'd combination of RFA_AD_CS and RFB_AD_CS
\param iqSel Select I or Q path; must be AD_CHAN_I or AD_CHAN_Q
\param dco DC offset to apply, in [0,1024]
*/
int ad_set_TxDCO(u32 baseaddr, u32 csMask, u8 iqSel, u16 dco) {

	//Sanity check inputs
	if( ((csMask & (AD_CTRL_ALL_RF_CS)) == 0) || (dco>1023))
		return -1;
	
	if(iqSel == AD_CHAN_I) {
		//AUXIO2=DAC10A=I DAC TxDCO
		ad_spi_write(baseaddr, csMask, 0x49, ((dco & 0x3FF) >> 2)); //DAC10A data[9:2] - 8 MSB
		ad_spi_write(baseaddr, csMask, 0x4A, (dco & 0x3)); //DAC10A {6'b0, data[1:0]} - 2 LSB
	}
	else if(iqSel == AD_CHAN_Q) {
		//AUXIO3=DAC10B=Q DAC TxDCO
		ad_spi_write(baseaddr, csMask, 0x46, ((dco & 0x3FF) >> 2)); //DAC10B data[9:2] - 8 MSB
		ad_spi_write(baseaddr, csMask, 0x47, (dco & 0x3)); //DAC10B {6'b0, data[1:0]} - 2 LSB
	}

	return 0;
}

/**
\brief Sets the GAIN1 value (linear-in-dB adjustment +/- 6dB) for the selected path (I or Q) in the selected AD9963s.
Changing this gain value also changes the common mode voltage and DC offset of the selected path. We recommend leaving
this gain setting unchanged for optimal performance.
\param baseaddr Base memory address of w3_ad_controller pcore
\param csMask OR'd combination of RFA_AD_CS and RFB_AD_CS
\param iqSel Select I or Q path; must be AD_CHAN_I or AD_CHAN_Q
\param gain 6-bit gain value; [0:25] = [0:+6dB], [41,63] = [-6dB:0dB]
*/
int ad_set_TxGain1(u32 baseaddr, u32 csMask, u8 iqSel, u8 gain) {
	//6-bit Linear-in-dB gain +/- 6dB

	//Sanity check inputs
	if( ((csMask & (AD_CTRL_ALL_RF_CS)) == 0) || (gain>63))
		return -1;
	
	if(iqSel == AD_CHAN_I) {
		ad_spi_write(baseaddr, csMask, 0x68, (gain&0x3F)); //IGAIN1
	}
	else if(iqSel == AD_CHAN_Q) {
		ad_spi_write(baseaddr, csMask, 0x6B, (gain&0x3F)); //QGAIN1
	}

	return 0;
}

/**
\brief Sets the GAIN2 value (linear adjustment +/- 2.5%) for the selected path (I or Q) in the selected AD9963s
Changing this gain value also changes the common mode voltage and DC offset of the selected path. We recommend leaving
this gain setting unchanged for optimal performance.
\param baseaddr Base memory address of w3_ad_controller pcore
\param csMask OR'd combination of RFA_AD_CS and RFB_AD_CS
\param iqSel Select I or Q path; must be AD_CHAN_I or AD_CHAN_Q
\param gain 6-bit gain value; [0:25] = [0:+2.5%], [41,63] = [-2.5%:0]
*/
int ad_set_TxGain2(u32 baseaddr, u32 csMask, u8 iqSel, u8 gain) {
//6-bit Linear gain +/- 2.5%

	//Sanity check inputs
	if( ((csMask & (AD_CTRL_ALL_RF_CS)) == 0) || (gain>63))
		return -1;
	
	if(iqSel == AD_CHAN_I) {
		ad_spi_write(baseaddr, csMask, 0x69, (gain&0x3F)); //IGAIN2
	}
	else if(iqSel == AD_CHAN_Q) {
		ad_spi_write(baseaddr, csMask, 0x6C, (gain&0x3F)); //QGAIN2
	}

	return 0;
}

/**
\brief Configures the digital rate-change filters in the AD9963. Changing filter settings affects the require data rate
at the TXD and TRXD ports. You must ensure all related paramters (AD9963 filters, I/Q rate in FPGA, AD9512 dividers) are consistent.
\param baseaddr Base memory address of w3_ad_controller pcore
\param csMask OR'd combination of RFA_AD_CS and RFB_AD_CS
\param interpRate Desired interpolation rate in AD9963; must be one of [1, 2, 4, 8]
\param decimationRate Desired decimation rate in AD9963; must be one of [1, 2]
\return Returns 0 on success, -1 for invalid paramters
*/
int ad_config_filters(u32 baseaddr, u32 csMask, u8 interpRate, u8 decimationRate) {

	//Sanity check inputs
	if( ((csMask & (AD_CTRL_ALL_RF_CS)) == 0))
		return -1;
		
	/* AD9963 register 0x30:
		7:6 Reserved
		5: DEC_BP Bypass Rx decimation filter	0x20
		4: INT1_BP Bypass Tx INT1 filter		0x10
		3: INT0_BP Bypass Tx INT0 filter		0x08
		2: SRRC_BP Bypass Tx SRRC filter		0x04
		1: TXCLK_EN Enable Tx datapath clocks	0x02
		0: RXCLK_EN Enable Rx datapath clocks	0x01
	
		Tx filter config:
		1x: All Tx filters bypased
		2x: INT0 enabled
		4x: INT0, INT1 enbaled
		8x: All Tx fitlers enabled
	*/
	
	u8 regVal;
	
	//Enable Tx/Rx clocks by default
	regVal = 0x3;
	
	switch(interpRate) {
		case 1:
			regVal = regVal | 0x1C;
			break;
		case 2:
			regVal = regVal | 0x14;
			break;
		case 4:
			regVal = regVal | 0x04;
			break;
		case 8:
			break;
		default:
			//Invalid interp rate; return error
			return -1;
			break;
	}

	if(decimationRate == 1) {
		regVal = regVal | 0x20;
	} else if(decimationRate != 2) {
		//Invalid decimation rate; return error
		return -1;
	}
	
	//Write reg 0x30 in selected AD9963's
	ad_spi_write(baseaddr, csMask, 0x30, regVal);
	
	return 0;
}

/**
\brief Configures the ADC and DAC clock sources in the AD9963. Refer to the WARP v3 user guide and AD9963 for details
on various clocking modes
\param baseaddr Base memory address of w3_ad_controller pcore
\param csMask OR'd combination of RFA_AD_CS and RFB_AD_CS
\param DAC_clkSrc DAC clock source; must be AD_DACCLKSRC_DLL (use DLL clock) or AD_DACCLKSRC_EXT (use external reference clock)
\param ADC_clkSrc ADC clock source; must be AD_ADCCLKSRC_DLL (use DLL clock) or AD_ADCCLKSRC_EXT (use external reference clock)
\param ADC_clkDiv ADC clock divider; must be one of [AD_ADCCLKDIV_1, AD_ADCCLKDIV_2, AD_ADCCLKDIV_4] for divide-by of [1, 2, 4]
\param ADC_DCS ADC duty cycle stabilizer; must be AD_DCS_ON or AD_DCS_OFF. AD9963 datasheet recommends DCS be enabled only for ADC rates above 75MHz.
\return Returns 0 on success, -1 for invalid paramters
*/
int ad_config_clocks(u32 baseaddr, u32 csMask, u8 DAC_clkSrc, u8 ADC_clkSrc, u8 ADC_clkDiv, u8 ADC_DCS) {

	u8 regVal;
	u8 bitsToSet_reg66, bitsToSet_reg71;

	//Sanity check inputs
	if( ((csMask & (AD_CTRL_ALL_RF_CS)) == 0))
		return -1;

	/* AD9963 reg 0x66:
		7:6 Disable DAC clocks
		4:3 Disable ADC clocks
		2: Disable DCS
		1:0 ADCDIV
	
	  AD9963 reg 0x71:
		7: ADC clock selection (1=DLL, 0=ext)
		6: DAC clock selection (1=DLL, 0=ext)
		4:0 DLL config
	*/
	
	//Assert sane default bits, and any config bits user options require
	bitsToSet_reg66 = (ADC_DCS & AD_DCS_OFF) | (ADC_clkDiv & (AD_ADCCLKDIV_1 | AD_ADCCLKDIV_2 | AD_ADCCLKDIV_4));
	bitsToSet_reg71 = (DAC_clkSrc & AD_DACCLKSRC_DLL) | (ADC_clkSrc & AD_ADCCLKSRC_DLL);
	
	//For RFA and RFB, clear-then-set affected bits in clock config registers (0x66 and 0x71)
	if(csMask & RFA_AD_CS) {
		regVal = (u8)ad_spi_read(baseaddr, RFA_AD_CS, 0x66);
		regVal = regVal & ~(AD_DCS_OFF | AD_ADCCLKDIV_1 | AD_ADCCLKDIV_2 | AD_ADCCLKDIV_4);
		regVal = regVal | bitsToSet_reg66;
		ad_spi_write(baseaddr, RFA_AD_CS, 0x66, regVal);

		regVal = (u8)ad_spi_read(baseaddr, RFA_AD_CS, 0x71);
		regVal = regVal & ~(AD_DACCLKSRC_DLL | AD_ADCCLKSRC_DLL);
		regVal = regVal | bitsToSet_reg71;
		ad_spi_write(baseaddr, RFA_AD_CS, 0x71, regVal);
	}

	if(csMask & RFB_AD_CS) {
		regVal = (u8)(ad_spi_read(baseaddr, RFB_AD_CS, 0x66)>>8);
		regVal = regVal & ~(AD_DCS_OFF | AD_ADCCLKDIV_1 | AD_ADCCLKDIV_2 | AD_ADCCLKDIV_4);
		regVal = regVal | bitsToSet_reg66;
		ad_spi_write(baseaddr, RFB_AD_CS, 0x66, regVal);

		regVal = (u8)(ad_spi_read(baseaddr, RFB_AD_CS, 0x71)>>8);
		regVal = regVal & ~(AD_DACCLKSRC_DLL | AD_ADCCLKSRC_DLL);
		regVal = regVal | bitsToSet_reg71;
		ad_spi_write(baseaddr, RFB_AD_CS, 0x71, regVal);
	}

	if(csMask & RFC_AD_CS) {
		regVal = (u8)(ad_spi_read(baseaddr, RFC_AD_CS, 0x66)>>8);
		regVal = regVal & ~(AD_DCS_OFF | AD_ADCCLKDIV_1 | AD_ADCCLKDIV_2 | AD_ADCCLKDIV_4);
		regVal = regVal | bitsToSet_reg66;
		ad_spi_write(baseaddr, RFC_AD_CS, 0x66, regVal);

		regVal = (u8)(ad_spi_read(baseaddr, RFC_AD_CS, 0x71)>>8);
		regVal = regVal & ~(AD_DACCLKSRC_DLL | AD_ADCCLKSRC_DLL);
		regVal = regVal | bitsToSet_reg71;
		ad_spi_write(baseaddr, RFC_AD_CS, 0x71, regVal);
	}

	if(csMask & RFD_AD_CS) {
		regVal = (u8)(ad_spi_read(baseaddr, RFD_AD_CS, 0x66)>>8);
		regVal = regVal & ~(AD_DCS_OFF | AD_ADCCLKDIV_1 | AD_ADCCLKDIV_2 | AD_ADCCLKDIV_4);
		regVal = regVal | bitsToSet_reg66;
		ad_spi_write(baseaddr, RFD_AD_CS, 0x66, regVal);

		regVal = (u8)(ad_spi_read(baseaddr, RFD_AD_CS, 0x71)>>8);
		regVal = regVal & ~(AD_DACCLKSRC_DLL | AD_ADCCLKSRC_DLL);
		regVal = regVal | bitsToSet_reg71;
		ad_spi_write(baseaddr, RFD_AD_CS, 0x71, regVal);
	}
	
	return 0;

}

/**
\brief Configures the AD9963 DLL block. DLL output clock is REFCLK*M/(N*DLL_DIV). REFCLK*M must be in [100,310]MHz. See the AD9963 for more details.
\param baseaddr Base memory address of w3_ad_controller pcore
\param csMask OR'd combination of RFA_AD_CS and RFB_AD_CS
\param DLL_En DLL Enable (1=DLL enabled, 0=DLL disabled). Other arguments are ignored when DLL_En=0
\param DLL_M DLL multiplication (M) parameter; must be in [0,1,...,31] for multiplications of [1,2,...,32], constrained by M*REFCLK in [100, 310]MHz
\param DLL_N DLL division (N) parameter; must be one of [1,2,3,4,5,6,8]
\param DLL_DIV Secondary DLL divider; must be one of [1,2,4]
\return Returns 0 on success, -1 for invalid paramters, -2 if DLLs fail to lock with new settings
*/
int ad_config_DLL(u32 baseaddr, u32 csMask, u8 DLL_En, u8 DLL_M, u8 DLL_N, u8 DLL_DIV) {

	u8 regVal;
	u8 bitsToSet_reg71;
	u8 lockAttempts = 100;

	//Sanity check inputs
	if( ((csMask & (AD_CTRL_ALL_RF_CS)) == 0))
		return -1;

	if( (DLL_N == 7) || (DLL_N == 0) || (DLL_N > 8) || (DLL_M > 31) || (DLL_DIV == 0) || (DLL_DIV == 3) || (DLL_DIV > 4))
		return -1;
		
		
	/*
	AD9963 reg 0x60:
		7: DLL_EN (1=enable DLL)
		6:0 other block disables
		
	AD9963 reg 0x71:
		7:6 ADC/DAC clock selection
		5: reserved
		4: 1=enable DLL clock input
		3:0 DLL N (only valid values: 1,2,3,4,5,6,8)

	AD9963 reg 0x72:
		7: DLL locked (read-only)
		6:5 DLLDIV (secondary divider value)
		4:0 DLL M ([1:32] all valid)

	AD9963 reg 0x75:
		7:4 must be 0
		3: DLL_RESB: DLL reset (must transition low-to-high after any DLL parameter change)* see NOTE below
		2:0 must be 0

	*/
	
	//NOTE! The AD9963 datasheet claims DLL_RESB (reg 0x75[3]) is active low. I'm pretty sure
	// that's wrong (yet another AD9963 datasheet bit-flip). The code below treats DLL_RESB as
	// active high, the only interpreation we've seen work in hardware.
	

	if(DLL_En == 0) {
		//Assert DLL reset
		ad_spi_write(baseaddr, csMask, 0x75, 0x08);

		//Power down DLL block, leave all other blocks powered on
		ad_spi_write(baseaddr, csMask, 0x60, 0x00);

		//Disable DLL clock input, set ADC/DAC clock sources to ext ref clock
		ad_spi_write(baseaddr, csMask, 0x71, 0xC0);
		
		return 0;

	} else {
		//Assert DLL reset
		ad_spi_write(baseaddr, csMask, 0x75, 0x08);

		//Power up DLL block, leave all other blocks powered on
		ad_spi_write(baseaddr, csMask, 0x60, 0x80);

		//Assert DLL clock enable, set DLL_N
		bitsToSet_reg71 = 0x10 | (DLL_N & 0xF);
		
		//reg71 has bits to preserve, so handle it separately for each AD
		if(csMask & RFA_AD_CS) {
			regVal = (u8)ad_spi_read(baseaddr, RFA_AD_CS, 0x71);
			regVal = (regVal & ~0x1F) | bitsToSet_reg71;
			ad_spi_write(baseaddr, RFA_AD_CS, 0x71, regVal);
		}
		if(csMask & RFB_AD_CS) {
			regVal = (u8)(ad_spi_read(baseaddr, RFB_AD_CS, 0x71)>>8);
			regVal = (regVal & ~0x1F) | bitsToSet_reg71;
			ad_spi_write(baseaddr, RFB_AD_CS, 0x71, regVal);
		}
		if(csMask & RFC_AD_CS) {
			regVal = (u8)(ad_spi_read(baseaddr, RFC_AD_CS, 0x71)>>8);
			regVal = (regVal & ~0x1F) | bitsToSet_reg71;
			ad_spi_write(baseaddr, RFC_AD_CS, 0x71, regVal);
		}
		if(csMask & RFD_AD_CS) {
			regVal = (u8)(ad_spi_read(baseaddr, RFD_AD_CS, 0x71)>>8);
			regVal = (regVal & ~0x1F) | bitsToSet_reg71;
			ad_spi_write(baseaddr, RFD_AD_CS, 0x71, regVal);
		}

		//Other registers are DLL-only, so we can write both ADs together
		
		//Set DLL_DIV and DLL_M
		ad_spi_write(baseaddr, csMask, 0x72, ((DLL_DIV&0x3)<<5) | (DLL_M & 0x1F));

		//Release DLL reset (treating as active high)
		#ifdef rc_usleep
		rc_usleep(100);
		#else
		volatile int i;
		for(i=0; i<1000; i++)
			i++;
		#endif
		ad_spi_write(baseaddr, csMask, 0x75, 0x00);

		//Wait for both DLLs to lock
		while( (lockAttempts > 0) && ( (ad_spi_read(baseaddr, csMask, 0x72) & 0x8080) != 0x8080) ) {lockAttempts--; print(".");}
		
		//If the wait-for-lock loop timed out, return an error
		if(lockAttempts == 0) return -2;
		else return 0;
	}
	
	
}

/**
\brief Shuts down or enables the selected AD9963. Starting up from shutdown is not instantaneous, so this function should only be used to
disable an AD9963 that will be unsed for a while. If you shutdown a AD9963, you should also shutdown the corresponding MAX2829 with radio_controller_setMode_shutdown().
<b>Note:</b> this function will always leave the AD9963 DLL shutdown. You must call ad_config_DLL() again to re-configure and re-enable the DLL
if your design uses the DLL clock for ADCs or DACs.
\param baseaddr Base memory address of w3_ad_controller pcore
\param csMask OR'd combination of RFA_AD_CS and RFB_AD_CS
\param pwrState Desired AD9963 power state; must be one of [AD_PWR_ALLOFF, AD_PWR_ALLON]
\return Returns 0 on success, -1 for invalid paramters
*/
int ad_config_power(u32 baseaddr, u32 csMask, u8 pwrState) {
	u8 regVal;
	
	//Sanity check inputs
	if( ((csMask & (AD_CTRL_ALL_RF_CS)) == 0))
		return -1;

	/* AD9963 reg 0x60:
		7: 0=power down DLL
		[6:0] 1=power down [DAC refrerence, IDAC, QDAC, clock input, ADC reference, QADC, IADC]
	*/

	//This funtion intentionally powers off the DLL, whether the user asks for all-on or all-off
	// This seemed like the safest approach, since the DLL requries an explicit reset whenever its config
	// changes or when it is powered up. This reset is done in the ad_config_DLL() function in the correct
	// order to bring the DLL up in a good state.

	if(pwrState == AD_PWR_ALLOFF) regVal = 0x3F; //everything powered down
	else if(pwrState == AD_PWR_ALLON) regVal = 0x00; //DLL off, everything else on
	else return -1; //invalid input

	ad_spi_write(baseaddr, csMask, 0x60, regVal);
		
	return 0;
}
/** @}*/ //END group user_functions
