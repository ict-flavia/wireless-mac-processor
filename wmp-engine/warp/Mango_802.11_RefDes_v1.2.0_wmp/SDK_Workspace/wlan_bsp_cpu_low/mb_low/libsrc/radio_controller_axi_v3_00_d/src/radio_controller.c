/*****************************************************************
* File: w3_ad_controller.c
* Copyright (c) 2012 Mango Communications, all rights reseved
* Released under the WARP License
* See http://warp.rice.edu/license for details
*****************************************************************/

/** \file radio_controller.c

\mainpage
This is the driver for the radio_controller core, which implements an SPI master for controlling
the AD9963 analog converters for the WARP v3 RF interfaces.

@version 3.00.b
@author Patrick Murphy
@copyright (c) 2012 Mango Communications, Inc. All rights reserved.<br>
Released under the WARP open source license (see http://warp.rice.edu/license)

\brief Main source for radio_controller driver

*/

#include "radio_controller.h"
#include "xparameters.h"

#if defined XPAR_W3_IIC_EEPROM_NUM_INSTANCES && defined XPAR_W3_AD_CONTROLLER_NUM_INSTANCES
#include "w3_ad_controller.h"
#include "w3_iic_eeprom.h"
#endif

static u16 rc_tuningParams_24GHz_freqs[14] = { 2412,   2417,   2422,   2427,   2432,   2437,   2442,   2447,   2452,   2457,   2462,   2467,   2472,   2484};
static u16 rc_tuningParams_24GHz_reg3[14] = {0x00A0, 0x20A1, 0x30A1, 0x00A1, 0x20A2, 0x30A2, 0x00A2, 0x20A3, 0x30A3, 0x00A3, 0x20A4, 0x30A4, 0x00A4, 0x10A5};
static u16 rc_tuningParams_24GHz_reg4[14] = {0x3333, 0x0888, 0x1DDD, 0x3333, 0x0888, 0x1DDD, 0x3333, 0x0888, 0x1DDD, 0x3333, 0x0888, 0x1DDD, 0x3333, 0x2666};

static u16 rc_tuningParams_5GHz_freqs[23] = { 5180,   5200,   5220,   5240,   5260,   5280,   5300,   5320,   5500,   5520,   5540,   5560,   5580,   5600,   5620,   5640,   5660,   5680,   5700,   5745,   5765,   5785,   5805};
static u16 rc_tuningParams_5GHz_reg3[23] = {0x30CF, 0x0CCC, 0x00D0, 0x10D1, 0x20D2, 0x30D3, 0x00D4, 0x00D4, 0x00DC, 0x00DC, 0x10DD, 0x20DE, 0x30DF, 0x00E0, 0x00E0, 0x10E1, 0x20E2, 0x30E3, 0x00E4, 0x00E5, 0x10E6, 0x20E7, 0x30E8}; 
static u16 rc_tuningParams_5GHz_reg4[23] = {0x0CCC, 0x0000, 0x3333, 0x2666, 0x1999, 0x0CCC, 0x0000, 0x3333, 0x0000, 0x3333, 0x2666, 0x1999, 0x0CCC, 0x0000, 0x3333, 0x2666, 0x1999, 0x0CCC, 0x0000, 0x3333, 0x2666, 0x1999, 0x0CCC};

/**
\defgroup user_functions Functions
\brief Functions to call from user code
\addtogroup user_functions

Example:
\code{.c}
//Assumes user code sets RC_BASEADDR to base address of radio_controller core, as set in xparameters.h

//Initialize the radio controller logic
radio_controller_init(RC_CONTROLLER, 1, 1);

\endcode

@{
*/

