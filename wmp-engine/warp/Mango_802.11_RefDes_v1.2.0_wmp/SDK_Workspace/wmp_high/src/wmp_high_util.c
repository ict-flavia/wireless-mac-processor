/*
 * wmp_high_util.c
 *
 *  Created on: Nov 8, 2013
 *      Author: Nicolo' Facchi
 */


#include "wmp_high_util.h"
#include "wmp_fsm.h"
#include "wmp_common_sw_reg.h"
#include "wmp_high_fsm_slots_handler.h"

#include "wlan_mac_ipc_util.h"
#include "wlan_mac_802_11_defs.h"

#include "xil_types.h"
#include "xparameters.h"

#include "xintc.h"
#include "wlan_mac_eth_util.h"

/************************************************************
 * Only for test: delete in the final release
 ************************************************************/
/*static u8 fsmdefault[] = {// SingleTXnoACK, backoff 0
		 0x00, 0x00, 0x01, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00,
		 0x04, 0xFF, 0x0F, 0x00, 0x00, 0x04, 0x0B, 0x00, 0x00, 0x00,
		 0x04, 0x00, 0x14, 0x00, 0x00, 0x04, 0xA4, 0x73, 0x00, 0x00,
		 0x04, 0x6D, 0x95, 0x00, 0x00, 0x04, 0x00, 0x14, 0x00, 0x00,
		 0x04, 0xA4, 0x73, 0x00, 0x00, 0x04, 0x6D, 0x95, 0x00, 0x00,
		 0x04, 0x00, 0x00, 0x00, 0x00, 0x04, 0x10, 0x27, 0x00, 0x00,
		 0x04, 0x00, 0x00, 0x00, 0x00, 0x04, 0x20, 0x4E, 0x00, 0x00,
		 0x04, 0x00, 0x00, 0x00, 0x00, 0x04, 0x40, 0x9C, 0x00, 0x00,
		 0x04, 0x01, 0x00, 0x00, 0x00, 0x04, 0x80, 0x38, 0x00, 0x00,
		 0x04, 0x00, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00,
		 0x04, 0x00, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00,
		 0x04, 0x01, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00,
		 0x04, 0x01, 0x00, 0x00, 0x00, 0x04, 0x01, 0x00, 0x00, 0x00,
		 0x04, 0x01, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00,
		 0x04, 0xFF, 0xFF, 0x00, 0x00, 0x04, 0x1F, 0x00, 0x00, 0x00,
		 0x04, 0xFF, 0x03, 0x00, 0x00, 0x04, 0x1F, 0x00, 0x00, 0x00,
		 0x10, 0x00, 0xF0, 0x00, 0x00, 0x06, 0x00, 0x00, 0xF1, 0x0D,
		 0x01, 0xFD, 0x00, 0x00, 0x10, 0x03, 0xF0, 0x00, 0x00, 0x06,
		 0x00, 0x00, 0xFF, 0xF5, 0x02, 0x00, 0x00, 0x00, 0x10, 0x06,
		 0xF0, 0x00, 0x00, 0x06, 0x00, 0x00, 0xFF, 0xFB, 0x00, 0x00,
		 0x00, 0x00, 0x99,
};*/

/*static u8 fsmdefault[] = {//RX and ACK
		 0x00, 0x00, 0x01, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00,
		 0x04, 0xFF, 0x0F, 0x00, 0x00, 0x04, 0x0B, 0x00, 0x00, 0x00,
		 0x04, 0x00, 0x14, 0x00, 0x00, 0x04, 0xA4, 0x73, 0x00, 0x00,
		 0x04, 0x6D, 0x95, 0x00, 0x00, 0x04, 0x00, 0x14, 0x00, 0x00,
		 0x04, 0xA4, 0x73, 0x00, 0x00, 0x04, 0x6D, 0x95, 0x00, 0x00,
		 0x04, 0x00, 0x00, 0x00, 0x00, 0x04, 0x10, 0x27, 0x00, 0x00,
		 0x04, 0x00, 0x00, 0x00, 0x00, 0x04, 0x20, 0x4E, 0x00, 0x00,
		 0x04, 0x00, 0x00, 0x00, 0x00, 0x04, 0x40, 0x9C, 0x00, 0x00,
		 0x04, 0x01, 0x00, 0x00, 0x00, 0x04, 0x80, 0x38, 0x00, 0x00,
		 0x04, 0x00, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00,
		 0x04, 0x00, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00,
		 0x04, 0x01, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00,
		 0x04, 0x01, 0x00, 0x00, 0x00, 0x04, 0x01, 0x00, 0x00, 0x00,
		 0x04, 0x01, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00,
		 0x04, 0xFF, 0xFF, 0x00, 0x00, 0x04, 0x1F, 0x00, 0x00, 0x00,
		 0x04, 0xFF, 0x03, 0x00, 0x00, 0x04, 0x1F, 0x00, 0x00, 0x00,
		 0x10, 0x00, 0xF0, 0x00, 0x00, 0x06, 0x00, 0x00, 0xFF, 0x08,
		 0x01, 0x00, 0x00, 0x00, 0x10, 0x03, 0xF2, 0x00, 0x00, 0x06,
		 0x00, 0x00, 0xFF, 0xF4, 0x01, 0xFB, 0x00, 0x00, 0xFF, 0x09,
		 0x00, 0x00, 0x00, 0x00, 0x99,
};*/

