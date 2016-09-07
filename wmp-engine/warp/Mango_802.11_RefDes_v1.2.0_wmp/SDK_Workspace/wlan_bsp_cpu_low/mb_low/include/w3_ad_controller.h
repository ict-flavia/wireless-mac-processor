#ifndef WARP_AD_CONTROLLER_H
#define WARP_AD_CONTROLLER_H

#include "xbasic_types.h"
#include "xstatus.h"
#include "xil_io.h"

#define WARP_AD_CONTROLLER_USER_SLV_SPACE_OFFSET (0x00000000)
#define WARP_AD_CONTROLLER_SLV_REG0_OFFSET (WARP_AD_CONTROLLER_USER_SLV_SPACE_OFFSET + 0x00000000)
#define WARP_AD_CONTROLLER_SLV_REG1_OFFSET (WARP_AD_CONTROLLER_USER_SLV_SPACE_OFFSET + 0x00000004)
#define WARP_AD_CONTROLLER_SLV_REG2_OFFSET (WARP_AD_CONTROLLER_USER_SLV_SPACE_OFFSET + 0x00000008)
#define WARP_AD_CONTROLLER_SLV_REG3_OFFSET (WARP_AD_CONTROLLER_USER_SLV_SPACE_OFFSET + 0x0000000C)
#define WARP_AD_CONTROLLER_SLV_REG4_OFFSET (WARP_AD_CONTROLLER_USER_SLV_SPACE_OFFSET + 0x00000010)
#define WARP_AD_CONTROLLER_SLV_REG5_OFFSET (WARP_AD_CONTROLLER_USER_SLV_SPACE_OFFSET + 0x00000014)
#define WARP_AD_CONTROLLER_SLV_REG6_OFFSET (WARP_AD_CONTROLLER_USER_SLV_SPACE_OFFSET + 0x00000018)
#define WARP_AD_CONTROLLER_SLV_REG7_OFFSET (WARP_AD_CONTROLLER_USER_SLV_SPACE_OFFSET + 0x0000001C)
#define WARP_AD_CONTROLLER_SLV_REG8_OFFSET (WARP_AD_CONTROLLER_USER_SLV_SPACE_OFFSET + 0x00000020)
#define WARP_AD_CONTROLLER_SLV_REG9_OFFSET (WARP_AD_CONTROLLER_USER_SLV_SPACE_OFFSET + 0x00000024)
#define WARP_AD_CONTROLLER_SLV_REG10_OFFSET (WARP_AD_CONTROLLER_USER_SLV_SPACE_OFFSET + 0x00000028)
#define WARP_AD_CONTROLLER_SLV_REG11_OFFSET (WARP_AD_CONTROLLER_USER_SLV_SPACE_OFFSET + 0x0000002C)
#define WARP_AD_CONTROLLER_SLV_REG12_OFFSET (WARP_AD_CONTROLLER_USER_SLV_SPACE_OFFSET + 0x00000030)
#define WARP_AD_CONTROLLER_SLV_REG13_OFFSET (WARP_AD_CONTROLLER_USER_SLV_SPACE_OFFSET + 0x00000034)
#define WARP_AD_CONTROLLER_SLV_REG14_OFFSET (WARP_AD_CONTROLLER_USER_SLV_SPACE_OFFSET + 0x00000038)
#define WARP_AD_CONTROLLER_SLV_REG15_OFFSET (WARP_AD_CONTROLLER_USER_SLV_SPACE_OFFSET + 0x0000003C)



/* Address map:
	HDL is coded [MSB:LSB] = [0:31]
	regX[0]  maps to 0x80000000 in C driver
	regX[31] maps to 0x00000001 in C driver

0: Config: {clk_div_sel[2:0], 1'b0, RFA_AD_rst_n, RFB_AD_rst_n, 26'b0}
	[29:31] Clock divider bit sel (00=0.5*busclk, 01=0.25*busclk, ...) 0x00000003
	[28   ] Reserved
	[   27] RFA_AD reset (active low) 0x00000010
	[   26] RFB_AD reset (active low) 0x00000020
	[   25] RFC_AD reset (active low) 0x00000040
	[   24] RFD_AD reset (active low) 0x00000080
	[0 :23] Reserved

1: SPI Tx
	[24:31] Tx data byte
	[16:23] 8-bit register address (0x00 to 0xFF all valid)
	[11:15] 5'b0 (always zero)
	[ 9:10] Num bytes to Tx/Rx; must be 2'b0 for 1-byte Tx/Rx
	[    8] RW# 1=Read, 0=Write
	[    7] RFA_AD chip select mask
	[    6] RFB_AD chip select mask
	[    5] RFC_AD chip select mask
	[    4] RFD_AD chip select mask
	[ 0: 3] Reserved

2: SPI Rx: {RFA_AD_rxByte, RFB_AD_rxByte, RFC_AD_rxByte, RFD_AD_rxByte}
	[24:31] SPI Rx byte for RFA_AD 0x000000FF
	[16:23] SPI Rx byte for RFB_AD 0x0000FF00
	[ 8:15] SPI Rx byte for RFC_AD 0x00FF0000
	[ 0: 7] SPI Rx byte for RFD_AD 0xFF000000
	
3-15: Reserved
*/