/**
\brief Initializes the radio controller core and the selected MAX2829 transceivers. The selected transceivers
are reset, configured with sane defaults and set to the Standby state. User code should call this function once
at boot for all RF interfaces.
\param ba Base memory address of radio_controller pcore
\param rfSel Selects RF interface to initialize (OR'd combination of [RC_RFA, RC_RFB, RC_RFC, RC_RFD])
\param clkDiv_SPI Clock divider for SPI serial clock (set to 3 for 160MHz bus)
\param clkDiv_TxDelays Clock divider for Tx sequencing state machine (set to 1 for normal operation)
\return Returns -1 if any MAX2829 indicates no PLL lock after init; otherwise returns 0
*/
int radio_controller_init(u32 ba, u32 rfSel, u8 clkDiv_SPI, u8 clkDiv_TxDelays) {

	//Sanity check arguments
	if(((rfSel & RC_ANY_RF)==0) || (clkDiv_SPI>7) || (clkDiv_TxDelays>3))
		return RC_INVALID_PARAM;

	//Radio controller init procedure:
	// -Set clock dividers for MAX2829 SPI and TxTiming state machines
	// -Set MAX2829 state to RESET
	// -Set MAX2829 state to SHDN
	// -Configure MAX2829 to sane defaults (see comments above each radio_controller_SPI_setRegBits call below)

	
	/************ FIXME: reg2 in user_logic.v init value is bogus *************/
	Xil_Out32(ba+RC_SLV_REG2_OFFSET, 0);
	
	u32 rfCtrlMask = 0;
	u32 pll_lock_status;
	u32 pll_lock_wait_tries = 0;
	
	radio_controller_setClkDiv_SPI(ba, clkDiv_SPI);
	radio_controller_setClkDiv_TxDelays(ba, clkDiv_TxDelays);

	//Convert the user-supplied masks to the masks for the control registers
	if(rfSel & RC_RFA) rfCtrlMask |= RC_CTRLREGMASK_RFA;
	if(rfSel & RC_RFB) rfCtrlMask |= RC_CTRLREGMASK_RFB;
	if(rfSel & RC_RFC) rfCtrlMask |= RC_CTRLREGMASK_RFC;
	if(rfSel & RC_RFD) rfCtrlMask |= RC_CTRLREGMASK_RFD;

	radio_controller_setMode_shutdown(ba, rfCtrlMask);
	radio_controller_setMode_reset(ba, rfCtrlMask);
	rc_usleep(1000);
	radio_controller_setMode_shutdown(ba, rfCtrlMask);
	rc_usleep(1000);
	
	//MAX2829 reg2:
	// -MIMO mode (reg2[13]=1)
	// -Other bits set to defaults
	radio_controller_SPI_write(ba, rfSel, 2, 0x3007);
	
	//MAX2829 reg5:
	// -40MHz reference clock (reg5[3:1]=[0 1 0])
	// -MIMO mode (reg5[13]=1)
	// -Other bits set to defaults
	radio_controller_SPI_write(ba, rfSel, 5, 0x3824);

	//MAX2829 reg8:
	// -RSSI output in [0.5,2.5]v (reg8[11]=1)
	// -RSSI output always on in Rx mode (reg8[10]=1)
	// -Other bits set to defaults
	radio_controller_SPI_write(ba, rfSel, 8, 0x0C25);
	
	//MAX2829 reg9:
	// -Max linearity for Tx PA driver (reg9[9:8]=[1 1]
	// -Max linearity for Tx VGA (reg9[7:6]=[1 1])
	// -Max linearity for upconverter (reg9[3:2]=[1 1])
	// -Tx baseband gain set to (max-3dB) (reg9[1:0]=[1 0])
	radio_controller_SPI_write(ba, rfSel, 9, 0x03CD);


	//Finally bring the MAX2829 out of shutdown
	// The PLL should lock (LD -> 1) shortly after this call
	radio_controller_setMode_standby(ba, rfCtrlMask);

	pll_lock_status = 0;
	
	while(pll_lock_status != (RC_REG11_LD & rfCtrlMask)) {
		rc_usleep(5000);
		pll_lock_status = Xil_In32(ba + RC_SLV_REG11_OFFSET) & RC_REG11_LD & rfCtrlMask;
		pll_lock_wait_tries++;
		if(pll_lock_wait_tries > 1000) {
			xil_printf("Radios didn't lock! RC stat reg: 0x%08x\n", Xil_In32(ba + RC_SLV_REG11_OFFSET));
			return -1;
		}
	}
//	xil_printf("Radios locked after %d tries\n", pll_lock_wait_tries);


	//Set sane defaults
	radio_controller_setTxDelays(ba, 150, 0, 0, 250);
	radio_controller_setTxGainTiming(ba, 0xF, 3);

	return 0;
}

/**
\brief Sets the selected RF interfaces to the Transmit state. The corresponding MAX2829s, PAs and RF switches are all
set to the correct state for transmission. This call initiates the Tx sequencing state machine. Refer to the
<a href="http://warp.rice.edu/trac/wiki/cores/radio_controller">radio_controller user guide</a> for more details.
\param ba Base memory address of radio_controller pcore
\param rfSel Selects RF interfaces to affect (OR'd combination of [RC_RFA, RC_RFB, RC_RFC, RC_RFD])
\return Returns non-zero value if an input parameter was invalid; else returns 0
*/
int radio_controller_TxEnable(u32 ba, u32 rfSel) {

	u32 rfCtrlMask, oldVal, newVal;

	if((rfSel & RC_ANY_RF)==0)
		return RC_INVALID_RFSEL;

	rfCtrlMask = 0;
		
	//Convert the user-supplied masks to the masks for the control registers
	if(rfSel & RC_RFA) rfCtrlMask = rfCtrlMask | RC_CTRLREGMASK_RFA;
	if(rfSel & RC_RFB) rfCtrlMask = rfCtrlMask | RC_CTRLREGMASK_RFB;
	if(rfSel & RC_RFC) rfCtrlMask = rfCtrlMask | RC_CTRLREGMASK_RFC;
	if(rfSel & RC_RFD) rfCtrlMask = rfCtrlMask | RC_CTRLREGMASK_RFD;

	oldVal = Xil_In32(ba + RC_SLV_REG0_OFFSET);
	
	//Force RxEn=0, SHDN=1 for radios selected by rfsel
	oldVal = (oldVal & (~(rfCtrlMask & RC_REG0_RXEN))) | (rfCtrlMask & RC_REG0_SHDN);
	
	newVal = oldVal | (rfCtrlMask & RC_REG0_TXEN);
	
	Xil_Out32(ba + RC_SLV_REG0_OFFSET, newVal);
	
//	radio_controller_setMode_standby(ba, rfCtrlMask);
//	radio_controller_setMode_Tx(ba, rfCtrlMask);

	return 0;
}

/**
\brief Sets the selected RF interfaces to the Receive state. The corresponding MAX2829s and RF switches are
set to the correct state for reception. The PAs in the selected RF interfaces are disabled.
\param ba Base memory address of radio_controller pcore
\param rfSel Selects RF interfaces to affect (OR'd combination of [RC_RFA, RC_RFB, RC_RFC, RC_RFD])
\return Returns non-zero value if an input parameter was invalid; else returns 0
*/
int radio_controller_RxEnable(u32 ba, u32 rfSel) {

	u32 rfCtrlMask, oldVal, newVal;;

	if((rfSel & RC_ANY_RF)==0)
		return RC_INVALID_RFSEL;
		
	rfCtrlMask = 0;
		
	//Convert the user-supplied masks to the masks for the control registers
	if(rfSel & RC_RFA) rfCtrlMask = rfCtrlMask | RC_CTRLREGMASK_RFA;
	if(rfSel & RC_RFB) rfCtrlMask = rfCtrlMask | RC_CTRLREGMASK_RFB;
	if(rfSel & RC_RFC) rfCtrlMask = rfCtrlMask | RC_CTRLREGMASK_RFC;
	if(rfSel & RC_RFD) rfCtrlMask = rfCtrlMask | RC_CTRLREGMASK_RFD;

	oldVal = Xil_In32(ba + RC_SLV_REG0_OFFSET);
	
	//Force TxEn=0, SHDN=1 for radios selected by rfsel
	oldVal = (oldVal & (~(rfCtrlMask & RC_REG0_TXEN))) | (rfCtrlMask & RC_REG0_SHDN);
	
	newVal = oldVal | (rfCtrlMask & RC_REG0_RXEN);
	
	Xil_Out32(ba + RC_SLV_REG0_OFFSET, newVal);

//	radio_controller_setMode_standby(ba, rfCtrlMask);
//	radio_controller_setMode_Rx(ba, rfCtrlMask);

	return 0;
}