static u8 fsmdefault[] = { //DCF
		 0x00, 0x00, 0x01, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00,
		 0x04, 0xFF, 0xFF, 0x00, 0x00, 0x04, 0x0B, 0x00, 0x00, 0x00,
		 0x04, 0x00, 0x14, 0x00, 0x00, 0x04, 0xA4, 0x73, 0x00, 0x00,
		 0x04, 0x6D, 0x95, 0x00, 0x00, 0x04, 0x00, 0x14, 0x00, 0x00,
		 0x04, 0xA4, 0x73, 0x00, 0x00, 0x04, 0x6D, 0x95, 0x00, 0x00,
		 0x04, 0x00, 0x00, 0x00, 0x00, 0x04, 0x10, 0x27, 0x00, 0x00,
		 0x04, 0x00, 0x00, 0x00, 0x00, 0x04, 0x20, 0x4E, 0x00, 0x00,
		 0x04, 0x00, 0x00, 0x00, 0x00, 0x04, 0x40, 0x9C, 0x00, 0x00,
		 0x04, 0x01, 0x00, 0x00, 0x00, 0x04, 0x80, 0x38, 0x00, 0x00,
		 0x04, 0x00, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00,
		 0x04, 0x00, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00,
		 0x04, 0x01, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00,
		 0x04, 0x01, 0x00, 0x00, 0x00, 0x04, 0x01, 0x00, 0x00, 0x00,
		 0x04, 0x01, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00,
		 0x04, 0xFF, 0xFF, 0x00, 0x00, 0x04, 0x1F, 0x00, 0x00, 0x00,
		 0x04, 0xFF, 0x03, 0x00, 0x00, 0x04, 0x1F, 0x00, 0x00, 0x00,
		 0x10, 0x00, 0x04, 0x00, 0x00, 0x06, 0x00, 0x0C, 0x12, 0xFF,
		 0x12, 0x16, 0x00, 0x08, 0xFF, 0xFF, 0x01, 0x08, 0x00, 0x0D,
		 0xFF, 0xFF, 0x08, 0x00, 0x00, 0x00, 0x10, 0x09, 0x00, 0x00,
		 0x00, 0x06, 0x00, 0x29, 0xFF, 0xFF, 0x04, 0x00, 0x00, 0x00,
		 0x10, 0x0C, 0x02, 0x00, 0x00, 0x06, 0x00, 0x08, 0xFF, 0xFF,
		 0x01, 0x08, 0x00, 0x02, 0xF0, 0xFF, 0x03, 0x02, 0x00, 0x00,
		 0x10, 0x12, 0x00, 0x00, 0x00, 0x06, 0x00, 0x1C, 0xFF, 0xFF,
		 0x0A, 0x00, 0x00, 0x00, 0x10, 0x15, 0xF2, 0x00, 0x00, 0x06,
		 0x00, 0x10, 0x11, 0xFF, 0x05, 0x16, 0x00, 0x00, 0xFF, 0xFF,
		 0x05, 0x00, 0x00, 0x00, 0x10, 0x1B, 0x00, 0x00, 0x00, 0x06,
		 0x00, 0x09, 0xFF, 0xFF, 0x06, 0x00, 0x00, 0x00, 0x10, 0x1E,
		 0xF2, 0x00, 0x00, 0x06, 0x00, 0x10, 0x1F, 0xFF, 0x07, 0x00,
		 0x00, 0x00, 0xFF, 0xFF, 0x00, 0x00, 0x00, 0x00, 0x10, 0x24,
		 0x00, 0x00, 0x00, 0x06, 0x00, 0x1C, 0xFF, 0xFF, 0x00, 0x00,
		 0x00, 0x00, 0x10, 0x27, 0xF2, 0x00, 0x00, 0x06, 0x00, 0x03,
		 0x00, 0x0F, 0x02, 0x0D, 0x00, 0x00, 0xFF, 0xFF, 0x09, 0x2E,
		 0x00, 0x00, 0x10, 0x2D, 0x00, 0x00, 0x00, 0x06, 0x00, 0x00,
		 0xF0, 0xFF, 0x02, 0x0D, 0x00, 0x00, 0x10, 0x30, 0xF2, 0x00,
		 0x00, 0x06, 0x00, 0x07, 0x01, 0x2F, 0x00, 0x0E, 0x00, 0x00,
		 0xFF, 0xFF, 0x0B, 0x00, 0x00, 0x00, 0x10, 0x36, 0x02, 0x00,
		 0x00, 0x06, 0x00, 0x08, 0xFF, 0xFF, 0x0D, 0x08, 0x00, 0x0C,
		 0x00, 0xFF, 0x0C, 0x0A, 0x00, 0x00, 0x10, 0x3C, 0x00, 0x00,
		 0x00, 0x06, 0x00, 0x00, 0xF0, 0xFF, 0x00, 0x0E, 0x00, 0x00,
		 0x10, 0x3F, 0x00, 0x00, 0x00, 0x06, 0x00, 0x29, 0xFF, 0xFF,
		 0x0E, 0x00, 0x00, 0x00, 0x10, 0x42, 0xF2, 0x00, 0x00, 0x06,
		 0x00, 0x10, 0x0F, 0xFF, 0x10, 0x00, 0x00, 0x00, 0xF0, 0xFF,
		 0x0F, 0x0A, 0x00, 0x00, 0x10, 0x48, 0x00, 0x00, 0x00, 0x06,
		 0x00, 0x00, 0xF0, 0xFF, 0x04, 0x0E, 0x00, 0x00, 0x10, 0x4B,
		 0x00, 0x00, 0x00, 0x06, 0x00, 0x09, 0xF1, 0xFF, 0x11, 0x0A,
		 0x00, 0x00, 0x10, 0x4E, 0x00, 0x00, 0x00, 0x06, 0x00, 0x00,
		 0xF1, 0xFF, 0x00, 0x0E, 0x00, 0x00, 0x10, 0x51, 0x00, 0x00,
		 0x00, 0x06, 0x00, 0x1C, 0xFF, 0xFF, 0x00, 0x00, 0x00, 0x00,
		 0x99,
};

