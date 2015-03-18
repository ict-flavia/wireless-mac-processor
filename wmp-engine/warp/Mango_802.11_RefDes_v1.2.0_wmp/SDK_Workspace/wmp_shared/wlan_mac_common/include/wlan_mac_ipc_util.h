////////////////////////////////////////////////////////////////////////////////
// File   : wlan_mac_ipc_util.h
// Authors: Patrick Murphy (murphpo [at] mangocomm.com)
//			Chris Hunter (chunter [at] mangocomm.com)
// License: Copyright 2013, Mango Communications. All rights reserved.
//          Distributed under the Mango Communications Reference Design License
//				See LICENSE.txt included in the design archive or
//				at http://mangocomm.com/802.11/license
////////////////////////////////////////////////////////////////////////////////

#ifndef WLAN_MAC_IPC_UTIL_H_
#define WLAN_MAC_IPC_UTIL_H_

#include "xil_types.h"

#define PKT_BUF_MUTEX_DEVICE_ID		XPAR_MUTEX_1_DEVICE_ID
#define MAILBOX_DEVICE_ID			XPAR_MBOX_0_DEVICE_ID

#define EXC_MUTEX_TX_FAILURE 1
#define EXC_MUTEX_RX_FAILURE 2

#define PKT_BUF_MUTEX_SUCCESS 				0
#define PKT_BUF_MUTEX_FAIL_INVALID_BUF		-1
#define PKT_BUF_MUTEX_FAIL_ALREADY_LOCKED	-2
#define PKT_BUF_MUTEX_FAIL_NOT_LOCK_OWNER	-3

#define PKT_BUF_MUTEX_TX_BASE	0
#define PKT_BUF_MUTEX_RX_BASE	16

#define IPC_MBOX_MSG_ID_DELIM		0xF000
#define IPC_MBOX_MAX_MSG_WORDS		255

//IPC Messages
#define IPC_MBOX_RX_MPDU_READY		0
#define IPC_MBOX_TX_MPDU_READY		1
#define IPC_MBOX_TX_MPDU_ACCEPT		2
#define IPC_MBOX_TX_MPDU_DONE		3
#define IPC_MBOX_HW_INFO			4
#define IPC_MBOX_CPU_STATUS			5
#define IPC_MBOX_CONFIG_RF_IFC		6
#define IPC_MBOX_CONFIG_MAC			7
#define IPC_MBOX_CONFIG_PHY_RX		8
#define IPC_MBOX_CONFIG_PHY_TX		9
#define IPC_MBOX_RX_BAD_FCS			10
#define IPC_MBOX_RUN_FSM			11
#define IPC_MBOX_MODE				12
#define IPC_MBOX_UPDATE				13
#define IPC_MBOX_SWITCH_FSM			14
#define IPC_MBOX_TIMESTAMP			15
#define IPC_MBOX_ASSOC_BEACON_MAC	16
#define IPC_MBOX_READVAR			17

/* WMP_START */
#define WMP_IPC_MBOX_UPDATE_BEACON_TEMPLATE			0x00
#define WMP_IPC_MBOX_UPDATE_BEACON_TEMPLATE_INVALID	0x01
/* WMP_END */

#define IPC_MBOX_MSG_ID(id) (IPC_MBOX_MSG_ID_DELIM | ((id) & 0xFFF))
#define IPC_MBOX_MSG_ID_TO_MSG(id) (id) & 0xFFF

//These config structs need to be an integer # of u32
typedef struct{
	u8 channel;
	u8 reserved[3];
} ipc_config_rf_ifc;

typedef struct{
	u32 slot_config;
} ipc_config_mac;

#define SLOT_CONFIG_RAND 0xFFFFFFFF

typedef struct{
	u8 reserved[4];
} ipc_config_phy_tx;

typedef struct{
	u8 enable_dsss;
	u8 reserved[3];
} ipc_config_phy_rx;

#define init_ipc_config(x,y,z) {										\
									x = (z*)y;							\
									memset((void*)x, 0xFF, sizeof(z));	\
								}

#define IPC_MBOX_SUCCESS			0
#define IPC_MBOX_INVALID_MSG		-1
#define IPC_MBOX_NO_MSG_AVAIL		-2

typedef struct {
	u16 msg_id;
	u8	num_payload_words;
	u8	arg0;
	u32* payload_ptr;
} wlan_ipc_msg;



// Hardware information struct to share data between the 
//   low and high CPUs

#define WLAN_MAC_FPGA_DNA_LEN         2
#define WLAN_MAC_ETH_ADDR_LEN         6

typedef struct {

    u32   type;

	u32   serial_number;
	u32   fpga_dna[WLAN_MAC_FPGA_DNA_LEN];

    u32   wn_exp_eth_device;
    u8    hw_addr_wn[WLAN_MAC_ETH_ADDR_LEN];
    u8    hw_addr_wlan[WLAN_MAC_ETH_ADDR_LEN];
    
} wlan_mac_hw_info;







int wlan_lib_init ();
inline int ipc_mailbox_read_isempty();
inline int wlan_lib_mac_rate_to_mbps (u8 rate);
int lock_pkt_buf_tx(u8 pkt_buf_ind);
int lock_pkt_buf_rx(u8 pkt_buf_ind);
int unlock_pkt_buf_tx(u8 pkt_buf_ind);
int unlock_pkt_buf_rx(u8 pkt_buf_ind);
int status_pkt_buf_tx(u8 pkt_buf_ind, u32* Locked, u32 *Owner);
int status_pkt_buf_rx(u8 pkt_buf_ind, u32* Locked, u32 *Owner);

int ipc_mailbox_read_msg(wlan_ipc_msg* msg);
int ipc_mailbox_write_msg(wlan_ipc_msg* msg);
void nullCallback(void* param);


#ifdef XPAR_INTC_0_DEVICE_ID
int wlan_lib_setup_mailbox_interrupt(XIntc* intc);
void wlan_lib_setup_mailbox_rx_callback( void(*callback)());
void MailboxIntrHandler(void *CallbackRef);
#endif


#endif /* WLAN_MAC_IPC_UTIL_H_ */