/**
\brief Sets the selected RF interfaces to the Standby state (Tx and Rx disabled). The corresponding MAX2829s and PAs are
set to the correct state for standby.
\param ba Base memory address of radio_controller pcore
\param rfSel Selects RF interfaces to affect (OR'd combination of [RC_RFA, RC_RFB, RC_RFC, RC_RFD])
\return Returns non-zero value if an input parameter was invalid; else returns 0
*/
int radio_controller_TxRxDisable(u32 ba, u32 rfSel) {

	u32 rfCtrlMask = 0;

	if((rfSel & RC_ANY_RF)==0)
		return RC_INVALID_RFSEL;
		
	//Convert the user-supplied masks to the masks for the control registers
	if(rfSel & RC_RFA) rfCtrlMask |= RC_CTRLREGMASK_RFA;
	if(rfSel & RC_RFB) rfCtrlMask |= RC_CTRLREGMASK_RFB;
	if(rfSel & RC_RFC) rfCtrlMask |= RC_CTRLREGMASK_RFC;
	if(rfSel & RC_RFD) rfCtrlMask |= RC_CTRLREGMASK_RFD;

	radio_controller_setMode_standby(ba, rfCtrlMask);

	return 0;
}

/**
\brief Sets the selected RF interfaces to the Standby state (Tx and Rx disabled). The corresponding MAX2829s and PAs are
set to the correct state for standby.
\param ba Base memory address of radio_controller pcore
\param rfSel Selects RF interfaces to affect (OR'd combination of [RC_RFA, RC_RFB, RC_RFC, RC_RFD])
\param bandSel Selects the 2.4GHz or 5GHz band; must be RC_24GHZ or RC_5GHZ
\param chanNum New center frequency channel number, in [1,14] for 2.4GHz or [1,23] for 5GHz. The channel numbers
and corresponding center frequencies are listed in the table below.
\return Returns non-zero value if an input parameter was invalid; else returns 0

2.4GHz <br> Chan | Freq <br> (MHz) | | 5GHz <br> Chan | Freq <br> (MHz)
--- | ----- | - | --- | -----
1 | 2412 |  | 1 | 5180
2 | 2417 |  | 2 | 5200
3 | 2422 |  | 3 | 5220
4 | 2427 |  | 4 | 5240
5 | 2432 |  | 5 | 5260
6 | 2437 |  | 6 | 5280
7 | 2442 |  | 7 | 5300
8 | 2447 |  | 8 | 5320
9 | 2452 |  | 9 | 5500
10 | 2457 |  | 10 | 5520
11 | 2462 |  | 11 | 5540
12 | 2467 |  | 12 | 5560
13 | 2472 |  | 13 | 5580
14 | 2484 |  | 14 | 5600
- | - | | 15 | 5620
- | - | | 16 | 5640
- | - | | 17 | 5660
- | - | | 18 | 5680
- | - | | 19 | 5700
- | - | | 20 | 5745
- | - | | 21 | 5765
- | - | | 22 | 5785
- | - | | 23 | 5805
*/
int radio_controller_setCenterFrequency(u32 ba, u32 rfSel, u8 bandSel, u8 chanNum) {

	if((bandSel == RC_24GHZ) && (chanNum >= 1) && (chanNum <= 14) && (rfSel & RC_ANY_RF)){ //14 valid 2.4GHz channels
		//MAX2829 tuning process for 2.4GHz channels:
		// -Set reg5[0] to 0 (selects 2.4GHz)
		// -Set reg3, reg4 with PLL tuning params

		radio_controller_SPI_setRegBits(ba, rfSel, 5, 0x1, 0x0);

		//Write the PLL parameters
		radio_controller_SPI_write(ba, rfSel, 3, rc_tuningParams_24GHz_reg3[chanNum-1]);
		radio_controller_SPI_write(ba, rfSel, 4, rc_tuningParams_24GHz_reg4[chanNum-1]);

		return(rc_tuningParams_24GHz_freqs[chanNum-1]);
	}

	if((bandSel == RC_5GHZ) && (chanNum >= 1) && (chanNum <= 23) && (rfSel & RC_ANY_RF)) { //23 valid 5GHz channels
		//MAX2829 tuning process for 5GHz channels:
		//(Assumes default config of 5GHz sub-band tuning via FSM; see MAX2829 datasheet for details)
		// -Set:
		//   -reg5[0] to 1 (selects 5GHz)
		//   -reg5[6] based on selected freq (0:4.9-5.35GHz, 1:5.47-5.875GHz)
		// -Set reg3, reg4 with PLL tuning params

		if(chanNum<=8)
			radio_controller_SPI_setRegBits(ba, rfSel, 5, 0x41, 0x01);
		else
			radio_controller_SPI_setRegBits(ba, rfSel, 5, 0x41, 0x41);
		
		//Write the PLL parameters
		radio_controller_SPI_write(ba, rfSel, 3, rc_tuningParams_5GHz_reg3[chanNum-1]);
		radio_controller_SPI_write(ba, rfSel, 4, rc_tuningParams_5GHz_reg4[chanNum-1]);

		return(rc_tuningParams_5GHz_freqs[chanNum-1]);
	}
	
	//Some input param was invalid if we get here, so return an invalid frequency
	return RC_INVALID_PARAM;
}