/*
static u8 fsmdefault[] = {// DCF_old
		 0x00, 0x00, 0x01, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00,
         0x04, 0xFF, 0xFF, 0x00, 0x00, 0x04, 0x0B, 0x00, 0x00, 0x00,
         0x04, 0x00, 0x14, 0x00, 0x00, 0x04, 0xA4, 0x73, 0x00, 0x00,
         0x04, 0x6D, 0x95, 0x00, 0x00, 0x04, 0x00, 0x14, 0x00, 0x00,
         0x04, 0xA4, 0x73, 0x00, 0x00, 0x04, 0x6D, 0x95, 0x00, 0x00,
         0x04, 0x00, 0x00, 0x00, 0x00, 0x04, 0x10, 0x27, 0x00, 0x00,
         0x04, 0x00, 0x00, 0x00, 0x00, 0x04, 0x20, 0x4E, 0x00, 0x00,
         0x04, 0x00, 0x00, 0x00, 0x00, 0x04, 0x40, 0x9C, 0x00, 0x00,
         0x04, 0x01, 0x00, 0x00, 0x00, 0x04, 0x80, 0x38, 0x00, 0x00,
         0x04, 0x00, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00,
         0x04, 0x00, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00,
         0x04, 0x01, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00,
         0x04, 0x01, 0x00, 0x00, 0x00, 0x04, 0x01, 0x00, 0x00, 0x00,
         0x04, 0x01, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00,
         0x04, 0xFF, 0xFF, 0x00, 0x00, 0x04, 0x1F, 0x00, 0x00, 0x00,
         0x04, 0xFF, 0x03, 0x00, 0x00, 0x04, 0x1F, 0x00, 0x00, 0x00,
         0x10, 0x00, 0x06, 0x00, 0x00, 0x06, 0x00, 0x0C, 0x12, 0xFF,
         0x15, 0x16, 0x00, 0x08, 0xFF, 0xFF, 0x01, 0x08, 0x00, 0x0D,
         0xFF, 0xFF, 0x0A, 0x00, 0x00, 0xF3, 0xFF, 0xFF, 0x00, 0xFA,
         0x00, 0x00, 0x10, 0x0C, 0x00, 0x00, 0x00, 0x06, 0x00, 0x29,
         0xFF, 0xFF, 0x04, 0x09, 0x00, 0x00, 0x10, 0x0F, 0x02, 0x00,
         0x00, 0x06, 0x00, 0x08, 0xFF, 0xFF, 0x01, 0x08, 0x00, 0x02,
         0xF0, 0xFF, 0x03, 0x02, 0x00, 0x00, 0x10, 0x15, 0x00, 0x00,
         0x00, 0x06, 0x00, 0x1C, 0xFF, 0xFF, 0x0C, 0x00, 0x00, 0x00,
         0x10, 0x18, 0xF2, 0x00, 0x00, 0x06, 0x00, 0x0E, 0x3F, 0x4F,
         0x08, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0x05, 0x00, 0x00, 0x00,
         0x10, 0x1E, 0x00, 0x00, 0x00, 0x06, 0x00, 0x09, 0xFF, 0xFF,
         0x06, 0x00, 0x00, 0x00, 0x10, 0x21, 0xF2, 0x00, 0x00, 0x06,
         0x00, 0x0E, 0x3F, 0x4F, 0x09, 0x00, 0x00, 0x00, 0xFF, 0xFF,
         0x00, 0x00, 0x00, 0x00, 0x10, 0x27, 0x00, 0x00, 0x00, 0x06,
         0x00, 0x1C, 0xFF, 0xFF, 0x00, 0x00, 0x00, 0x00, 0x10, 0x2A,
         0xF2, 0x00, 0x00, 0x06, 0x00, 0x0E, 0x0F, 0x2F, 0x05, 0x00,
         0x00, 0x00, 0xF1, 0xFF, 0x05, 0x16, 0x00, 0x00, 0x10, 0x30,
         0xF2, 0x00, 0x00, 0x06, 0x00, 0x0E, 0x0F, 0x2F, 0x00, 0x00,
         0x00, 0x00, 0xFF, 0xFF, 0x07, 0x00, 0x00, 0x00, 0x10, 0x36, 
         0xF2, 0x00, 0x00, 0x06, 0x00, 0x03, 0x00, 0x0F, 0x02, 0x0D,
         0x00, 0x00, 0xFF, 0xFF, 0x0B, 0x2E, 0x00, 0x00, 0x10, 0x3C,
         0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0xF0, 0xFF, 0x02, 0x0D,
         0x00, 0x00, 0x10, 0x3F, 0xF2, 0x00, 0x00, 0x06, 0x00, 0x07,
         0x01, 0x2F, 0x00, 0x0E, 0x00, 0x00, 0xFF, 0xFF, 0x0D, 0x00,
         0x00, 0x00, 0x10, 0x45, 0x02, 0x00, 0x00, 0x06, 0x00, 0x08,
         0xFF, 0xFF, 0x0F, 0x08, 0x00, 0x0C, 0x00, 0xFF, 0x0E, 0x0A,
         0x00, 0x00, 0x10, 0x4B, 0x00, 0x00, 0x00, 0x06, 0x00, 0x00,
         0xF0, 0xFF, 0x00, 0x0E, 0x00, 0x00, 0x10, 0x4E, 0x00, 0x00,
         0x00, 0x06, 0x00, 0x29, 0xFF, 0xFF, 0x10, 0x09, 0x00, 0x00,
         0x10, 0x51, 0xF2, 0x00, 0x00, 0x06, 0x00, 0x0E, 0x1F, 0x1F,
         0x11, 0x00, 0x00, 0x00, 0xF0, 0xFF, 0x12, 0x0A, 0x00, 0x00,
         0x10, 0x57, 0xF2, 0x00, 0x00, 0x06, 0x00, 0x0E, 0x3F, 0x4F,
         0x13, 0x00, 0x00, 0x00, 0xF0, 0xFF, 0x12, 0x0A, 0x00, 0x00,
         0x10, 0x5D, 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0xF0, 0xFF,
         0x04, 0x0E, 0x00, 0x00, 0x10, 0x60, 0x00, 0x00, 0x00, 0x06,
         0x00, 0x09, 0xF1, 0xFF, 0x14, 0x0A, 0x00, 0x00, 0x10, 0x63, 
         0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0xF1, 0xFF, 0x00, 0x0E,
         0x00, 0x00, 0x10, 0x66, 0x00, 0x00, 0x00, 0x06, 0x00, 0x1C,
         0xFF, 0xFF, 0x00, 0x00, 0x00, 0x00, 0x99, 
};
*/

