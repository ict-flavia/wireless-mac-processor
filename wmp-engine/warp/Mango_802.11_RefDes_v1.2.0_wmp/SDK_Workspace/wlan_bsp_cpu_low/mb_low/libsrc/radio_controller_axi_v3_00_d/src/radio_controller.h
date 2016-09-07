/*****************************************************************************
* Filename:          C:\work\svn_work\mango-dev\MyProcessorIPLib/drivers/radio_controller_v3_00_a/src/radio_controller.h
* Version:           3.00.a
* Description:       radio_controller Driver Header File
* Date:              Wed Jul 04 20:56:03 2012 (by Create and Import Peripheral Wizard)
*****************************************************************************/

#ifndef RADIO_CONTROLLER_H
#define RADIO_CONTROLLER_H

/***************************** Include Files *******************************/

#include "xbasic_types.h"
#include "xstatus.h"
#include "xil_io.h"

int radio_controller_init(u32 ba, u32 rfSel, u8 clkDiv_SPI, u8 clkDiv_TxDelays);
int radio_controller_TxEnable(u32 ba, u32 rfSel);
int radio_controller_RxEnable(u32 ba, u32 rfSel);
int radio_controller_TxRxDisable(u32 ba, u32 rfSel);
int radio_controller_setCenterFrequency(u32 ba, u32 rfSel, u8 bandSel, u8 chanNum);
u16 radio_controller_SPI_read(u32 ba, u32 rfSel, u8 regAddr);
int radio_controller_SPI_setRegBits(u32 ba, u32 rfSel, u8 regAddr, u16 regDataMask, u16 regData);
int radio_controller_setRadioParam(u32 ba, u32 rfSel, u32 paramID, u32 paramVal);
int radio_controller_setTxGainSource(u32 ba, u32 rfSel, u8 gainSrc);
int radio_controller_setRxGainSource(u32 ba, u32 rfSel, u8 gainSrc);
int radio_controller_apply_TxDCO_calibration(u32 ad_ba, u32 iic_ba, u32 rfSel);
int radio_controller_setCtrlSource(u32 ba, u32 rfSel, u32 ctrlSrcMask, u8 ctrlSrc);
int radio_controller_setRxHP(u32 ba, u32 rfSel, u8 mode);
int radio_controller_setTxGainTarget(u32 ba, u32 rfSel, u8 gainTarget);
void rc_usleep(int d);

/************************** Constant Definitions ***************************/