/**
\brief Reads the radio controller "mirror" register corresponding to the MAX2829 register at regAddr
\param ba Base memory address of radio_controller pcore
\param rfSel Selects RF interface to read (must be one of [RC_RFA, RC_RFB, RC_RFC, RC_RFD])
\param regAddr Register address to read, in [0x0,0xC]
\return Returns 255 if input parameters are invalid; otherwise returns 14-bit register value
*/
u16 radio_controller_SPI_read(u32 ba, u32 rfSel, u8 regAddr) {
	if(((rfSel & RC_ANY_RF)==0) || (regAddr>0xC))
		return 255; //impossible value for 14-bit registers; use for error checking

	//Use Xil_In32 to grab 16LSB of each register (Xil_In16 reads 16MSB of 32-bit register when address is aligned to 4 bytes)
	if(rfSel & RC_RFA)
		return (u16)(0xFFFF & Xil_In32(ba + RC_SPI_MIRRORREGS_RFA_BASEADDR + 4*regAddr));

	if(rfSel & RC_RFB)
		return (u16)(0xFFFF & Xil_In32(ba + RC_SPI_MIRRORREGS_RFB_BASEADDR + 4*regAddr));

	if(rfSel & RC_RFC)
		return (u16)(0xFFFF & Xil_In32(ba + RC_SPI_MIRRORREGS_RFC_BASEADDR + 4*regAddr));

	if(rfSel & RC_RFD)
		return (u16)(0xFFFF & Xil_In32(ba + RC_SPI_MIRRORREGS_RFD_BASEADDR + 4*regAddr));

	//Can't get here, but return error anyway so compiler doesn't complain
	return 254;
}

/**
\brief Sets specific bits in a single register in selected MAX2829s
\param ba Base memory address of radio_controller pcore
\param rfSel Selects RF interfaces to affect (OR'd combination of [RC_RFA, RC_RFB, RC_RFC, RC_RFD])
\param regAddr Register address to write, in [0x0,0xC]
\param regDataMask 14-bit mask of bits to affect (1 in mask selects bit for writing)
\param regData 14-bit value to set; only bits with 1 in regDataMask are used
\return Returns non-zero if input parameters are invalid; otherwise returns 0
*/
int radio_controller_SPI_setRegBits(u32 ba, u32 rfSel, u8 regAddr, u16 regDataMask, u16 regData) {
	u16 curRegData;
	u16 newRegData;
	
	if(((rfSel & RC_ANY_RF)==0) || (regAddr>13))
		return RC_INVALID_RFSEL;

	if(rfSel & RC_RFA) {
		curRegData = radio_controller_SPI_read(ba, RC_RFA, regAddr);
		newRegData = ((curRegData & ~regDataMask) | (regData & regDataMask));
		radio_controller_SPI_write(ba, RC_RFA, regAddr, newRegData);
	}
	if(rfSel & RC_RFB) {
		curRegData = radio_controller_SPI_read(ba, RC_RFB, regAddr);
		newRegData = ((curRegData & ~regDataMask) | (regData & regDataMask));
		radio_controller_SPI_write(ba, RC_RFB, regAddr, newRegData);
	}
	if(rfSel & RC_RFC) {
		curRegData = radio_controller_SPI_read(ba, RC_RFC, regAddr);
		newRegData = ((curRegData & ~regDataMask) | (regData & regDataMask));
		radio_controller_SPI_write(ba, RC_RFC, regAddr, newRegData);
	}
	if(rfSel & RC_RFD) {
		curRegData = radio_controller_SPI_read(ba, RC_RFD, regAddr);
		newRegData = ((curRegData & ~regDataMask) | (regData & regDataMask));
		radio_controller_SPI_write(ba, RC_RFD, regAddr, newRegData);
	}

	return 0;	
}

/**
\brief Sets state of RXHP pin on selected MAX2829s. This function only affects state if the RXHP control
source is set to software on the selected RF interfaces.
\param ba Base memory address of radio_controller pcore
\param rfSel Selects RF interfaces to affect (OR'd combination of [RC_RFA, RC_RFB, RC_RFC, RC_RFD])
\param mode RXHP is asserted if mode=RC_RXHP_ON, else RXHP is deasserted
\return Returns non-zero if input parameters are invalid; otherwise returns 0
*/
int radio_controller_setRxHP(u32 ba, u32 rfSel, u8 mode) {
	//Sanity check inputs
	if((rfSel & RC_ANY_RF) == 0)
		return RC_INVALID_RFSEL;

	if(mode > 1)
		return RC_INVALID_PARAM;

	u32 rfCtrlMask = 0;
	
	//Convert the user-supplied masks to the masks for the control registers
	if(rfSel & RC_RFA) rfCtrlMask |= RC_CTRLREGMASK_RFA;
	if(rfSel & RC_RFB) rfCtrlMask |= RC_CTRLREGMASK_RFB;
	if(rfSel & RC_RFC) rfCtrlMask |= RC_CTRLREGMASK_RFC;
	if(rfSel & RC_RFD) rfCtrlMask |= RC_CTRLREGMASK_RFD;

	u32 curRegVal, newRegVal;

	curRegVal = Xil_In32(ba+RC_SLV_REG0_OFFSET);
	
	if(mode == RC_RXHP_ON) {
		//Assert RxHP bits in reg0; drives 1 to corresponding RxHP pin on MAX2829
		newRegVal = curRegVal | (RC_REG0_RXHP & rfCtrlMask);
	} else {
		newRegVal = curRegVal & (~(RC_REG0_RXHP & rfCtrlMask));
	}
	
	Xil_Out32(ba+RC_SLV_REG0_OFFSET, newRegVal);

	return 0;
}