/*static u8 fsmdefault[] = {
		0x00, 0x00, 0x01, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00,
		0x04, 0xFF, 0x0F, 0x00, 0x00, 0x04, 0x0B, 0x00, 0x00, 0x00,
		0x04, 0x00, 0x14, 0x00, 0x00, 0x04, 0xA4, 0x73, 0x00, 0x00,
		0x04, 0x6D, 0x95, 0x00, 0x00, 0x04, 0x00, 0x14, 0x00, 0x00,
		0x04, 0xA4, 0x73, 0x00, 0x00, 0x04, 0x6D, 0x95, 0x00, 0x00,
		0x04, 0x00, 0x00, 0x00, 0x00, 0x04, 0x10, 0x27, 0x00, 0x00,
		0x04, 0x00, 0x00, 0x00, 0x00, 0x04, 0x20, 0x4E, 0x00, 0x00,
		0x04, 0x00, 0x00, 0x00, 0x00, 0x04, 0x40, 0x9C, 0x00, 0x00,
		0x04, 0x01, 0x00, 0x00, 0x00, 0x04, 0x80, 0x38, 0x00, 0x00,
		0x04, 0x00, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00,
		0x04, 0x00, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00,
		0x04, 0x01, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00,
		0x04, 0x01, 0x00, 0x00, 0x00, 0x04, 0x01, 0x00, 0x00, 0x00,
		0x04, 0x01, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00,
		0x04, 0xFF, 0xFF, 0x00, 0x00, 0x04, 0x1F, 0x00, 0x00, 0x00,
		0x04, 0xFF, 0x03, 0x00, 0x00, 0x04, 0x1F, 0x00, 0x00, 0x00,
		0x10, 0x00, 0xF0, 0x00, 0x00, 0x06, 0x00, 0x00, 0xF0, 0x00,
		0x01, 0xFC, 0x00, 0x00, 0x10, 0x03, 0xF0, 0x00, 0x00, 0x06,
		0x00, 0x00, 0x0F, 0xF6, 0x00, 0xFF, 0x00, 0x00, 0x99,
};*/
/************************************************************
 * Only for test: delete in the final release
 ************************************************************/

static u8 wmp_high_util_fake_assoc_addr[] = WMP_HIGH_TEST_FAKE_ASSOC_ADDR;

static struct wmp_high_util_tx_buf_info wmp_tx_buf_info[TX_BUFFER_NUM];

u8 wmp_cmd_resp[WMP_CMD_FRAME_MAX_SIZE];

void wmp_high_fsm_init()
{
	struct wmp_common_sw_reg *container_cmn = wmp_common_sw_reg_get_container();
	struct wmp_fsm *wmp_fsm = wmp_common_sw_reg_get_fsm(container_cmn);
	u8 next_slot;
	int ret, i;
	wlan_ipc_msg ipc_msg_to_low;
	u64 ipc_msg_to_low_payload[1];

	wmp_fsm_init(wmp_fsm,
				XPAR_BRAM_0_DEVICE_ID, XPAR_MUTEX_0_DEVICE_ID);

	// clear state on soft reset
	for (i = 0; i < WMP_FSM_BUFFER_MUTEX_N; i++) {
		XMutex_Unlock(&(wmp_fsm->fsm_mutex), i);
	}

	wmp_high_fsm_slots_handler_init();

	next_slot = wmp_high_fsm_slots_handler_next_slot();

	ret = wmp_fsm_acquire(wmp_fsm, next_slot);

	if (ret == XST_FAILURE) {
		xil_printf("ERROR during FSM slot %d acquisition!\n", next_slot);
		return;
	}

	ret = wmp_fsm_write(wmp_fsm, fsmdefault);

	if (ret) {
		xil_printf("WMP_HIGH_FSM_INIT ERROR: fsm write fails!\n");
		return;
	}

	wmp_high_fsm_slots_handler_set_last_written(next_slot);
	wmp_high_fsm_slots_handler_set_slot_used(next_slot, 0);

	ret = wmp_fsm_release(wmp_fsm);

	if (ret == XST_FAILURE)
		xil_printf("ERROR during FSM slot %d release!\n", next_slot);

	wmp_high_printf(WMP_HIGH_PL_INFO, "Require CPU_LOW to run XFSM at slot %d\n",
			next_slot);

	ipc_msg_to_low.msg_id = IPC_MBOX_MSG_ID(IPC_MBOX_RUN_FSM);
	ipc_msg_to_low.arg0 = next_slot;
	ipc_msg_to_low.num_payload_words = (sizeof(ipc_msg_to_low_payload)/sizeof(u32));
	ipc_msg_to_low_payload[0] = 0;
	ipc_msg_to_low.payload_ptr       = (u32 *)&(ipc_msg_to_low_payload[0]);
	ipc_mailbox_write_msg(&ipc_msg_to_low);


	for (i = 0; i < TX_BUFFER_NUM; i++) {
		wmp_tx_buf_info[i].flags = WMP_HIGH_UTIL_TX_BUF_FREE;
		wmp_tx_buf_info[i].timestamp = 0L;
	}
}

void wmp_high_util_create_fake_assoc(station_info *access_point)
{
	if (WMP_HIGH_TEST_FAKE_ASSOC == 0)
		return;

	access_point->AID = 1;
	access_point->addr[0] = wmp_high_util_fake_assoc_addr[0];
	access_point->addr[1] = wmp_high_util_fake_assoc_addr[1];
	access_point->addr[2] = wmp_high_util_fake_assoc_addr[2];
	access_point->addr[3] = wmp_high_util_fake_assoc_addr[3];
	access_point->addr[4] = wmp_high_util_fake_assoc_addr[4];
	access_point->addr[5] = wmp_high_util_fake_assoc_addr[5];

	access_point->tx_rate = WMP_HIGH_UTIL_FAKE_ASSOC_RATE;
}

u32 get_wmp_tx_buf_info(int index)
{
	if (index > TX_BUFFER_NUM) {
		wmp_high_printf(WMP_HIGH_PL_DEBUG, "%s: tx buf of index %d does not exist",
				__FUNCTION__, index);
		return 0;
	}

	return wmp_tx_buf_info[index].flags;
}