#define RC_USER_SLV_SPACE_OFFSET (0x00000000)
#define RC_SLV_REG0_OFFSET (RC_USER_SLV_SPACE_OFFSET + 0x00000000)
#define RC_SLV_REG1_OFFSET (RC_USER_SLV_SPACE_OFFSET + 0x00000004)
#define RC_SLV_REG2_OFFSET (RC_USER_SLV_SPACE_OFFSET + 0x00000008)
#define RC_SLV_REG3_OFFSET (RC_USER_SLV_SPACE_OFFSET + 0x0000000C)
#define RC_SLV_REG4_OFFSET (RC_USER_SLV_SPACE_OFFSET + 0x00000010)
#define RC_SLV_REG5_OFFSET (RC_USER_SLV_SPACE_OFFSET + 0x00000014)
#define RC_SLV_REG6_OFFSET (RC_USER_SLV_SPACE_OFFSET + 0x00000018)
#define RC_SLV_REG7_OFFSET (RC_USER_SLV_SPACE_OFFSET + 0x0000001C)
#define RC_SLV_REG8_OFFSET (RC_USER_SLV_SPACE_OFFSET + 0x00000020)
#define RC_SLV_REG9_OFFSET (RC_USER_SLV_SPACE_OFFSET + 0x00000024)
#define RC_SLV_REG10_OFFSET (RC_USER_SLV_SPACE_OFFSET + 0x00000028)
#define RC_SLV_REG11_OFFSET (RC_USER_SLV_SPACE_OFFSET + 0x0000002C)
#define RC_SLV_REG12_OFFSET (RC_USER_SLV_SPACE_OFFSET + 0x00000030)
#define RC_SLV_REG13_OFFSET (RC_USER_SLV_SPACE_OFFSET + 0x00000034)
#define RC_SLV_REG14_OFFSET (RC_USER_SLV_SPACE_OFFSET + 0x00000038)
#define RC_SLV_REG15_OFFSET (RC_USER_SLV_SPACE_OFFSET + 0x0000003C)
#define RC_SLV_REG16_OFFSET (RC_USER_SLV_SPACE_OFFSET + 0x00000040)
#define RC_SLV_REG17_OFFSET (RC_USER_SLV_SPACE_OFFSET + 0x00000044)
#define RC_SLV_REG18_OFFSET (RC_USER_SLV_SPACE_OFFSET + 0x00000048)
#define RC_SLV_REG19_OFFSET (RC_USER_SLV_SPACE_OFFSET + 0x0000004C)
#define RC_SLV_REG20_OFFSET (RC_USER_SLV_SPACE_OFFSET + 0x00000050)
#define RC_SLV_REG21_OFFSET (RC_USER_SLV_SPACE_OFFSET + 0x00000054)
#define RC_SLV_REG22_OFFSET (RC_USER_SLV_SPACE_OFFSET + 0x00000058)
#define RC_SLV_REG23_OFFSET (RC_USER_SLV_SPACE_OFFSET + 0x0000005C)
#define RC_SLV_REG24_OFFSET (RC_USER_SLV_SPACE_OFFSET + 0x00000060)
#define RC_SLV_REG25_OFFSET (RC_USER_SLV_SPACE_OFFSET + 0x00000064)
#define RC_SLV_REG26_OFFSET (RC_USER_SLV_SPACE_OFFSET + 0x00000068)
#define RC_SLV_REG27_OFFSET (RC_USER_SLV_SPACE_OFFSET + 0x0000006C)
#define RC_SLV_REG28_OFFSET (RC_USER_SLV_SPACE_OFFSET + 0x00000070)
#define RC_SLV_REG29_OFFSET (RC_USER_SLV_SPACE_OFFSET + 0x00000074)
#define RC_SLV_REG30_OFFSET (RC_USER_SLV_SPACE_OFFSET + 0x00000078)
#define RC_SLV_REG31_OFFSET (RC_USER_SLV_SPACE_OFFSET + 0x0000007C)
#define RC_SLV_REG32_OFFSET (RC_USER_SLV_SPACE_OFFSET + 0x00000080)
#define RC_SLV_REG33_OFFSET (RC_USER_SLV_SPACE_OFFSET + 0x00000084)
#define RC_SLV_REG34_OFFSET (RC_USER_SLV_SPACE_OFFSET + 0x00000088)
#define RC_SLV_REG35_OFFSET (RC_USER_SLV_SPACE_OFFSET + 0x0000008C)
#define RC_SLV_REG36_OFFSET (RC_USER_SLV_SPACE_OFFSET + 0x00000090)
#define RC_SLV_REG37_OFFSET (RC_USER_SLV_SPACE_OFFSET + 0x00000094)
#define RC_SLV_REG38_OFFSET (RC_USER_SLV_SPACE_OFFSET + 0x00000098)
#define RC_SLV_REG39_OFFSET (RC_USER_SLV_SPACE_OFFSET + 0x0000009C)
#define RC_SLV_REG40_OFFSET (RC_USER_SLV_SPACE_OFFSET + 0x000000A0)
#define RC_SLV_REG41_OFFSET (RC_USER_SLV_SPACE_OFFSET + 0x000000A4)
#define RC_SLV_REG42_OFFSET (RC_USER_SLV_SPACE_OFFSET + 0x000000A8)
#define RC_SLV_REG43_OFFSET (RC_USER_SLV_SPACE_OFFSET + 0x000000AC)
#define RC_SLV_REG44_OFFSET (RC_USER_SLV_SPACE_OFFSET + 0x000000B0)
#define RC_SLV_REG45_OFFSET (RC_USER_SLV_SPACE_OFFSET + 0x000000B4)
#define RC_SLV_REG46_OFFSET (RC_USER_SLV_SPACE_OFFSET + 0x000000B8)
#define RC_SLV_REG47_OFFSET (RC_USER_SLV_SPACE_OFFSET + 0x000000BC)
#define RC_SLV_REG48_OFFSET (RC_USER_SLV_SPACE_OFFSET + 0x000000C0)
#define RC_SLV_REG49_OFFSET (RC_USER_SLV_SPACE_OFFSET + 0x000000C4)
#define RC_SLV_REG50_OFFSET (RC_USER_SLV_SPACE_OFFSET + 0x000000C8)
#define RC_SLV_REG51_OFFSET (RC_USER_SLV_SPACE_OFFSET + 0x000000CC)
#define RC_SLV_REG52_OFFSET (RC_USER_SLV_SPACE_OFFSET + 0x000000D0)
#define RC_SLV_REG53_OFFSET (RC_USER_SLV_SPACE_OFFSET + 0x000000D4)
#define RC_SLV_REG54_OFFSET (RC_USER_SLV_SPACE_OFFSET + 0x000000D8)
#define RC_SLV_REG55_OFFSET (RC_USER_SLV_SPACE_OFFSET + 0x000000DC)
#define RC_SLV_REG56_OFFSET (RC_USER_SLV_SPACE_OFFSET + 0x000000E0)
#define RC_SLV_REG57_OFFSET (RC_USER_SLV_SPACE_OFFSET + 0x000000E4)
#define RC_SLV_REG58_OFFSET (RC_USER_SLV_SPACE_OFFSET + 0x000000E8)
#define RC_SLV_REG59_OFFSET (RC_USER_SLV_SPACE_OFFSET + 0x000000EC)
#define RC_SLV_REG60_OFFSET (RC_USER_SLV_SPACE_OFFSET + 0x000000F0)
#define RC_SLV_REG61_OFFSET (RC_USER_SLV_SPACE_OFFSET + 0x000000F4)
#define RC_SLV_REG62_OFFSET (RC_USER_SLV_SPACE_OFFSET + 0x000000F8)
#define RC_SLV_REG63_OFFSET (RC_USER_SLV_SPACE_OFFSET + 0x000000FC)