/**
\brief Selects between register or hardware control for the various radio control signals on the selected RF interfaces.
\param ba Base memory address of radio_controller pcore
\param rfSel Selects RF interfaces to affect (OR'd combination of [RC_RFA, RC_RFB, RC_RFC, RC_RFD])
\param ctrlSrcMask Specifies which control signals should have new control source; OR'd combination of [RC_REG0_TXEN_CTRLSRC, RC_REG0_RXEN_CTRLSRC, RC_REG0_RXHP_CTRLSRC, RC_REG0_SHDN_CTRLSRC]
\param ctrlSrc Selects register (from C code) or hardware (usr_ ports) control; must be RC_CTRLSRC_REG or RC_CTRLSRC_HW
\return Returns non-zero if input parameters are invalid; otherwise returns 0
*/
int radio_controller_setCtrlSource(u32 ba, u32 rfSel, u32 ctrlSrcMask, u8 ctrlSrc) {

	//Sanity check inputs
	if((rfSel & RC_ANY_RF) == 0)
		return RC_INVALID_RFSEL;

	if((ctrlSrcMask & RC_REG0_ALL_CTRLSRC) == 0)
		return RC_INVALID_PARAM;

	u32 rfCtrlMask = 0;
	
	//Convert the user-supplied masks to the masks for the control registers
	if(rfSel & RC_RFA) rfCtrlMask |= RC_CTRLREGMASK_RFA;
	if(rfSel & RC_RFB) rfCtrlMask |= RC_CTRLREGMASK_RFB;
	if(rfSel & RC_RFC) rfCtrlMask |= RC_CTRLREGMASK_RFC;
	if(rfSel & RC_RFD) rfCtrlMask |= RC_CTRLREGMASK_RFD;

	u32 curRegVal, newRegVal;

	curRegVal = Xil_In32(ba+RC_SLV_REG0_OFFSET);
	
	if(ctrlSrc == RC_CTRLSRC_HW) {
		//Hardware control via usr_* ports enabled by 1 in reg0 ctrlSrc bits
		newRegVal = curRegVal | (ctrlSrcMask & rfCtrlMask & RC_REG0_ALL_CTRLSRC);
	} else {
		//Software control via writes to reg0 (RC_REG0_TXEN, RC_REG0_RXEN, etc.)
		newRegVal = curRegVal & (~(ctrlSrcMask & rfCtrlMask & RC_REG0_ALL_CTRLSRC));
	}
	
	Xil_Out32(ba+RC_SLV_REG0_OFFSET, newRegVal);

	return 0;
}

/**
\brief Sets the final Tx VGA gain set by the Tx sequencing state machine for the selected RF interfaces
\param ba Base memory address of radio_controller pcore
\param rfSel Selects RF interfaces to affect (OR'd combination of [RC_RFA, RC_RFB, RC_RFC, RC_RFD])
\param gainTarget Tx VGA gain setting, in [0,63]
\return Returns non-zero if input parameters are invalid; otherwise returns 0
*/
int radio_controller_setTxGainTarget(u32 ba, u32 rfSel, u8 gainTarget) {
	//Sanity check inputs
	if(((rfSel & RC_ANY_RF)==0))
		return RC_INVALID_RFSEL;

	u32 regVal;

	regVal = Xil_In32(ba+RC_SLV_REG2_OFFSET);
	
	if(rfSel & RC_RFA)
		regVal = (regVal & ~(0x0000003F)) | ((gainTarget<< 0) & 0x0000003F);
	if(rfSel & RC_RFB)
		regVal = (regVal & ~(0x00003F00)) | ((gainTarget<< 8) & 0x00003F00);
	if(rfSel & RC_RFC)
		regVal = (regVal & ~(0x003F0000)) | ((gainTarget<<16) & 0x003F0000);
	if(rfSel & RC_RFD)
		regVal = (regVal & ~(0x3F000000)) | ((gainTarget<<24) & 0x3F000000);
	
	Xil_Out32(ba+RC_SLV_REG2_OFFSET, regVal);

	return 0;
}

/**
\brief Sets the control source for Tx gains in the selected RF interfaces
\param ba Base memory address of radio_controller pcore
\param rfSel Selects RF interfaces to affect (OR'd combination of [RC_RFA, RC_RFB, RC_RFC, RC_RFD])
\param gainSrc must be one of [RC_GAINSRC_SPI, RC_GAINSRC_REG, RC_GAINSRC_HW], for SPI control, register control or hardware (usr_RFx_TxGain port) control
\return Returns non-zero if input parameters are invalid; otherwise returns 0
*/
int radio_controller_setTxGainSource(u32 ba, u32 rfSel, u8 gainSrc) {

	//Sanity check inputs
	if(((rfSel & RC_ANY_RF)==0))
		return RC_INVALID_RFSEL;

	u32 rfCtrlMask = 0;
	u32 curRegVal, newRegVal;
	
	//Convert the user-supplied masks to the masks for the control registers
	if(rfSel & RC_RFA) rfCtrlMask |= RC_CTRLREGMASK_RFA;
	if(rfSel & RC_RFB) rfCtrlMask |= RC_CTRLREGMASK_RFB;
	if(rfSel & RC_RFC) rfCtrlMask |= RC_CTRLREGMASK_RFC;
	if(rfSel & RC_RFD) rfCtrlMask |= RC_CTRLREGMASK_RFD;

	if(gainSrc == RC_GAINSRC_SPI) {
		//Configure MAX2829 for Tx gain control via SPI
		radio_controller_setRadioParam(ba, rfSel, RC_PARAMID_TXGAINS_SPI_CTRL_EN, 1);
		return 0;
	}
	else if(gainSrc == RC_GAINSRC_HW) {
		//Disable SPI Tx gain control in MAX2829
		radio_controller_setRadioParam(ba, rfSel, RC_PARAMID_TXGAINS_SPI_CTRL_EN, 0);
		
		//Configure radio controller for Tx gain target from usr_ ports in logic
		curRegVal = Xil_In32(ba+RC_SLV_REG2_OFFSET);
		newRegVal = (curRegVal | (rfCtrlMask & RC_REG2_TXGAIN_CTRLSRC));
		Xil_Out32(ba+RC_SLV_REG2_OFFSET, newRegVal);
		return 0;
	}
	else if(gainSrc == RC_GAINSRC_REG) {
		//Disable SPI Tx gain control in MAX2829
		radio_controller_setRadioParam(ba, rfSel, RC_PARAMID_TXGAINS_SPI_CTRL_EN, 0);
	
		//Configure radio controller for Tx gain target from registers
		curRegVal = Xil_In32(ba+RC_SLV_REG2_OFFSET);
		newRegVal = (curRegVal & ~(rfCtrlMask & RC_REG2_TXGAIN_CTRLSRC));
		Xil_Out32(ba+RC_SLV_REG2_OFFSET, newRegVal);
		return 0;
	}
		
	//gainSrc must have been invalid if we get here
	return RC_INVALID_PARAM;
}