void set_wmp_tx_buf_info(int index, u32 flag_val)
{
	if (index > TX_BUFFER_NUM) {
		wmp_high_printf(WMP_HIGH_PL_DEBUG, "%s: tx buf of index %d does not exist",
				__FUNCTION__, index);
		return;
	}

	wmp_tx_buf_info[index].flags = flag_val;
}

static void wmp_high_util_send_echo_rep(ethernet_header* eth_hdr)
{
	ethernet_header *eth_hdr_resp = (ethernet_header *) wmp_cmd_resp;
	struct wmp4warp_header_common *w4w_cmn_hdr_resp =
			(struct wmp4warp_header_common *) (wmp_cmd_resp + sizeof(ethernet_header));
	struct wmp4warp_header_common *w4w_cmn_hdr_req =
				(struct wmp4warp_header_common *) ((u8 *)(eth_hdr) + sizeof(ethernet_header));
	int status;

	memcpy(eth_hdr_resp->address_destination, w4w_cmn_hdr_req->mac_addr,
			sizeof(eth_hdr_resp->address_destination));
	memcpy(eth_hdr_resp->address_source, hw_info.hw_addr_wlan,
			sizeof(eth_hdr_resp->address_source));
	eth_hdr_resp->type = WMP4WARP_ETHER_TYPE;

	w4w_cmn_hdr_resp->cmd_id = WMP4WARP_ECHO_REP_CMD;
	memcpy(w4w_cmn_hdr_resp->mac_addr, hw_info.hw_addr_wlan,
			sizeof(w4w_cmn_hdr_resp->mac_addr));

	memset((void *)(RX_PKT_BUF_TO_ADDR(WMP_HIGH_UTIL_RX_BUF_RESERVED_WMP_CMD)),
				0, PKT_BUF_SIZE);

	memcpy((void *)(RX_PKT_BUF_TO_ADDR(WMP_HIGH_UTIL_RX_BUF_RESERVED_WMP_CMD)),
			wmp_cmd_resp, WMP4WARP_ECHO_REP_L);

	status = wlan_eth_dma_send((u8*)(void *)(RX_PKT_BUF_TO_ADDR(WMP_HIGH_UTIL_RX_BUF_RESERVED_WMP_CMD)),
			WMP4WARP_ECHO_REP_L);
	if(status != 0) {
		wmp_high_printf(WMP_HIGH_PL_ERROR, "Error in wlan_mac_send_eth! Err = %d\n", status);
	}
}

static void wmp_high_util_handle_fsm_load(ethernet_header* eth_hdr)
{
	ethernet_header *eth_hdr_resp = (ethernet_header *) wmp_cmd_resp;
	struct wmp4warp_header_common *w4w_cmn_hdr_resp =
			(struct wmp4warp_header_common *) (wmp_cmd_resp + sizeof(ethernet_header));
	struct wmp4warp_header_common *w4w_cmn_hdr_req =
				(struct wmp4warp_header_common *) ((u8 *)(eth_hdr) + sizeof(ethernet_header));
	struct wmp4warp_header_fsm_load *fsm_load_hdr =
			(struct wmp4warp_header_fsm_load *) ((u8 *)(eth_hdr) +
					sizeof(ethernet_header) + sizeof(struct wmp4warp_header_common));
	struct wmp4warp_header_fsm_load_conf *fsm_load_hdr_resp =
				(struct wmp4warp_header_fsm_load_conf *) ((u8 *)(wmp_cmd_resp) +
						sizeof(ethernet_header) + sizeof(struct wmp4warp_header_common));
	int status;

	if (!wmp_high_fsm_slots_handler_is_fsm_currently_running(fsm_load_hdr->fsm_id)) {
		struct wmp_common_sw_reg *container_cmn = wmp_common_sw_reg_get_container();
		struct wmp_fsm *wmp_fsm = wmp_common_sw_reg_get_fsm(container_cmn);
		u8 next_slot;
		int ret;

		if (wmp_high_fsm_slots_handler_slot_exist(fsm_load_hdr->fsm_id)) {
			next_slot = wmp_high_fsm_slots_handler_id_to_slot(fsm_load_hdr->fsm_id);
		} else {
			next_slot = wmp_high_fsm_slots_handler_first_not_used_slot();
		}

		ret = wmp_fsm_acquire(wmp_fsm, next_slot);

		if (ret == XST_FAILURE) {
			xil_printf("ERROR during FSM slot %d acquisition!\n", next_slot);
			return;
		}

		ret = wmp_fsm_write(wmp_fsm,
				((u8 *)(eth_hdr) + sizeof(ethernet_header) +
						sizeof(struct wmp4warp_header_common) +
						sizeof(struct wmp4warp_header_fsm_load)));

		if (ret) {
			xil_printf("WMP_HIGH_FSM_INIT ERROR: fsm write fails!\n");
			return;
		}

		wmp_high_fsm_slots_handler_set_last_written(next_slot);
		wmp_high_fsm_slots_handler_set_slot_used(next_slot, fsm_load_hdr->fsm_id);

		ret = wmp_fsm_release(wmp_fsm);

		wmp_high_printf(WMP_HIGH_PL_INFO, "Load FSM (ID %d) into slot %d\n", fsm_load_hdr->fsm_id, next_slot);

		if (ret == XST_FAILURE) {
			xil_printf("ERROR during FSM slot %d release!\n", next_slot);
			return;
		}

	}

	memcpy(eth_hdr_resp->address_destination, w4w_cmn_hdr_req->mac_addr,
			sizeof(eth_hdr_resp->address_destination));
	memcpy(eth_hdr_resp->address_source, hw_info.hw_addr_wlan,
			sizeof(eth_hdr_resp->address_source));
	eth_hdr_resp->type = WMP4WARP_ETHER_TYPE;

	w4w_cmn_hdr_resp->cmd_id = WMP4WARP_FSM_LOAD_CONF;
	memcpy(w4w_cmn_hdr_resp->mac_addr, hw_info.hw_addr_wlan,
			sizeof(w4w_cmn_hdr_resp->mac_addr));

	fsm_load_hdr_resp->fsm_id = fsm_load_hdr->fsm_id;

	memset((void *)(RX_PKT_BUF_TO_ADDR(WMP_HIGH_UTIL_RX_BUF_RESERVED_WMP_CMD)),
			0, PKT_BUF_SIZE);

	memcpy((void *)(RX_PKT_BUF_TO_ADDR(WMP_HIGH_UTIL_RX_BUF_RESERVED_WMP_CMD)),
			wmp_cmd_resp, WMP4WARP_FSM_LOAD_CONF_L);

	status = wlan_eth_dma_send((void *)(RX_PKT_BUF_TO_ADDR(WMP_HIGH_UTIL_RX_BUF_RESERVED_WMP_CMD)),
			WMP4WARP_FSM_LOAD_CONF_L);
	if(status != 0) {
		wmp_high_printf(WMP_HIGH_PL_ERROR, "Error in wlan_mac_send_eth! Err = %d\n", status);
	}


}