/***** Register Masks ********
 * See comments in user_logic.v for full address map
*******************************/

//Control source bits: 0=use registers, 1=use hardware ports (usr_* in HDL)

//Per-RF chain masks, shared by registers 0, 2, 3, 11 below
#define RC_CTRLREGMASK_RFA				0x000000FF
#define RC_CTRLREGMASK_RFB				0x0000FF00
#define RC_CTRLREGMASK_RFC				0x00FF0000
#define RC_CTRLREGMASK_RFD				0xFF000000

//register 0 masks
#define RC_REG0_TXEN			0x80808080
#define RC_REG0_RXEN			0x40404040
#define RC_REG0_RXHP			0x20202020
#define RC_REG0_SHDN			0x10101010

#define RC_REG0_TXEN_CTRLSRC	0x08080808
#define RC_REG0_RXEN_CTRLSRC	0x04040404
#define RC_REG0_RXHP_CTRLSRC	0x02020202
#define RC_REG0_SHDN_CTRLSRC	0x01010101

#define RC_REG0_ALL_CTRLSRC		0x0F0F0F0F

//register 1 masks
#define RC_REG1_DLY_PAEN		0x00FF0000
#define RC_REG1_DLY_TXEN		0x0000FF00
#define RX_REG1_DLY_PHY			0x000000FF

//register 2 masks
#define RC_REG2_TXGAIN			0x3F3F3F3F
#define RC_REG2_TXGAIN_CTRLSRC	0x80808080

//register 3 masks
#define RC_REG3_RXGAIN_BB		0x1F1F1F1F
#define RC_REG3_RXGAIN_RF		0x60606060
#define RC_REG3_RXGAIN_CTRLSRC	0x80808080

//register 4 masks
#define RC_REG4_CLKDIV_SPI		0x00000070
#define RC_REG4_CLKDIV_SPI_SHIFT	4

#define RC_REG4_CLKDIV_TXDLY	0x00000003
#define RC_REG4_CLKDIV_TXDLY_SHIFT	0

//register 5 masks
#define RC_REG5_RFSEL_RFD		0x80000000
#define RC_REG5_RFSEL_RFC		0x40000000
#define RC_REG5_RFSEL_RFB		0x20000000
#define RC_REG5_RFSEL_RFA		0x10000000
#define RC_REG5_RFSEL_ALL		(RC_REG5_RFSEL_RFA | RC_REG5_RFSEL_RFB | RC_REG5_RFSEL_RFC | RC_REG5_RFSEL_RFD)

#define RC_REG5_REGADDR			0x000F0000
#define RF_REG5_REGADDR_SHIFT	16
#define RC_REG5_REGDATA			0x00003FFF

//easier macros for user code
#define RC_RFA		RC_REG5_RFSEL_RFA
#define RC_RFB		RC_REG5_RFSEL_RFB
#define RC_RFC		RC_REG5_RFSEL_RFC
#define RC_RFD		RC_REG5_RFSEL_RFD
#define RC_ANY_RF	RC_REG5_RFSEL_ALL