/**
\brief Sets the control source for Rx gains in the selected RF interfaces. Note that when hardware control is selected, the corresponding 
RXHP should also be set for hardware control using radio_controller_setCtrlSource().
\param ba Base memory address of radio_controller pcore
\param rfSel Selects RF interfaces to affect (OR'd combination of [RC_RFA, RC_RFB, RC_RFC, RC_RFD])
\param gainSrc must be one of [RC_GAINSRC_SPI, RC_GAINSRC_REG, RC_GAINSRC_HW], for SPI control, register control or hardware (usr_RFx_TxGain port) control
\return Returns non-zero if input parameters are invalid; otherwise returns 0
*/
int radio_controller_setRxGainSource(u32 ba, u32 rfSel, u8 gainSrc) {
	//Sanity check inputs
	if(((rfSel & RC_ANY_RF)==0))
		return RC_INVALID_RFSEL;

	u32 rfCtrlMask = 0;
	u32 curRegVal, newRegVal;
	
	//Convert the user-supplied masks to the masks for the control registers
	if(rfSel & RC_RFA) rfCtrlMask |= RC_CTRLREGMASK_RFA;
	if(rfSel & RC_RFB) rfCtrlMask |= RC_CTRLREGMASK_RFB;
	if(rfSel & RC_RFC) rfCtrlMask |= RC_CTRLREGMASK_RFC;
	if(rfSel & RC_RFD) rfCtrlMask |= RC_CTRLREGMASK_RFD;

	if(gainSrc == RC_GAINSRC_SPI) {
		//Configure MAX2829 for Tx gain control via SPI
		radio_controller_setRadioParam(ba, rfSel, RC_PARAMID_RXGAINS_SPI_CTRL_EN, 1);
		return 0;
	}
	else if(gainSrc == RC_GAINSRC_REG) {
		//Disable SPI Rx gain control in MAX2829
		radio_controller_setRadioParam(ba, rfSel, RC_PARAMID_RXGAINS_SPI_CTRL_EN, 0);
		
		//Configure radio controller for Rx gains from registers
		curRegVal = Xil_In32(ba+RC_SLV_REG3_OFFSET);
		newRegVal = (curRegVal & ~(rfCtrlMask & RC_REG3_RXGAIN_CTRLSRC));
		Xil_Out32(ba+RC_SLV_REG3_OFFSET, newRegVal);
		return 0;
	}
	else if(gainSrc == RC_GAINSRC_HW) {
		//Disable SPI Rx gain control in MAX2829
		radio_controller_setRadioParam(ba, rfSel, RC_PARAMID_RXGAINS_SPI_CTRL_EN, 0);
		
		//Configure radio controller for Tx gains from usr_ ports in logic
		curRegVal = Xil_In32(ba+RC_SLV_REG3_OFFSET);
		newRegVal = (curRegVal | (rfCtrlMask & RC_REG3_RXGAIN_CTRLSRC));
		Xil_Out32(ba+RC_SLV_REG3_OFFSET, newRegVal);
		return 0;
	}
		
	//gainSrc must have been invalid if we get here
	return RC_INVALID_PARAM;

}

