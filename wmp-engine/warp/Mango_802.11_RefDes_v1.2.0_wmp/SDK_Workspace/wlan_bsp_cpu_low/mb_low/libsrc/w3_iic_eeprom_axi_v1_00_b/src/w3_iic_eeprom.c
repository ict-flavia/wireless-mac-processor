/*****************************************************************
* File: w3_iic_eeprom.c
* Copyright (c) 2012 Mango Communications, all rights reseved
* Released under the WARP License
* See http://warp.rice.edu/license for details
*****************************************************************/

/** \file w3_iic_eeprom.c

\mainpage
This is the driver for the w3_iic_eeprom core, which implements an IIC master for accessing
the EEPROM on the WARP v3 board.

This driver implements functions for reading and writing individual bytes in the EEPROM. Functions
are also provided for accessing EEPROM entries written during manufacturing (serial number, etc.).

The full EEPROM is readable/writable from user-code. No addresses are write-protected.

Refer to the <a href="http://warp.rice.edu/trac/wiki/HardwareUsersGuides/WARPv3/EEPROM">WARP v3 User Guide</a> for details
on the data written to the EEPROM during manufacturing.

@version 1.00.b
@author Patrick Murphy
@copyright (c) 2012 Mango Communications, Inc. All rights reserved.<br>
Released under the WARP open source license (see http://warp.rice.edu/license)

\brief Main source for EEPROM controller driver

*/

#include "w3_iic_eeprom.h"
#include "stdio.h"

/**
\defgroup user_functions Functions
\brief Functions to call from user code
\addtogroup user_functions

Example:
\code{.c}
//Assumes user code sets EEPROM_BASEADDR to base address of w3_iic_eeprom core, as set in xparameters.h

int x;
u32 board_sn;

//Initialize the EEPROM controller at boot
iic_eeprom_init(EEPROM_BASEADDR, 0x64);

//Write a value to the EEPROM (set EEPROM byte address 2345 to 182)
x = iic_eeprom_writeByte(EEPROM_BASEADDR, 2345, 182);
if(x != 0) xil_printf("EEPROM Write Error!\n");

//Read the value back from EEPROM
x = iic_eeprom_readByte(EEPROM_BASEADDR, 2345);
if(x != 182) xil_printf("EEPROM Read Error (read %d, should be 182)!\n", x);

//Read the WARP v3 board serial number from the EEPROM
board_sn = w3_eeprom_readSerialNum(EEPROM_BASEADDDR);
xil_printf("Board s/n: W3-a-%05d\n", board_sn);

\endcode

@{
*/

/**
\brief Initializes the EEPROM controller. This function must be called once at boot before any EEPROM read/write operations.
\param ba Base memory address of w3_iic_eeprom pcore
\param clkDiv Clock divider for IIC clock (set 0x64 for 160MHz bus)
*/
void iic_eeprom_init(u32 ba, u8 clkDiv)
{
	//Configure the IIC master core
	Xil_Out32(ba+IIC_EEPROM_REG_CMD, 0);
	Xil_Out32(ba+IIC_EEPROM_REG_CONFIG_STATUS, (IIC_EEPROM_REGMASK_CLKDIV & clkDiv));
	Xil_Out32(ba+IIC_EEPROM_REG_CONFIG_STATUS, Xil_In32(ba+IIC_EEPROM_REG_CONFIG_STATUS) | IIC_EEPROM_REGMASK_COREEN);

	return;
}

