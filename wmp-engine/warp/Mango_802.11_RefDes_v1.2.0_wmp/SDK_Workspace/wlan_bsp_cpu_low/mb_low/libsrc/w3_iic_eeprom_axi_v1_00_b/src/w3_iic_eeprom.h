/*****************************************************************
* File: w3_iic_eeprom.h
* Copyright (c) 2012 Mango Communications, all rights reseved
* Released under the WARP License
* See http://warp.rice.edu/license for details
*****************************************************************/

/// @cond EXCLUDE_FROM_DOCS
//User code never uses the #define's from this header, so exclude them from the API docs

#ifndef W3_iic_eeprom_H
#define W3_iic_eeprom_H

#include "xil_io.h"

// Address offset for each slave register; exclude from docs, as users never use these directly
#define W3_IIC_EEPROM_USER_SLV_SPACE_OFFSET (0x00000000)
#define W3_IIC_EEPROM_SLV_REG0_OFFSET (W3_IIC_EEPROM_USER_SLV_SPACE_OFFSET + 0x00000000)
#define W3_IIC_EEPROM_SLV_REG1_OFFSET (W3_IIC_EEPROM_USER_SLV_SPACE_OFFSET + 0x00000004)
#define W3_IIC_EEPROM_SLV_REG2_OFFSET (W3_IIC_EEPROM_USER_SLV_SPACE_OFFSET + 0x00000008)
#define W3_IIC_EEPROM_SLV_REG3_OFFSET (W3_IIC_EEPROM_USER_SLV_SPACE_OFFSET + 0x0000000C)
#define W3_IIC_EEPROM_SLV_REG4_OFFSET (W3_IIC_EEPROM_USER_SLV_SPACE_OFFSET + 0x00000010)
#define W3_IIC_EEPROM_SLV_REG5_OFFSET (W3_IIC_EEPROM_USER_SLV_SPACE_OFFSET + 0x00000014)
#define W3_IIC_EEPROM_SLV_REG6_OFFSET (W3_IIC_EEPROM_USER_SLV_SPACE_OFFSET + 0x00000018)
#define W3_IIC_EEPROM_SLV_REG7_OFFSET (W3_IIC_EEPROM_USER_SLV_SPACE_OFFSET + 0x0000001C)

#define IIC_EEPROM_REG_CONFIG_STATUS	W3_IIC_EEPROM_SLV_REG0_OFFSET
#define IIC_EEPROM_REG_CMD				W3_IIC_EEPROM_SLV_REG1_OFFSET
#define IIC_EEPROM_REG_TX				W3_IIC_EEPROM_SLV_REG2_OFFSET
#define IIC_EEPROM_REG_RX				W3_IIC_EEPROM_SLV_REG3_OFFSET

//Masks for config/status register
#define IIC_EEPROM_REGMASK_CLKDIV	0x000000FF
#define IIC_EEPROM_REGMASK_COREEN	0x00000100
#define IIC_EEPROM_REGMASK_RXACK	0x00010000
#define IIC_EEPROM_REGMASK_BUSY		0x00020000
#define IIC_EEPROM_REGMASK_AL		0x00040000
#define IIC_EEPROM_REGMASK_TIP		0x00080000

//Masks for command register
#define IIC_EEPROM_REGMASK_START	0x00000001
#define IIC_EEPROM_REGMASK_STOP		0x00000002
#define IIC_EEPROM_REGMASK_READ		0x00000004
#define IIC_EEPROM_REGMASK_WRITE	0x00000008
#define IIC_EEPROM_REGMASK_ACK		0x00000010

#define IIC_EEPROM_CONTROL_WORD_RD 	0xA1
#define IIC_EEPROM_CONTROL_WORD_WR 	0xA0

void iic_eeprom_init(u32 ba, u8 clkDiv);
inline int iic_eeprom_waitForRxACK(u32 ba);
int iic_eeprom_writeByte(u32 ba, u16 addrToWrite, u8 byteToWrite);
int iic_eeprom_readByte(u32 ba, u16 addrToRead);
u32 w3_eeprom_readSerialNum(u32 ba);
u32 w3_eeprom_read_fpga_dna(u32 ba, int lo_hi);
void w3_eeprom_readEthAddr(u32 ba, u8 addrSel, u8* addrBuf);

#endif /** W3_iic_eeprom_H */
/// @endcond