/**
\brief Sets a MAX2829 parameter via a SPI register write.
\param ba Base memory address of radio_controller pcore
\param rfSel Selects RF interfaces to affect (OR'd combination of [RC_RFA, RC_RFB, RC_RFC, RC_RFD])
\param paramID Parameter ID to update. Must be valid RC_PARAMID_* (see table below)
\param paramVal Parameter value to set. Valid values depend on the selected parameter (see table below)
\return Returns non-zero if input parameters are invalid; otherwise returns 0

Parameter ID | Description | Parameter Values
------------ | ----------- | ----------------
RC_PARAMID_RXGAIN_RF | Rx RF gain value | 1: 0dB<br>2: 15dB<br>3: 30dB
RC_PARAMID_RXGAIN_BB | Rx baseband gain value | [0,31]: approx [0,63]dB
RC_PARAMID_TXGAIN_RF | Tx RF gain value | [0,63]: approx [0,31]dB
RC_PARAMID_TXGAIN_BB | Tx baseband gain value | 0: 0<br>1: -1.5dB<br>2: -3dB<br>3: -5dB
RC_PARAMID_TXLPF_BW | Tx low pass filter corner frequency<br> (Tx bandwidth is 2x corner frequency) | 1: 12MHz<br>2: 18MHz<br>3: 24MHz
RC_PARAMID_RXLPF_BW | Rx low pass filter corner frequency<br> (Rx bandwidth is 2x corner frequency) | 0: 7.5MHz<br>1: 9.5MHz<br>2: 14MHz<br>3: 18MHz
RC_PARAMID_RXLPF_BW_FINE | Rx low pass filter corner fine adjustment | 0: 90%<br>1: 95%<br>2: 100%<br>3: 105%<br>4: 110%
RC_PARAMID_RXHPF_HIGH_CUTOFF_EN | Set corner frequency for Rx high pass filter when RXHP=0| 0: Low corner (100Hz)<br>1: High corner (30kHz)
RC_PARAMID_RSSI_HIGH_BW_EN | En/disable high bandwidth RSSI signal | 0: Disable high bandwidth RSSI<br>1: Enable high bandwidth RSSI
RC_PARAMID_TXLINEARITY_PADRIVER | Linearity of Tx PA driver circuit | [0,3]: [min,max] linearity
RC_PARAMID_TXLINEARITY_VGA | Linearity of Tx VGA circuit | [0,3]: [min,max] linearity
RC_PARAMID_TXLINEARITY_UPCONV | Linearity of Tx upconverter circuit | [0,3]: [min,max] linearity 
RC_PARAMID_TXGAINS_SPI_CTRL_EN |  En/disable SPI control of Tx gains | 0: Disable SPI control<br>1: Enable SPI control
RC_PARAMID_RXGAINS_SPI_CTRL_EN |  En/disable SPI control of Rx gains | 0: Disable SPI control<br>1: Enable SPI control

*/
int radio_controller_setRadioParam(u32 ba, u32 rfSel, u32 paramID, u32 paramVal) {
	u16 curRegData;
	u16 newRegData;

	u16 x, y;

	//Sanity check inputs
	if(((rfSel & RC_ANY_RF)==0))
		return RC_INVALID_RFSEL;
		
		
	switch(paramID) {
#ifdef RC_INCLUDED_PARAMS_GAIN_CTRL
		case RC_PARAMID_TXGAINS_SPI_CTRL_EN:
			//reg9[10]: 0=B port controls Tx VGA gain, 1=SPI regC[5:0] controls Tx VGA gain
			if(paramVal > 1) return RC_INVALID_PARAM;
			x = paramVal ? 0x0400 : 0x0000;
			return radio_controller_SPI_setRegBits(ba, rfSel, 0x9, 0x0400, x);
			break;
		case RC_PARAMID_RXGAINS_SPI_CTRL_EN:
			//reg8[12]: 0=B port controls Rx gains, 1=SPI regB[6:0] controls Rx gains
			if(paramVal > 1) return RC_INVALID_PARAM;
			x = paramVal ? 0x1000 : 0x0000;
			return radio_controller_SPI_setRegBits(ba, rfSel, 0x8, 0x1000, x);
			break;
		case RC_PARAMID_RXGAIN_RF:
			//regB[6:5] sets LNA gain (but only if SPI control for Rx gains is enabled)
			if(paramVal > 3) return RC_INVALID_PARAM;
			x = (paramVal & 0x3)<<5;
			return radio_controller_SPI_setRegBits(ba, rfSel, 0xB, 0x0060, x);
		case RC_PARAMID_RXGAIN_BB:
			//regB[4:0] sets Rx VGA gain (but only if SPI control for Rx gains is enabled)
			if(paramVal > 31) return RC_INVALID_PARAM;
			x = (paramVal & 0x1F);
			return radio_controller_SPI_setRegBits(ba, rfSel, 0xB, 0x001F, x);
			break;
		case RC_PARAMID_TXGAIN_RF:
			//regC[5:0] sets Tx RF VGA gain (but only if SPI control for Tx gains is enabled)
			if(paramVal > 63) return RC_INVALID_PARAM;
			x = (paramVal & 0x3F);
			return radio_controller_SPI_setRegBits(ba, rfSel, 0xC, 0x003F, x);
			break;
		case RC_PARAMID_TXGAIN_BB:
			//reg9[1:0] sets Tx BB gain (Tx BB gain always set via SPI)
			if(paramVal > 3) return RC_INVALID_PARAM;
			x = (paramVal & 0x3);
			return radio_controller_SPI_setRegBits(ba, rfSel, 0x9, 0x0003, x);
			break;
#endif //RC_INCLUDED_PARAMS_GAIN_CTRL

#ifdef RC_INCLUDED_PARAMS_FILTS
		case RC_PARAMID_TXLPF_BW:
			//reg7[6:5]: 00=undefined, 01=12MHz, 10=18MHz, 11=24MHz
			if(paramVal == 0 || paramVal > 3) return RC_INVALID_PARAM;
			x = (paramVal&0x3)<<5;
			return radio_controller_SPI_setRegBits(ba, rfSel, 0x7, 0x0060, x);
			break;
		case RC_PARAMID_RXLPF_BW:
			//reg7[4:3]: 00=7.5MHz, 01=9.5MHz, 10=14MHz, 11=18MHz
			if(paramVal > 3) return RC_INVALID_PARAM;
			x = (paramVal&0x3)<<3;
			return radio_controller_SPI_setRegBits(ba, rfSel, 0x7, 0x0018, x);
			break;
		case RC_PARAMID_RXLPF_BW_FINE:
			//reg7[2:0]: 000=90%, 001=95%, 010=100%, 011=105%, 100=110%
			if(paramVal > 4) return RC_INVALID_PARAM;
			x = (paramVal&0x7);
			return radio_controller_SPI_setRegBits(ba, rfSel, 0x7, 0x0007, x);
			break;
		case RC_PARAMID_RXHPF_HIGH_CUTOFF_EN:
			//reg8[2]: HPF corner freq when RxHP=0; 0=100Hz, 1=30kHz
			if(paramVal > 1) return RC_INVALID_PARAM;
			x = paramVal ? 0x0002 : 0x0000;
			return radio_controller_SPI_setRegBits(ba, rfSel, 0x8, 0x0002, x);
			break;
#endif //RC_INCLUDED_PARAMS_FILTS

#ifdef RC_INCLUDED_PARAMS_MISC
		case RC_PARAMID_RSSI_HIGH_BW_EN:
			//reg7[11]: 0=2MHz RSSI BW, 1=6MHZ RSSI BW
			if(paramVal > 1) return RC_INVALID_PARAM;
			x = paramVal ? 0x0800 : 0x0000;
			return radio_controller_SPI_setRegBits(ba, rfSel, 0x7, 0x0800, x);
			break;
		case RC_PARAMID_TXLINEARITY_PADRIVER:
			//reg9[9:8]: [0,1,2,3]=[50%,63%,78%,100%] current; higher current -> more linear
			if(paramVal > 3) return RC_INVALID_PARAM;
			x = (paramVal&0x3)<<8;
			return radio_controller_SPI_setRegBits(ba, rfSel, 0x9, 0x0300, x);
			break;
		case RC_PARAMID_TXLINEARITY_VGA:
			//reg9[7:6]: [0,1,2,3]=[50%,63%,78%,100%] current; higher current -> more linear
			if(paramVal > 3) return RC_INVALID_PARAM;
			x = (paramVal&0x3)<<6;
			return radio_controller_SPI_setRegBits(ba, rfSel, 0x9, 0x00C0, x);
			break;
		case RC_PARAMID_TXLINEARITY_UPCONV:
			//reg9[3:2]: [0,1,2,3]=[50%,63%,78%,100%] current; higher current -> more linear
			if(paramVal > 3) return RC_INVALID_PARAM;
			x = (paramVal&0x3)<<2;
			return radio_controller_SPI_setRegBits(ba, rfSel, 0x9, 0x000C, x);
			break;
#endif //RC_INCLUDED_PARAMS_MISC
		default:
			//Either no paramters were #ifdef'd in, or user supplied invalid paramID
			return RC_INVALID_PARAMID;
			break;
	}

	return 0;
}