#define AD_CTRL_ALL_RF_CS (RFA_AD_CS | RFB_AD_CS | RFC_AD_CS | RFD_AD_CS)

#define ADCTRL_REG_CONFIG 	WARP_AD_CONTROLLER_SLV_REG0_OFFSET
#define ADCTRL_REG_SPITX 	WARP_AD_CONTROLLER_SLV_REG1_OFFSET
#define ADCTRL_REG_SPIRX 	WARP_AD_CONTROLLER_SLV_REG2_OFFSET

#define ADCTRL_REG_CONFIG_MASK_CLKDIV	 0x03
#define ADCTRL_REG_CONFIG_MASK_RFA_AD_RESET 0x10
#define ADCTRL_REG_CONFIG_MASK_RFB_AD_RESET 0x20
#define ADCTRL_REG_CONFIG_MASK_RFC_AD_RESET 0x40
#define ADCTRL_REG_CONFIG_MASK_RFD_AD_RESET 0x80

#define ADCTRL_REG_SPITX_RFA_AD_CS		0x01000000
#define ADCTRL_REG_SPITX_RFB_AD_CS		0x02000000
#define ADCTRL_REG_SPITX_RFC_AD_CS		0x04000000
#define ADCTRL_REG_SPITX_RFD_AD_CS		0x08000000
#define ADCTRL_REG_SPITX_RNW			0x00800000

//Shorter versions for user code
#define AD_CHAN_I 1
#define AD_CHAN_Q 2

#define AD_DACCLKSRC_DLL 0x40
#define AD_DACCLKSRC_EXT 0x00

#define AD_ADCCLKSRC_DLL 0x80
#define AD_ADCCLKSRC_EXT 0x00

#define AD_DCS_ON	0x0
#define AD_DCS_OFF	0x4

#define AD_ADCCLKDIV_1	0x1
#define AD_ADCCLKDIV_2	0x2
#define AD_ADCCLKDIV_4	0x3

#define AD_PWR_ALLOFF	1
#define AD_PWR_ALLON	2

#define RFA_AD_CS ADCTRL_REG_SPITX_RFA_AD_CS
#define RFB_AD_CS ADCTRL_REG_SPITX_RFB_AD_CS
#define RFC_AD_CS ADCTRL_REG_SPITX_RFC_AD_CS
#define RFD_AD_CS ADCTRL_REG_SPITX_RFD_AD_CS


//Functions
u32 ad_spi_read(u32 baseaddr,  u32 csMask, u8 regAddr);
void ad_spi_write(u32 baseaddr, u32 csMask, u8 regAddr, u8 txByte);
int ad_init(u32 baseaddr, u32 adSel, u8 clkdiv);

int ad_set_TxDCO(u32 baseaddr, u32 csMask, u8 iqSel, u16 dco);
int ad_set_TxGain1(u32 baseaddr, u32 csMask, u8 iqSel, u8 gain);
int ad_set_TxGain2(u32 baseaddr, u32 csMask, u8 iqSel, u8 gain);
int ad_config_DLL(u32 baseaddr, u32 csMask, u8 DLL_En, u8 DLL_M, u8 DLL_N, u8 DLL_DIV);
int ad_config_clocks(u32 baseaddr, u32 csMask, u8 DAC_clkSrc, u8 ADC_clkSrc, u8 ADC_clkDiv, u8 ADC_DCS);
int ad_config_filters(u32 baseaddr, u32 csMask, u8 interpRate, u8 decimationRate);

#endif /** WARP_AD_CONTROLLER_H */