static void wmp_high_util_handle_fsm_del(ethernet_header* eth_hdr)
{
	ethernet_header *eth_hdr_resp = (ethernet_header *) wmp_cmd_resp;
	struct wmp4warp_header_common *w4w_cmn_hdr_resp =
			(struct wmp4warp_header_common *) (wmp_cmd_resp + sizeof(ethernet_header));
	struct wmp4warp_header_common *w4w_cmn_hdr_req =
				(struct wmp4warp_header_common *) ((u8 *)(eth_hdr) + sizeof(ethernet_header));
	struct wmp4warp_header_fsm_del *fsm_del_hdr =
			(struct wmp4warp_header_fsm_del *) ((u8 *)(eth_hdr) +
					sizeof(ethernet_header) + sizeof(struct wmp4warp_header_common));
	struct wmp4warp_header_fsm_del_conf *fsm_del_hdr_resp =
				(struct wmp4warp_header_fsm_del_conf *) ((u8 *)(wmp_cmd_resp) +
						sizeof(ethernet_header) + sizeof(struct wmp4warp_header_common));
	int status;

	if (wmp_high_fsm_slots_handler_slot_exist(fsm_del_hdr->fsm_id)) {
		u8 slot;

		if ((slot = wmp_high_fsm_slots_handler_delete_slot(fsm_del_hdr->fsm_id)) == 0xFF) {
			return;
		}

		wmp_high_printf(WMP_HIGH_PL_INFO, "Deleted FSM (ID %d) from slot %d\n", fsm_del_hdr->fsm_id, slot);

	}

	memcpy(eth_hdr_resp->address_destination, w4w_cmn_hdr_req->mac_addr,
			sizeof(eth_hdr_resp->address_destination));
	memcpy(eth_hdr_resp->address_source, hw_info.hw_addr_wlan,
			sizeof(eth_hdr_resp->address_source));
	eth_hdr_resp->type = WMP4WARP_ETHER_TYPE;

	w4w_cmn_hdr_resp->cmd_id = WMP4WARP_FSM_DEL_CONF;
	memcpy(w4w_cmn_hdr_resp->mac_addr, hw_info.hw_addr_wlan,
			sizeof(w4w_cmn_hdr_resp->mac_addr));

	fsm_del_hdr_resp->fsm_id = fsm_del_hdr->fsm_id;

	memset((void *)(RX_PKT_BUF_TO_ADDR(WMP_HIGH_UTIL_RX_BUF_RESERVED_WMP_CMD)),
			0, PKT_BUF_SIZE);

	memcpy((void *)(RX_PKT_BUF_TO_ADDR(WMP_HIGH_UTIL_RX_BUF_RESERVED_WMP_CMD)),
			wmp_cmd_resp, WMP4WARP_FSM_DEL_CONF_L);

	status = wlan_eth_dma_send((void *)(RX_PKT_BUF_TO_ADDR(WMP_HIGH_UTIL_RX_BUF_RESERVED_WMP_CMD)),
			WMP4WARP_FSM_DEL_CONF_L);
	if(status != 0) {
		wmp_high_printf(WMP_HIGH_PL_ERROR, "Error in wlan_mac_send_eth! Err = %d\n", status);
	}
}

static void wmp_high_util_handle_ts_req(ethernet_header* eth_hdr)
{
	wlan_ipc_msg ipc_msg_to_low;
	ethernet_header *eth_hdr_resp = (ethernet_header *) wmp_cmd_resp;
	struct wmp4warp_header_common *w4w_cmn_hdr_resp =
			(struct wmp4warp_header_common *) (wmp_cmd_resp + sizeof(ethernet_header));
	struct wmp4warp_header_common *w4w_cmn_hdr_req =
				(struct wmp4warp_header_common *) ((u8 *)(eth_hdr) + sizeof(ethernet_header));


	memcpy(eth_hdr_resp->address_destination, w4w_cmn_hdr_req->mac_addr,
			sizeof(eth_hdr_resp->address_destination));
	memcpy(eth_hdr_resp->address_source, hw_info.hw_addr_wlan,
			sizeof(eth_hdr_resp->address_source));
	eth_hdr_resp->type = WMP4WARP_ETHER_TYPE;

	w4w_cmn_hdr_resp->cmd_id = WMP4WARP_TS_REP;
	memcpy(w4w_cmn_hdr_resp->mac_addr, hw_info.hw_addr_wlan,
			sizeof(w4w_cmn_hdr_resp->mac_addr));


	memset((void *)(RX_PKT_BUF_TO_ADDR(WMP_HIGH_UTIL_RX_BUF_RESERVED_WMP_CMD)),
			0, PKT_BUF_SIZE);

	memcpy((void *)(RX_PKT_BUF_TO_ADDR(WMP_HIGH_UTIL_RX_BUF_RESERVED_WMP_CMD)),
			wmp_cmd_resp, WMP4WARP_TS_REP_L);

	ipc_msg_to_low.msg_id = IPC_MBOX_MSG_ID(IPC_MBOX_TIMESTAMP);
	ipc_mailbox_write_msg(&ipc_msg_to_low);

	wmp_high_printf(WMP_HIGH_PL_INFO, "Timestamp required to CPU_LOW\n");
}