/**
\brief Reads the TxDCO calibration values from the EEPROM and writes the values to the DACs of the selected RF interface. This function
requires the w3_iic_eeprom and w3_ad_controller cores.
\param ad_ba Base memory address of w3_ad_controller core
\param iic_ba Base memory address of w3_iic_eeprom core
\param rfSel Selects RF interfaces to affect (OR'd combination of [RC_RFA, RC_RFB, RC_RFC, RC_RFD])
\return Returns non-zero if w3_ad_controller or w3_iic_eeprom core is not found; otherwise returns 0
*/
int radio_controller_apply_TxDCO_calibration(u32 ad_ba, u32 iic_ba, u32 rfSel) {
#if defined XPAR_W3_IIC_EEPROM_NUM_INSTANCES && defined XPAR_W3_AD_CONTROLLER_NUM_INSTANCES
	u16 rI, rQ;

	//For each radio interface specified by rfSel:
	// -Read the I/Q TxDCO calibration values from the EEPROM (two u16 values)
	// -Apply the TxDCO calibration values via the ad_controller driver
	//The RC_EEPROM_TXDCO_ADDR_RFx_x macros are defined in radio_controller.h
	//The on-board RF interfaces use the on-board EEPROM
	//FMC RF interfaces use the EEPROM on the FMC module
	//On-board RFA/RFB use the same EEPROM byte addresses as FMC RFC/RFD, respectively
	//User code must supply the correct IIC controller base address when calling this function
	if(rfSel & (RC_RFA | RC_RFC)) {
		rI = iic_eeprom_readByte(iic_ba, RC_EEPROM_TXDCO_ADDR_RFA_I) + (iic_eeprom_readByte(iic_ba, RC_EEPROM_TXDCO_ADDR_RFA_I+1)<<8);
		rQ = iic_eeprom_readByte(iic_ba, RC_EEPROM_TXDCO_ADDR_RFA_Q) + (iic_eeprom_readByte(iic_ba, RC_EEPROM_TXDCO_ADDR_RFA_Q+1)<<8);
	
		ad_set_TxDCO(ad_ba, (rfSel & (RC_RFA | RC_RFC)), AD_CHAN_I, rI);
		ad_set_TxDCO(ad_ba, (rfSel & (RC_RFA | RC_RFC)), AD_CHAN_Q, rQ);
	}
	if(rfSel & (RC_RFB | RC_RFD)) {
		rI = iic_eeprom_readByte(iic_ba, RC_EEPROM_TXDCO_ADDR_RFB_I) + (iic_eeprom_readByte(iic_ba, RC_EEPROM_TXDCO_ADDR_RFB_I+1)<<8);
		rQ = iic_eeprom_readByte(iic_ba, RC_EEPROM_TXDCO_ADDR_RFB_Q) + (iic_eeprom_readByte(iic_ba, RC_EEPROM_TXDCO_ADDR_RFB_Q+1)<<8);
	
		ad_set_TxDCO(ad_ba, (rfSel & (RC_RFB | RC_RFD)), AD_CHAN_I, rI);
		ad_set_TxDCO(ad_ba, (rfSel & (RC_RFB | RC_RFD)), AD_CHAN_Q, rQ);
	}
	
	return 0;
#else
	print("w3_iic_eeprom or w3_ad_controller pcores are missing! Cannot apply TxDCO correction\n");
	return -1;
#endif
}

/**
\brief Simple pseudo-usleep implementation (since MicroBlaze lacks internal timer for native usleep implementation).
The actual sleep time is not guaranteed to be d microseconds.
\param d Number of "microseconds" to sleep (proportional to sleep time; actual sleep time will depend on processor and instruction memory clocks)
*/
void rc_usleep(int d) {
	volatile int i;
	for(i=0; i<d*4; i++) { /* do nothing */}
	return;
}

/** @}*/ //END group user_functions