#define RC_TXEN_CTRLSRC RC_REG0_TXEN_CTRLSRC
#define RC_RXEN_CTRLSRC RC_REG0_RXEN_CTRLSRC
#define RC_RXHP_CTRLSRC RC_REG0_RXHP_CTRLSRC
#define RC_SHDN_CTRLSRC RC_REG0_SHDN_CTRLSRC


//registers 6-10 are reserved (implemented as 32-bit RW, not tied to external ports)

//register 11 masks
#define RC_REG11_TXEN			0x80808080
#define RC_REG11_RXEN			0x40404040
#define RC_REG11_RXHP			0x20202020
#define RC_REG11_SHDN			0x10101010
#define RC_REG11_LD				0x08080808
#define RC_REG11_SPI_ACTIVE		0x04040404
#define RC_REG11_24PA_ACTIVE	0x02020202
#define RC_REG11_5PA_ACTIVE		0x01010101


//registers 12-24 are mirror regs for RFA
//registers 25-37 are mirror regs for RFB
//registers 38-50 are mirror regs for RFC
//registers 51-63 are mirror regs for RFD
#define RC_SPI_MIRRORREGS_RFA_BASEADDR 		RC_SLV_REG12_OFFSET
#define RC_SPI_MIRRORREGS_RFB_BASEADDR 		RC_SLV_REG25_OFFSET
#define RC_SPI_MIRRORREGS_RFC_BASEADDR 		RC_SLV_REG38_OFFSET
#define RC_SPI_MIRRORREGS_RFD_BASEADDR 		RC_SLV_REG51_OFFSET

#define RC_EEPROM_TXDCO_ADDR_RFA_I			16364	
#define RC_EEPROM_TXDCO_ADDR_RFA_Q			16366	
#define RC_EEPROM_TXDCO_ADDR_RFB_I			16368	
#define RC_EEPROM_TXDCO_ADDR_RFB_Q			16370	

/********** Macros **********/
#define radio_controller_setCtrlSrc(ba, rfSel, x)	(Xil_Out32(ba+RC_SLV_REG0_OFFSET, \
													(Xil_In32(ba+RC_SLV_REG0_OFFSET) & ~(RC_REG0_RXEN & rfSel)) | \
													(RC_REG0_TXEN & rfSel) | (RC_REG0_SHDN & rfSel)))


#define radio_controller_setClkDiv_SPI(ba, x)		(Xil_Out32(ba+RC_SLV_REG4_OFFSET, \
													 ((Xil_In32(ba+RC_SLV_REG4_OFFSET)&(~RC_REG4_CLKDIV_SPI)) | \
													 ((x<<RC_REG4_CLKDIV_SPI_SHIFT) & RC_REG4_CLKDIV_SPI))))

#define radio_controller_setClkDiv_TxDelays(ba, x)		(Xil_Out32(ba+RC_SLV_REG4_OFFSET, \
													 ((Xil_In32(ba+RC_SLV_REG4_OFFSET)&(~RC_REG4_CLKDIV_TXDLY)) | \
													 ((x<<RC_REG4_CLKDIV_TXDLY_SHIFT) & RC_REG4_CLKDIV_TXDLY))))

//TxEn, RxEn and SHDN are mutually exclusive in normal operation, so asserting one here forces the others off for the selected RF paths
// TxEn/RxEn are active high, SHDN is active low
// TxEn: reg0 <= (current reg0 with selected RxEn deasserted) + (selected TxEn asserted) + (selected SHDN deasserted)
#define radio_controller_setMode_Tx(ba, rfSel)		(Xil_Out32(ba+RC_SLV_REG0_OFFSET, \
													(Xil_In32(ba+RC_SLV_REG0_OFFSET) & ~(RC_REG0_RXEN & rfSel)) | \
													(RC_REG0_TXEN & rfSel) | (RC_REG0_SHDN & rfSel)))

// RxEn: reg0 <= (current reg0 with selected TxEn deasserted) + (selected TxEn asserted) + (selected SHDN deasserted)
#define radio_controller_setMode_Rx(ba, rfSel)		(Xil_Out32(ba+RC_SLV_REG0_OFFSET, \
													(Xil_In32(ba+RC_SLV_REG0_OFFSET) & ~(RC_REG0_TXEN & rfSel)) | \
													(RC_REG0_RXEN & rfSel) | (RC_REG0_SHDN & rfSel)))

// Shutdown: reg0 <= (current reg0 with selected Tx, Rx deasserted) + (selected SHDN asserted)
#define radio_controller_setMode_shutdown(ba, rfSel)	(Xil_Out32(ba+RC_SLV_REG0_OFFSET, \
													(Xil_In32(ba+RC_SLV_REG0_OFFSET) & ~((RC_REG0_TXEN | RC_REG0_RXEN | RC_REG0_SHDN) & rfSel))))