/**
\brief Writes one bytes to the EEPROM
\param ba Base memory address of w3_iic_eeprom pcore
\param addrToWrite Byte address to write, in [0,16000] (addresses >16000 are reserved)
\param byteToWrite Byte value to write
\return Returns 0 if EEPROM write succeeds. Returns -1 if an error occurs.
*/
int iic_eeprom_writeByte(u32 ba, u16 addrToWrite, u8 byteToWrite)
{
	int writeDone;
	/* Process to write 1 byte to random address in IIC EEPROM
		- Write EEPROM control word to Tx register {1 0 1 0 0 0 0 RNW}, RNW=0
			- Assert START and WRITE command bits
			- Poll TIP bit, wait for TIP=0
			- Read RXACK status bit, should be 0
		- Write top 8 bits of target address to Tx register
			- Assert WRITE command bit
			- Poll TIP bit, wait for TIP=0
			- Read RXACK status bit, should be 0
		- Write bottom 8 bits of target address to Tx register
			- Assert WRITE command bit
			- Poll TIP bit, wait for TIP=0
			- Read RXACK status bit, should be 0
		- Write data byte to Tx register
			- Assert STOP and WRITE command bits
			- Poll TIP bit, wait for TIP=0
			- Read RXACK status bit, should be 0
	*/
	#if 0 //protect upper EEPROM bytes
	if(addrToWrite > 16000) {
		xil_printf("ERROR! High bytes read-only by default. Edit %s to override!\n", __FILE__);
		return -1;
	}
	#endif

	Xil_Out32(ba+IIC_EEPROM_REG_TX, IIC_EEPROM_CONTROL_WORD_WR);
	Xil_Out32(ba+IIC_EEPROM_REG_CMD, (IIC_EEPROM_REGMASK_START | IIC_EEPROM_REGMASK_WRITE));
	if(iic_eeprom_waitForRxACK(ba)) {print("EEPROM: Error (1)!\r"); return -1;}

	Xil_Out32(ba+IIC_EEPROM_REG_TX, (addrToWrite>>8 & 0xFF));
	Xil_Out32(ba+IIC_EEPROM_REG_CMD, (IIC_EEPROM_REGMASK_WRITE));
	if(iic_eeprom_waitForRxACK(ba)) {print("EEPROM: Error (2)!\r"); return -1;}

	Xil_Out32(ba+IIC_EEPROM_REG_TX, (addrToWrite & 0xFF));
	Xil_Out32(ba+IIC_EEPROM_REG_CMD, (IIC_EEPROM_REGMASK_WRITE));
	if(iic_eeprom_waitForRxACK(ba)) {print("EEPROM: Error (3)!\r"); return -1;}

	Xil_Out32(ba+IIC_EEPROM_REG_TX, (byteToWrite & 0xFF));
	Xil_Out32(ba+IIC_EEPROM_REG_CMD, (IIC_EEPROM_REGMASK_STOP | IIC_EEPROM_REGMASK_WRITE));
	if(iic_eeprom_waitForRxACK(ba)) {print("EEPROM: Error (4)!\r"); return -1;}

	/* Poll the EEPROM until its internal write cycle is complete
	   This is done by:
		-Send START
		-Write control word for write command
		-Check for ACK; no ACK means internal write is still ongoing
	*/
	writeDone = 0;
	while(writeDone == 0)
	{
		Xil_Out32(ba+IIC_EEPROM_REG_TX, IIC_EEPROM_CONTROL_WORD_WR);
		Xil_Out32(ba+IIC_EEPROM_REG_CMD, (IIC_EEPROM_REGMASK_START | IIC_EEPROM_REGMASK_WRITE));
		if(iic_eeprom_waitForRxACK(ba) == 0) {writeDone = 1;}
	}

	return 0;
}

