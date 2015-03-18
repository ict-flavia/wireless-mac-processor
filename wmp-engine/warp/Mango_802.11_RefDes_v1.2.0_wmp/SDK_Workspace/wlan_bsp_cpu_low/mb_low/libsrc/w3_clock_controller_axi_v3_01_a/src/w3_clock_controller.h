#ifndef WARP_CLOCK_CONTROLLER_H
#define WARP_CLOCK_CONTROLLER_H

#include "xbasic_types.h"
#include "xstatus.h"
#include "xil_io.h"

#define WARP_CLOCK_CONTROLLER_USER_SLV_SPACE_OFFSET (0x00000000)
#define WARP_CLOCK_CONTROLLER_SLV_REG0_OFFSET (WARP_CLOCK_CONTROLLER_USER_SLV_SPACE_OFFSET + 0x00000000)
#define WARP_CLOCK_CONTROLLER_SLV_REG1_OFFSET (WARP_CLOCK_CONTROLLER_USER_SLV_SPACE_OFFSET + 0x00000004)
#define WARP_CLOCK_CONTROLLER_SLV_REG2_OFFSET (WARP_CLOCK_CONTROLLER_USER_SLV_SPACE_OFFSET + 0x00000008)
#define WARP_CLOCK_CONTROLLER_SLV_REG3_OFFSET (WARP_CLOCK_CONTROLLER_USER_SLV_SPACE_OFFSET + 0x0000000C)
#define WARP_CLOCK_CONTROLLER_SLV_REG4_OFFSET (WARP_CLOCK_CONTROLLER_USER_SLV_SPACE_OFFSET + 0x00000010)
#define WARP_CLOCK_CONTROLLER_SLV_REG5_OFFSET (WARP_CLOCK_CONTROLLER_USER_SLV_SPACE_OFFSET + 0x00000014)
#define WARP_CLOCK_CONTROLLER_SLV_REG6_OFFSET (WARP_CLOCK_CONTROLLER_USER_SLV_SPACE_OFFSET + 0x00000018)
#define WARP_CLOCK_CONTROLLER_SLV_REG7_OFFSET (WARP_CLOCK_CONTROLLER_USER_SLV_SPACE_OFFSET + 0x0000001C)

/* Address map:
	HDL is coded [MSB:LSB] = [0:31]
	regX[0]  maps to 0x80000000 in C driver
	regX[31] maps to 0x00000001 in C driver

0: Config: {clk_div_sel[2:0], 1'b0, samp_func, rfref_func, 26'b0}
		[29:31] Clock divider bit sel (00=0.5*busclk, 01=0.25*busclk, ...) 0x00000003
		[28   ] Reserved
		[   27] samp buf reset (active low)		0x00000010
		[   26] rf ref buf reset (active low)	0x00000020
		[16:25] Reserved 						0x0000FFC0
		[0 :15] Clock module status				0xFFFF0000
		
1: SPI Tx
	[24:31] Tx data byte
	[17:23] 7-bit register address (0x00 to 0xFF all valid)
	[11:16] 6'b0 (always zero)
	[ 9:10] Num bytes to Tx/Rx; must be 2'b0 for 1-byte Tx/Rx
	[    8] RW# 1=Read, 0=Write
	[    7] samp buf chip select mask
	[    6] rf ref buf chip select mask
	[ 0: 5] Reserved

2: SPI Rx: {samp_rxByte, rfref_rxByte, 16'b0}
	[24:31] SPI Rx byte for samp buf 0x00FF
	[16:23] SPI Rx byte for rf ref buf 0xFF00
	[ 0:15] Reserved 0xFFFF0000
	
3: RW: User reset outputs
	[31] usr_reset0
	[30] usr_reset1
	[29] usr_reset2
	[28] usr_reset3
	[0:27] reserved

4: RO: User status inputs
	[0:31] usr_status input

5-15: Reserved
*/
#define CLKCTRL_REG_CONFIG	WARP_CLOCK_CONTROLLER_SLV_REG0_OFFSET
#define CLKCTRL_REG_SPITX	WARP_CLOCK_CONTROLLER_SLV_REG1_OFFSET
#define CLKCTRL_REG_SPIRX	WARP_CLOCK_CONTROLLER_SLV_REG2_OFFSET

#define CLKCTRL_REG_CONFIG_MASK_CLKDIV		0x03
#define CLKCTRL_REG_CONFIG_MASK_SAMP_FUNC	0x10
#define CLKCTRL_REG_CONFIG_MASK_RFREF_FUNC	0x20

#define CLKCTRL_REG_SPITX_SAMP_CS	0x01000000
#define CLKCTRL_REG_SPITX_RFREF_CS	0x02000000
#define CLKCTRL_REG_SPITX_RNW		0x00800000

#define CLK_SAMP_CS		CLKCTRL_REG_SPITX_SAMP_CS
#define CLK_RFREF_CS	CLKCTRL_REG_SPITX_RFREF_CS

#define CLK_SAMP_OUTSEL_FMC			0x01
#define CLK_SAMP_OUTSEL_CLKMODHDR	0x02
#define CLK_SAMP_OUTSEL_FPGA		0x04
#define CLK_SAMP_OUTSEL_AD_RFA		0x08
#define CLK_SAMP_OUTSEL_AD_RFB		0x10

#define CLK_RFREF_OUTSEL_FMC		0x20
#define CLK_RFREF_OUTSEL_CLKMODHDR	0x40
#define CLK_RFREF_OUTSEL_RFAB		0x80

#define CLK_OUTPUT_ON	1
#define CLK_OUTPUT_OFF	2

#define CLK_INSEL_ONBOARD 1
#define CLK_INSEL_CLKMOD 2

u32 clk_spi_read(u32 baseaddr,  u32 csMask, u8 regAddr);
void clk_spi_write(u32 baseaddr, u32 csMask, u8 regAddr, u8 txByte);
int clk_init(u32 baseaddr, u8 clkDiv);
int clk_config_outputs(u32 baseaddr, u8 clkOutMode, u32 clkOutSel);
int clk_config_dividers(u32 baseaddr, u8 clkDiv, u32 clkOutSel);
int clk_config_input_rf_ref(u32 baseaddr, u8 clkInSel);
u16 clk_config_read_clkmod_status(u32 baseaddr);

#endif /** WARP_CLOCK_CONTROLLER_H */