// Standby: reg0 <= (current reg0 with selected Tx, Rx, SHDN deasserted)
#define radio_controller_setMode_standby(ba, rfSel)	(Xil_Out32(ba+RC_SLV_REG0_OFFSET, \
													(Xil_In32(ba+RC_SLV_REG0_OFFSET) & ~((RC_REG0_TXEN | RC_REG0_RXEN) & rfSel)) | \
													(RC_REG0_SHDN & rfSel)))

// Reset: reg0 <= (current reg0 with selected Tx, Rx, SHDN asserted)
#define radio_controller_setMode_reset(ba, rfSel)	(Xil_Out32(ba+RC_SLV_REG0_OFFSET, \
													(Xil_In32(ba+RC_SLV_REG0_OFFSET) & ~(RC_REG0_SHDN & rfSel)) | \
													((RC_REG0_TXEN | RC_REG0_RXEN) & rfSel)))
													
#define radio_controller_SPI_write(ba, rfsel, regaddr, regdata) (Xil_Out32(ba+RC_SLV_REG5_OFFSET, \
																(rfsel & RC_REG5_RFSEL_ALL) | \
																(regdata & RC_REG5_REGDATA) | \
																((regaddr << RF_REG5_REGADDR_SHIFT) & RC_REG5_REGADDR)))

#if 0
#define radio_controller_setTxDelays(ba, dly_GainRamp, dly_PA, dly_TX, dly_PHY)	Xil_Out32(ba+RC_SLV_REG1_OFFSET, ((Xil_In32(ba+RC_SLV_REG1_OFFSET) & 0xFF000000) | \
																				((dly_GainRamp&0xFF)<<24) | ((dly_PA&0xFF)<<16) | ((dly_TX&0xFF)<<8) | (dly_PHY&0xFF)))
#endif
#define radio_controller_setTxDelays(ba, dly_GainRamp, dly_PA, dly_TX, dly_PHY)	Xil_Out32(ba+RC_SLV_REG1_OFFSET, ( \
																				((dly_GainRamp&0xFF)<<24) | ((dly_PA&0xFF)<<16) | ((dly_TX&0xFF)<<8) | (dly_PHY&0xFF)))

#define radio_controller_setTxGainTiming(ba, gainStep, timeStep)		Xil_Out32(ba+RC_SLV_REG4_OFFSET, (Xil_In32(ba+RC_SLV_REG4_OFFSET) & (~(0x0000FF00))) | \
																		((gainStep&0xF)<<8) | ((timeStep&0xF)<<12))
																				
#define RC_24GHZ 0
#define RC_5GHZ  1

#define RC_GAINSRC_SPI	1
#define RC_GAINSRC_REG	2
#define RC_GAINSRC_HW	3

#define RC_CTRLSRC_HW	1
#define RC_CTRLSRC_REG	2

#define RC_RXHP_OFF		0
#define RC_RXHP_ON		1
			
#define RC_INCLUDED_PARAMS_GAIN_CTRL	1
#define RC_INCLUDED_PARAMS_FILTS		1
#define RC_INCLUDED_PARAMS_MISC 		1
#define RC_INCLUDED_PARAMS_CALIBRATION	1

#define RC_PARAMID_TXGAINS_SPI_CTRL_EN		1
#define RC_PARAMID_RXGAINS_SPI_CTRL_EN		2
#define RC_PARAMID_RXGAIN_RF				3
#define RC_PARAMID_RXGAIN_BB				4
#define RC_PARAMID_TXGAIN_RF				5
#define RC_PARAMID_TXGAIN_BB				6
#define RC_PARAMID_RSSI_HIGH_BW_EN			7
#define RC_PARAMID_TXLINEARITY_PADRIVER		8
#define RC_PARAMID_TXLINEARITY_VGA			9
#define RC_PARAMID_TXLINEARITY_UPCONV		10
#define RC_PARAMID_TXLPF_BW					12
#define RC_PARAMID_RXLPF_BW					13
#define RC_PARAMID_RXLPF_BW_FINE			14
#define RC_PARAMID_RXHPF_HIGH_CUTOFF_EN		15

#define RC_INVALID_PARAM	-2
#define RC_INVALID_PARAMID	-3
#define RC_INVALID_RFSEL	-4
#endif /** RADIO_CONTROLLER_H */