/**
\brief Reads one bytes to the EEPROM
\param ba Base memory address of w3_iic_eeprom pcore
\param addrToRead Byte address to read (in [0,16383])
\return If EEPROM read succeeds, the read byte is returned in the LSB. If an error occurs, returns -1.
*/
int iic_eeprom_readByte(u32 ba, u16 addrToRead)
{
	/* Process to read 1 byte from random address in IIC EEPROM
		- Write EEPROM control word to Tx register {1 0 1 0 0 0 0 RNW}, RNW=0
			- Assert START and WRITE command bits
			- Poll TIP bit, wait for TIP=0
			- Read RXACK status bit, should be 0
		- Write top 8 bits of target address to Tx register
			- Assert WRITE command bit
			- Poll TIP bit, wait for TIP=0
			- Read RXACK status bit, should be 0
		- Write bottom 8 bits of target address to Tx register
			- Assert WRITE command bit
			- Poll TIP bit, wait for TIP=0
			- Read RXACK status bit, should be 0
		- Write EEPROM control word to Tx register {1 0 1 0 0 0 0 RNW}, RNW=1
			- Assert START and WRITE command bits (causes repeat START event)
			- Poll TIP bit, wait for TIP=0
			- Read RXACK status bit, should be 0
		- Assert STOP, READ and ACK command bits
		- Read received byte from rx register
	*/


	Xil_Out32(ba+IIC_EEPROM_REG_TX, IIC_EEPROM_CONTROL_WORD_WR);
	Xil_Out32(ba+IIC_EEPROM_REG_CMD, (IIC_EEPROM_REGMASK_START | IIC_EEPROM_REGMASK_WRITE));
	if(iic_eeprom_waitForRxACK(ba)) {print("EEPROM: Error (1)!\r"); return -1;}

	Xil_Out32(ba+IIC_EEPROM_REG_TX, (addrToRead>>8 & 0xFF));
	Xil_Out32(ba+IIC_EEPROM_REG_CMD, (IIC_EEPROM_REGMASK_WRITE));
	if(iic_eeprom_waitForRxACK(ba)) {print("EEPROM: Error (2)!\r"); return -1;}

	Xil_Out32(ba+IIC_EEPROM_REG_TX, (addrToRead & 0xFF));
	Xil_Out32(ba+IIC_EEPROM_REG_CMD, (IIC_EEPROM_REGMASK_WRITE));
	if(iic_eeprom_waitForRxACK(ba)) {print("EEPROM: Error (3)!\r"); return -1;}

	Xil_Out32(ba+IIC_EEPROM_REG_TX, IIC_EEPROM_CONTROL_WORD_RD);
	Xil_Out32(ba+IIC_EEPROM_REG_CMD, (IIC_EEPROM_REGMASK_START | IIC_EEPROM_REGMASK_WRITE));
	if(iic_eeprom_waitForRxACK(ba)) {print("EEPROM: Error (4)!\r"); return -1;}

	Xil_Out32(ba+IIC_EEPROM_REG_CMD, (IIC_EEPROM_REGMASK_STOP | IIC_EEPROM_REGMASK_READ | IIC_EEPROM_REGMASK_ACK));
	while(Xil_In32(ba+IIC_EEPROM_REG_CONFIG_STATUS) & IIC_EEPROM_REGMASK_TIP) {}

	return (Xil_In32(ba+IIC_EEPROM_REG_RX) & 0xFF);

}

/**
\brief Reads the WARP v3 board serial number (programmed during manufacturing)
\param ba Base memory address of w3_iic_eeprom pcore
\return Numeric part of board serial number (prefix "W3-a-" not stored in EEPROM)
*/
u32 w3_eeprom_readSerialNum(u32 ba)
{
	int x0,x1,x2;

	x0 = (int)iic_eeprom_readByte(ba, 16372);
	x1 = (int)iic_eeprom_readByte(ba, 16373);
	x2 = (int)iic_eeprom_readByte(ba, 16374);

	return (x2<<16 | x1<<8 | x0);
}