static void wmp_high_util_handle_read_var(ethernet_header* eth_hdr)
{
	wlan_ipc_msg ipc_msg_to_low;
	ethernet_header *eth_hdr_resp = (ethernet_header *) wmp_cmd_resp;
	struct wmp4warp_header_common *w4w_cmn_hdr_resp =
			(struct wmp4warp_header_common *) (wmp_cmd_resp + sizeof(ethernet_header));
	struct wmp4warp_header_common *w4w_cmn_hdr_req =
				(struct wmp4warp_header_common *) ((u8 *)(eth_hdr) + sizeof(ethernet_header));
	struct wmp4warp_header_read_var *read_hdr =
				(struct wmp4warp_header_read_var *) ((u8 *)(eth_hdr) +
						sizeof(ethernet_header) + sizeof(struct wmp4warp_header_common));


	memcpy(eth_hdr_resp->address_destination, w4w_cmn_hdr_req->mac_addr,
			sizeof(eth_hdr_resp->address_destination));
	memcpy(eth_hdr_resp->address_source, hw_info.hw_addr_wlan,
			sizeof(eth_hdr_resp->address_source));
	eth_hdr_resp->type = WMP4WARP_ETHER_TYPE;

	w4w_cmn_hdr_resp->cmd_id = WMP4WARP_READ_VAR_REP;
	memcpy(w4w_cmn_hdr_resp->mac_addr, hw_info.hw_addr_wlan,
			sizeof(w4w_cmn_hdr_resp->mac_addr));


	memset((void *)(RX_PKT_BUF_TO_ADDR(WMP_HIGH_UTIL_RX_BUF_RESERVED_WMP_CMD)),
			0, PKT_BUF_SIZE);

	memcpy((void *)(RX_PKT_BUF_TO_ADDR(WMP_HIGH_UTIL_RX_BUF_RESERVED_WMP_CMD)),
			wmp_cmd_resp, WMP4WARP_READ_VAR_REP_L);

	ipc_msg_to_low.msg_id = IPC_MBOX_MSG_ID(IPC_MBOX_READVAR);
	ipc_msg_to_low.arg0 = read_hdr->var_id;
	ipc_mailbox_write_msg(&ipc_msg_to_low);

	wmp_high_printf(WMP_HIGH_PL_INFO, "Value of variable %d required to CPU_LOW\n", read_hdr->var_id);
}

static void wmp_high_util_handle_run(ethernet_header* eth_hdr)
{
	wlan_ipc_msg ipc_msg_to_low;
	u64 ipc_msg_to_low_payload[1];
	ethernet_header *eth_hdr_resp = (ethernet_header *) wmp_cmd_resp;
	struct wmp4warp_header_common *w4w_cmn_hdr_resp =
			(struct wmp4warp_header_common *) (wmp_cmd_resp + sizeof(ethernet_header));
	struct wmp4warp_header_common *w4w_cmn_hdr_req =
				(struct wmp4warp_header_common *) ((u8 *)(eth_hdr) + sizeof(ethernet_header));
	struct wmp4warp_header_run *run_hdr =
			(struct wmp4warp_header_run *) ((u8 *)(eth_hdr) +
					sizeof(ethernet_header) + sizeof(struct wmp4warp_header_common));
	struct wmp4warp_header_run_conf *run_hdr_resp =
				(struct wmp4warp_header_run_conf *) ((u8 *)(wmp_cmd_resp) +
						sizeof(ethernet_header) + sizeof(struct wmp4warp_header_common));
	int status;

	if (!wmp_high_fsm_slots_handler_slot_exist(run_hdr->fsm_id)) {
		return;
	}

	if (wmp_high_fsm_slots_handler_is_fsm_currently_running(run_hdr->fsm_id)) {
		return;
	}

	ipc_msg_to_low.msg_id = IPC_MBOX_MSG_ID(IPC_MBOX_RUN_FSM);
	ipc_msg_to_low.arg0 = wmp_high_fsm_slots_handler_id_to_slot(run_hdr->fsm_id);
	ipc_msg_to_low.num_payload_words = (sizeof(ipc_msg_to_low_payload)/sizeof(u32));
	ipc_msg_to_low_payload[0] = run_hdr->ts;
	ipc_msg_to_low.payload_ptr       = (u32 *)&(ipc_msg_to_low_payload[0]);
	ipc_mailbox_write_msg(&ipc_msg_to_low);

	wmp_high_printf(WMP_HIGH_PL_INFO, "FSM (ID %d) scheduled in 0x%08X%08X us\n", run_hdr->fsm_id,
			(u32)((run_hdr->ts & 0xFFFFFFFF00000000) >> 32), (u32)(run_hdr->ts & 0xFFFFFFFF));

	wmp_high_fsm_slots_handler_set_slot_used(
				wmp_high_fsm_slots_handler_id_to_slot(run_hdr->fsm_id), run_hdr->fsm_id);

	memcpy(eth_hdr_resp->address_destination, w4w_cmn_hdr_req->mac_addr,
			sizeof(eth_hdr_resp->address_destination));
	memcpy(eth_hdr_resp->address_source, hw_info.hw_addr_wlan,
			sizeof(eth_hdr_resp->address_source));
	eth_hdr_resp->type = WMP4WARP_ETHER_TYPE;

	w4w_cmn_hdr_resp->cmd_id = WMP4WARP_RUN_CONF;
	memcpy(w4w_cmn_hdr_resp->mac_addr, hw_info.hw_addr_wlan,
			sizeof(w4w_cmn_hdr_resp->mac_addr));

	run_hdr_resp->fsm_id = run_hdr->fsm_id;
	run_hdr_resp->ts = run_hdr->ts;

	memset((void *)(RX_PKT_BUF_TO_ADDR(WMP_HIGH_UTIL_RX_BUF_RESERVED_WMP_CMD)),
			0, PKT_BUF_SIZE);

	memcpy((void *)(RX_PKT_BUF_TO_ADDR(WMP_HIGH_UTIL_RX_BUF_RESERVED_WMP_CMD)),
			wmp_cmd_resp, WMP4WARP_RUN_CONF_L);

	status = wlan_eth_dma_send((void *)(RX_PKT_BUF_TO_ADDR(WMP_HIGH_UTIL_RX_BUF_RESERVED_WMP_CMD)),
			WMP4WARP_RUN_CONF_L);
	if(status != 0) {
		wmp_high_printf(WMP_HIGH_PL_ERROR, "Error in wlan_mac_send_eth! Err = %d\n", status);
	}
}

static void wmp_high_util_handle_run_abs(ethernet_header* eth_hdr)
{
	wlan_ipc_msg ipc_msg_to_low;
	u64 ipc_msg_to_low_payload[1];
	ethernet_header *eth_hdr_resp = (ethernet_header *) wmp_cmd_resp;
	struct wmp4warp_header_common *w4w_cmn_hdr_resp =
			(struct wmp4warp_header_common *) (wmp_cmd_resp + sizeof(ethernet_header));
	struct wmp4warp_header_common *w4w_cmn_hdr_req =
				(struct wmp4warp_header_common *) ((u8 *)(eth_hdr) + sizeof(ethernet_header));
	struct wmp4warp_header_run_abs *run_hdr =
			(struct wmp4warp_header_run_abs *) ((u8 *)(eth_hdr) +
					sizeof(ethernet_header) + sizeof(struct wmp4warp_header_common));
	struct wmp4warp_header_run_abs_conf *run_hdr_resp =
				(struct wmp4warp_header_run_abs_conf *) ((u8 *)(wmp_cmd_resp) +
						sizeof(ethernet_header) + sizeof(struct wmp4warp_header_common));
	int status;

	if (!wmp_high_fsm_slots_handler_slot_exist(run_hdr->fsm_id)) {
		return;
	}

	if (wmp_high_fsm_slots_handler_is_fsm_currently_running(run_hdr->fsm_id)) {
		return;
	}

	ipc_msg_to_low.msg_id = IPC_MBOX_MSG_ID(IPC_MBOX_RUN_FSM);
	ipc_msg_to_low.arg0 = 0x80 | wmp_high_fsm_slots_handler_id_to_slot(run_hdr->fsm_id);
	ipc_msg_to_low.num_payload_words = (sizeof(ipc_msg_to_low_payload)/sizeof(u32));
	ipc_msg_to_low_payload[0] = run_hdr->ts;
	ipc_msg_to_low.payload_ptr       = (u32 *)&(ipc_msg_to_low_payload[0]);
	ipc_mailbox_write_msg(&ipc_msg_to_low);

	wmp_high_printf(WMP_HIGH_PL_INFO, "FSM (ID %d) scheduled at 0x%08X%08X us\n", run_hdr->fsm_id,
			(u32)((run_hdr->ts & 0xFFFFFFFF00000000) >> 32), (u32)(run_hdr->ts & 0xFFFFFFFF));

	wmp_high_fsm_slots_handler_set_slot_used(
			wmp_high_fsm_slots_handler_id_to_slot(run_hdr->fsm_id), run_hdr->fsm_id);

	memcpy(eth_hdr_resp->address_destination, w4w_cmn_hdr_req->mac_addr,
			sizeof(eth_hdr_resp->address_destination));
	memcpy(eth_hdr_resp->address_source, hw_info.hw_addr_wlan,
			sizeof(eth_hdr_resp->address_source));
	eth_hdr_resp->type = WMP4WARP_ETHER_TYPE;

	w4w_cmn_hdr_resp->cmd_id = WMP4WARP_RUN_ABS_CONF;
	memcpy(w4w_cmn_hdr_resp->mac_addr, hw_info.hw_addr_wlan,
			sizeof(w4w_cmn_hdr_resp->mac_addr));

	run_hdr_resp->fsm_id = run_hdr->fsm_id;
	run_hdr_resp->ts = run_hdr->ts;

	memset((void *)(RX_PKT_BUF_TO_ADDR(WMP_HIGH_UTIL_RX_BUF_RESERVED_WMP_CMD)),
			0, PKT_BUF_SIZE);

	memcpy((void *)(RX_PKT_BUF_TO_ADDR(WMP_HIGH_UTIL_RX_BUF_RESERVED_WMP_CMD)),
			wmp_cmd_resp, WMP4WARP_RUN_ABS_CONF_L);

	status = wlan_eth_dma_send((void *)(RX_PKT_BUF_TO_ADDR(WMP_HIGH_UTIL_RX_BUF_RESERVED_WMP_CMD)),
			WMP4WARP_RUN_ABS_CONF_L);
	if(status != 0) {
		wmp_high_printf(WMP_HIGH_PL_ERROR, "Error in wlan_mac_send_eth! Err = %d\n", status);
	}
}

void wmp_high_util_handle_wmp_cmd_from_ethernet(ethernet_header* eth_hdr)
{
	struct wmp4warp_header_common *w4w_hdr_cmn =
			(struct wmp4warp_header_common *)((u8 *)(eth_hdr) + sizeof(ethernet_header));

	wmp_high_printf(WMP_HIGH_PL_ERROR, "Received WMP command from ethernet 0x%02X\n", w4w_hdr_cmn->cmd_id);

	switch (w4w_hdr_cmn->cmd_id) {
	case WMP4WARP_ECHO_REQ_CMD:
		wmp_high_util_send_echo_rep(eth_hdr);
	break;
	case WMP4WARP_FSM_LOAD:
		wmp_high_util_handle_fsm_load(eth_hdr);
	break;
	case WMP4WARP_FSM_DEL:
		wmp_high_util_handle_fsm_del(eth_hdr);
	break;
	case WMP4WARP_TS_REQ:
		wmp_high_util_handle_ts_req(eth_hdr);
	break;
	case WMP4WARP_READ_VAR:
		wmp_high_util_handle_read_var(eth_hdr);
	break;
	case WMP4WARP_RUN:
		wmp_high_util_handle_run(eth_hdr);
	break;
	case WMP4WARP_RUN_ABS:
		wmp_high_util_handle_run_abs(eth_hdr);
	break;
	default:
		wmp_high_printf(WMP_HIGH_PL_ERROR, "%s: Received invalid WMP command from ethernet (0x%02X)",
						__FUNCTION__, w4w_hdr_cmn->cmd_id);
	break;
	}
}