/**
\brief Reads one of the WARP v3 board Ethernet MAC addresses (programmed during manufacturing)
\param ba Base memory address of w3_iic_eeprom pcore
\param addrSel Selection of Ethernet address to retrieve (0=ETH_A address, 1=ETH_B address)
\param addrBuf Pointer to array of 6 bytes to store retrieved address. This function will overwrite 6 bytes starting at addrBuf.
*/
void w3_eeprom_readEthAddr(u32 ba, u8 addrSel, u8* addrBuf)
{
	u8 addrOffset;
	u32 sn;

	addrOffset = addrSel ? 6 : 0;
	
	addrBuf[5] = iic_eeprom_readByte(ba, 16352+addrOffset);
	addrBuf[4] = iic_eeprom_readByte(ba, 16353+addrOffset);
	addrBuf[3] = iic_eeprom_readByte(ba, 16354+addrOffset);
	addrBuf[2] = iic_eeprom_readByte(ba, 16355+addrOffset);
	addrBuf[1] = iic_eeprom_readByte(ba, 16356+addrOffset);
	addrBuf[0] = iic_eeprom_readByte(ba, 16357+addrOffset);

	if( ( (addrBuf[0] == 0x40) && (addrBuf[1] == 0xD8) && (addrBuf[2] == 0x55) ) == 0) {
		//EEPROM contains invalid (or no) MAC address
		// Use the node serial number to compute a valid address instead
		// See http://warpproject.org/trac/wiki/HardwareUsersGuides/WARPv3/Ethernet#MACAddresses
		sn = 2 * w3_eeprom_readSerialNum(ba);
		addrBuf[0] = 0x40;
		addrBuf[1] = 0xD8;
		addrBuf[2] = 0x55;
		addrBuf[3] = 0x04;
		addrBuf[4] = 0x20 + ((sn>>8)&0xF);
		addrBuf[5] = 0x00 + (sn&0xFF) + (addrSel & 0x1);
	}
    
    // If the first three octets match, then the node has a serial number that does not follow the 
    // serial_number * 2 scheme.  However, we still need to check to make sure that octet [3] and [4]
    // are correct.
    if (addrBuf[3] != 0x04) {                         // addrBuf[3] must be 0x04
        addrBuf[3] = 0x04; 
    }    

    if ((addrBuf[4] & 0xF0) != 0x20) {                // addrBuf[4] must be 0x2X, where X is in [0..F]
        addrBuf[4] = 0x20 | (addrBuf[4] & 0x0F); 
    }
    
	return;
}

/**
\brief Reads part of the 56-bit Virtex-6 FPGA DNA value (copied to EEPROM during manufacturing)
\param ba Base memory address of w3_iic_eeprom pcore
\param lo_hi Selects between 32 LSB or 24 MSB of DNA value (0=LSB, 1=MSB)
\return Returns selected portion of FPGA DNA value
*/
u32 w3_eeprom_read_fpga_dna(u32 ba, int lo_hi)
{
	int x0,x1,x2,x3;
	if(lo_hi==0)
	{
		x0 = (int)iic_eeprom_readByte(ba, 16376);
		x1 = (int)iic_eeprom_readByte(ba, 16377);
		x2 = (int)iic_eeprom_readByte(ba, 16378);
		x3 = (int)iic_eeprom_readByte(ba, 16379);
	}
	else if(lo_hi==1)
	{
		x0 = (int)iic_eeprom_readByte(ba, 16380);
		x1 = (int)iic_eeprom_readByte(ba, 16381);
		x2 = (int)iic_eeprom_readByte(ba, 16382);
		x3 = (int)iic_eeprom_readByte(ba, 16383);
	}

	return (x3<<24 | x2<<16 | x1<<8 | x0);
}
/** @}*/ //END group user_functions

/// @cond EXCLUDE_FROM_DOCS
// User code never calls this, so exclude it from the API docs
//Returns 0 if IIC bus ACK is detected
inline int iic_eeprom_waitForRxACK(u32 ba)
{
//	xil_printf("Status: 0x%08x CMD: 0x%08x\r", Xil_In32(ba+IIC_EEPROM_REG_CONFIG_STATUS), Xil_In32(ba+IIC_EEPROM_REG_CMD));
	while(Xil_In32(ba+IIC_EEPROM_REG_CONFIG_STATUS) & IIC_EEPROM_REGMASK_TIP) {}

	return (0 != (Xil_In32(ba+IIC_EEPROM_REG_CONFIG_STATUS) & IIC_EEPROM_REGMASK_RXACK));
}
/// @endcond
