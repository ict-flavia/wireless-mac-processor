////////////////////////////////////////////////////////////////////////////////
// File   : wlan_mac_util.c
// Authors: Patrick Murphy (murphpo [at] mangocomm.com)
//			Chris Hunter (chunter [at] mangocomm.com)
//          Erik Welsh (welsh [at] mangocomm.com)
// License: Copyright 2013, Mango Communications. All rights reserved.
//          Distributed under the Mango Communications Reference Design License
//				See LICENSE.txt included in the design archive or
//				at http://mangocomm.com/802.11/license
////////////////////////////////////////////////////////////////////////////////

/***************************** Include Files *********************************/

#include "stdlib.h"
#include "string.h"

#include "xil_types.h"
#include "xintc.h"
#include "xmutex.h"
#include "xparameters.h"

#include "wlan_mac_ipc_util.h"
#include "wlan_mac_util.h"
#include "wlan_mac_ipc.h"

#include "wlan_exp_common.h"

/* WMP_START */
#include "wmp_common_sw_reg.h"
#include "wmp_high_util.h"
#include "wlan_mac_eth_util.h"
/* WMP_END */


/*************************** Constant Definitions ****************************/

// IPC defines
#define IPC_BUFFER_SIZE      20


/*********************** Global Variable Definitions *************************/

// Callback function pointers
extern function_ptr_t     mpdu_tx_done_callback;
extern function_ptr_t     mpdu_rx_callback;
extern function_ptr_t     check_queue_callback;
extern function_ptr_t     fcs_bad_rx_callback;
extern function_ptr_t     mpdu_tx_accept_callback;

// 802.11 Transmit packet buffer
extern u8                 tx_pkt_buf;
/* WMP START */
extern int				tx_pkt_buf_prev_acc;
extern u8 				pause_queue;
/* WMP END */

// Node information
extern wlan_mac_hw_info   hw_info;

// WARPNet information
#ifdef USE_WARPNET_WLAN_EXP
extern u8                 warpnet_initialized;
#endif



/*************************** Variable Definitions ****************************/

// Status information
static u32         cpu_low_status;
static u32         cpu_high_status;


// IPC variables
wlan_ipc_msg       ipc_msg_from_low;
u32                ipc_msg_from_low_payload[IPC_BUFFER_SIZE];



/*************************** Functions Prototypes ****************************/

#ifdef _DEBUG_
void print_wlan_mac_hw_info( wlan_mac_hw_info * info );      // Function defined in wlan_mac_util.c
#endif


/******************************** Functions **********************************/



/*****************************************************************************/
/**
* WLAN MAC IPC initialization
*
* Initialize variables necessary for IPC communication between CPU high and low
*
* @param    None.
*
* @return	None.
*
* @note		None.
*
******************************************************************************/
void wlan_mac_ipc_init( void ) {

	//create IPC message to receive into
	ipc_msg_from_low.payload_ptr = &(ipc_msg_from_low_payload[0]);

}




/*****************************************************************************/
/**
* WLAN MAC IPC receive
*
* IPC receive function that will poll the mailbox for as many messages as are
*   available and then call the CPU high IPC processing function on each message
*
* @param    None.
*
* @return	None.
*
* @note		None.
*
******************************************************************************/
void ipc_rx(){

#ifdef _DEBUG_
	u32 numMsg = 0;
	xil_printf("Mailbox Rx:  ");
#endif

	while( ipc_mailbox_read_msg( &ipc_msg_from_low ) == IPC_MBOX_SUCCESS ) {
		process_ipc_msg_from_low(&ipc_msg_from_low);

#ifdef _DEBUG_
		numMsg++;
#endif
	}

#ifdef _DEBUG_
	xil_printf("Processed %d msg in one ISR\n", numMsg);
#endif
}




/*****************************************************************************/
/**
* WLAN MAC IPC processing function for CPU High
*
* Process all IPC messages from CPU low
*
* @param    msg   - IPC message from CPU low
*
* @return	None.
*
* @note		None.
*
******************************************************************************/
void process_ipc_msg_from_low( wlan_ipc_msg* msg ) {

	rx_frame_info* rx_mpdu;
	tx_frame_info* tx_mpdu;

	u8  rx_pkt_buf;
	u32 temp_1, temp_2, k;
    u32 temp, locked, owner;
    struct wmp_common_sw_reg *container_cmn = wmp_common_sw_reg_get_container();


	switch(IPC_MBOX_MSG_ID_TO_MSG(msg->msg_id)) {

		case IPC_MBOX_SWITCH_FSM:
				if (msg->arg0 & 0x80) {
					xil_printf("CPU_LOW is now running XFSM at slot %d\n",
								msg->arg0 & 0x0F);
				} else {
					xil_printf("CPU_LOW failed to switch to XFSM at slot %d\n",
													msg->arg0 & 0x0F);
				}
			break;

		case IPC_MBOX_CONFIG_RF_IFC:
				xil_printf("Switch to channel %d confirmed\n", ((ipc_config_rf_ifc*)ipc_msg_from_low_payload)->channel);
			break;

		/* WMP_START */
		case IPC_MBOX_TIMESTAMP:
		{
			int status;
			struct wmp4warp_header_ts_rep *ts_hdr =
					(struct wmp4warp_header_ts_rep *)
						(((u8 *)(RX_PKT_BUF_TO_ADDR(WMP_HIGH_UTIL_RX_BUF_RESERVED_WMP_CMD))) +
								sizeof(ethernet_header) + sizeof(struct wmp4warp_header_common));

			ts_hdr->ts = *((u64 *)(msg->payload_ptr));

			wmp_high_printf(WMP_HIGH_PL_INFO, "CPU_LOW Timestamp: 0x%08X%08X\n",
					(u32)(((*((u64 *)(msg->payload_ptr))) & 0xFFFFFFFF00000000) >> 32),
					(u32)((*((u64 *)(msg->payload_ptr))) & 0xFFFFFFFF));

			status = wlan_eth_dma_send((void *)(RX_PKT_BUF_TO_ADDR(WMP_HIGH_UTIL_RX_BUF_RESERVED_WMP_CMD)),
						WMP4WARP_TS_REP_L);
			if(status != 0) {
				wmp_high_printf(WMP_HIGH_PL_ERROR, "Error in wlan_mac_send_eth! Err = %d\n", status);
			}
			break;
		}

		case IPC_MBOX_READVAR:
				{
					int status;
					struct wmp4warp_header_read_var_rep *read_hdr =
							(struct wmp4warp_header_read_var_rep *)
								(((u8 *)(RX_PKT_BUF_TO_ADDR(WMP_HIGH_UTIL_RX_BUF_RESERVED_WMP_CMD))) +
										sizeof(ethernet_header) + sizeof(struct wmp4warp_header_common));

					read_hdr->var_id = msg->arg0;
					read_hdr->var_value = *((u16 *)(msg->payload_ptr));

					wmp_high_printf(WMP_HIGH_PL_INFO, "Variable %d = %d\n", msg->arg0, *((u16 *)(msg->payload_ptr)));

					status = wlan_eth_dma_send((void *)(RX_PKT_BUF_TO_ADDR(WMP_HIGH_UTIL_RX_BUF_RESERVED_WMP_CMD)),
							WMP4WARP_READ_VAR_REP_L);
					if(status != 0) {
						wmp_high_printf(WMP_HIGH_PL_ERROR, "Error in wlan_mac_send_eth! Err = %d\n", status);
					}
					break;
				}
		/* WMP_END */

		case IPC_MBOX_RX_MPDU_READY:
			//This message indicates CPU Low has received an MPDU addressed to this node or to the broadcast address

			rx_pkt_buf = msg->arg0;

			//First attempt to lock the indicated Rx pkt buf (CPU Low must unlock it before sending this msg)
			if(lock_pkt_buf_rx(rx_pkt_buf) != PKT_BUF_MUTEX_SUCCESS){
				warp_printf(PL_ERROR,"Error: unable to lock pkt_buf %d\n",rx_pkt_buf);
			} else {
				rx_mpdu = (rx_frame_info*)RX_PKT_BUF_TO_ADDR(rx_pkt_buf);

				//xil_printf("MB-HIGH: processing buffer %d, mpdu state = %d, length = %d, rate = %d\n",rx_pkt_buf,rx_mpdu->state, rx_mpdu->length,rx_mpdu->rate);
				mpdu_rx_callback((void*)(RX_PKT_BUF_TO_ADDR(rx_pkt_buf)), rx_mpdu->rate, rx_mpdu->length);

				//Free up the rx_pkt_buf
				rx_mpdu->state = RX_MPDU_STATE_EMPTY;

				if(unlock_pkt_buf_rx(rx_pkt_buf) != PKT_BUF_MUTEX_SUCCESS){
					warp_printf(PL_ERROR, "Error: unable to unlock rx pkt_buf %d\n",rx_pkt_buf);
				}
			}
		break;

		case IPC_MBOX_RX_BAD_FCS:
			//This message indicates CPU Low has received a frame whose FCS failed

			rx_pkt_buf = msg->arg0;

			//First attempt to lock the indicated Rx pkt buf (CPU Low must unlock it before sending this msg)
			if(lock_pkt_buf_rx(rx_pkt_buf) != PKT_BUF_MUTEX_SUCCESS){
				warp_printf(PL_ERROR,"Error: unable to lock pkt_buf %d\n",rx_pkt_buf);
			} else {
				rx_mpdu = (rx_frame_info*)RX_PKT_BUF_TO_ADDR(rx_pkt_buf);

				//xil_printf("MB-HIGH: processing buffer %d, mpdu state = %d, length = %d, rate = %d\n",rx_pkt_buf,rx_mpdu->state, rx_mpdu->length,rx_mpdu->rate);
				fcs_bad_rx_callback((void*)(RX_PKT_BUF_TO_ADDR(rx_pkt_buf)), rx_mpdu->rate, rx_mpdu->length);

				//Free up the rx_pkt_buf
				rx_mpdu->state = RX_MPDU_STATE_EMPTY;

				if(unlock_pkt_buf_rx(rx_pkt_buf) != PKT_BUF_MUTEX_SUCCESS){
					warp_printf(PL_ERROR, "Error: unable to unlock rx pkt_buf %d\n",rx_pkt_buf);
				}
			}
		break;

		case IPC_MBOX_TX_MPDU_ACCEPT:
			//This message indicates CPU Low has begun the Tx process for the previously submitted MPDU
			// CPU High is now free to begin processing its next Tx frame and submit it to CPU Low
			// CPU Low will not accept a new frame until the previous one is complete

			/* WMP_START */
			//if(tx_pkt_buf != (msg->arg0)) {
			//	warp_printf(PL_ERROR, "Received CPU_LOW acceptance of buffer %d, but was expecting buffer %d\n", tx_pkt_buf, msg->arg0);
			//}
			set_cpu_low_ready();
			tx_pkt_buf_prev_acc = 1;

			/* Look for the next free TX buffer */
			for (k = 1; k < TX_BUFFER_NUM; k++) {
				if (lock_pkt_buf_tx((tx_pkt_buf + k) % TX_BUFFER_NUM) ==
						PKT_BUF_MUTEX_SUCCESS) {
					/* We found a free TX buffer. Check tx queues for new frames */
					tx_pkt_buf = (tx_pkt_buf + k) % TX_BUFFER_NUM;
					tx_mpdu = (tx_frame_info*)TX_PKT_BUF_TO_ADDR(tx_pkt_buf);
					tx_mpdu->state = TX_MPDU_STATE_TX_PENDING;
					check_queue_callback();
					break;
				}
			}
			if (k == TX_BUFFER_NUM) {
				tx_pkt_buf = (tx_pkt_buf + 1) % TX_BUFFER_NUM;
				pause_queue = 1;
			}

			mpdu_tx_accept_callback(TX_PKT_BUF_TO_ADDR(msg->arg0));
			/* WMP_END */

		break;


		case IPC_MBOX_TX_MPDU_DONE:
			//This message indicates CPU Low has finished the Tx process for the previously submitted-accepted frame
			// CPU High should do any necessary post-processing, then recycle the packet buffer

			tx_mpdu = (tx_frame_info*)TX_PKT_BUF_TO_ADDR(msg->arg0);
			mpdu_tx_done_callback(tx_mpdu);
			/* WMP START */

			XMutex_GetStatus(wmp_common_sw_reg_get_pkt_buf_mutex(container_cmn), tx_pkt_buf,
					&locked, &owner);

			if (!locked && tx_pkt_buf_prev_acc) {
				/* It wasn't possible to lock the mutex
				 * on reception of IPC_MBOX_TX_MPDU_ACCEPT
				 * message.
				 */
				if(lock_pkt_buf_tx(tx_pkt_buf) != PKT_BUF_MUTEX_SUCCESS) {
				        /* This shouldn't happen */
				        warp_printf(PL_ERROR,"Error: unable to lock tx pkt_buf (IPC_MBOX_TX_MPDU_DONE) %d\n",
				                        tx_pkt_buf);
				} else {
					tx_mpdu = (tx_frame_info*)TX_PKT_BUF_TO_ADDR(tx_pkt_buf);
					tx_mpdu->state = TX_MPDU_STATE_TX_PENDING;
					pause_queue = 0;
					check_queue_callback();
				}
			}
			/* WMP END */

		break;


		case IPC_MBOX_HW_INFO:
			// This message indicates CPU low is passing up node hardware information that only it has access to

			temp_1 = hw_info.type;
			temp_2 = hw_info.wn_exp_eth_device;

			// CPU Low updated the node's HW information
            //   NOTE:  this information is typically stored in the WARP v3 EEPROM, accessible only to CPU Low
			memcpy((void*) &(hw_info), (void*) &(ipc_msg_from_low_payload[0]), sizeof( wlan_mac_hw_info ) );

			hw_info.type              = temp_1;
			hw_info.wn_exp_eth_device = temp_2;

#ifdef _DEBUG_
			print_wlan_mac_hw_info( & hw_info );
#endif

#ifdef USE_WARPNET_WLAN_EXP

        	// Initialize WLAN Exp if it is being used
            if ( warpnet_initialized == 0 ) {

                wlan_exp_node_init( hw_info.type, hw_info.serial_number, &hw_info.fpga_dna, hw_info.wn_exp_eth_device, &hw_info.hw_addr_wn );

                warpnet_initialized = 1;
            }
#endif
		break;


		case IPC_MBOX_CPU_STATUS:
			// This message indicates CPU low's status

			cpu_low_status = ipc_msg_from_low_payload[0];

			if(cpu_low_status & CPU_STATUS_EXCEPTION){
				warp_printf(PL_ERROR, "An unrecoverable exception has occurred in CPU_LOW, halting...\n");
				warp_printf(PL_ERROR, "Reason code: %d\n", ipc_msg_from_low_payload[1]);
				while(1){}
			}
		break;


		default:
			warp_printf(PL_ERROR, "Unknown IPC message type %d\n",IPC_MBOX_MSG_ID_TO_MSG(msg->msg_id));
		break;
	}

	return;
}





/*****************************************************************************/
/**
* Set MAC Channel
*
* Send an IPC message to CPU Low to set the MAC Channel
*
* @param    mac_channel  - Value of MAC channel
*
* @return	None.
*
* @note		None.
*
******************************************************************************/
void set_mac_channel( unsigned int mac_channel ) {

	wlan_ipc_msg       ipc_msg_to_low;
	u32                ipc_msg_to_low_payload[1];
	ipc_config_rf_ifc* config_rf_ifc;

	// Send message to CPU Low
	ipc_msg_to_low.msg_id            = IPC_MBOX_MSG_ID(IPC_MBOX_CONFIG_RF_IFC);
	ipc_msg_to_low.num_payload_words = sizeof(ipc_config_rf_ifc)/sizeof(u32);
	ipc_msg_to_low.payload_ptr       = &(ipc_msg_to_low_payload[0]);

	// Initialize the payload
	init_ipc_config(config_rf_ifc, ipc_msg_to_low_payload, ipc_config_rf_ifc);

	config_rf_ifc->channel = mac_channel;

	ipc_mailbox_write_msg(&ipc_msg_to_low);
}



/*****************************************************************************/
/**
* Set DSSS value
*
* Send an IPC message to CPU Low to set the DSSS value
*
* @param    dsss_value  - Value of DSSS to send to CPU Low
*
* @return	None.
*
* @note		None.
*
******************************************************************************/
void set_dsss_value( unsigned int dsss_value ) {

	wlan_ipc_msg       ipc_msg_to_low;
	u32                ipc_msg_to_low_payload[1];
	ipc_config_phy_rx* config_phy_rx;

	// Send message to CPU Low
	ipc_msg_to_low.msg_id            = IPC_MBOX_MSG_ID(IPC_MBOX_CONFIG_PHY_RX);
	ipc_msg_to_low.num_payload_words = sizeof(ipc_config_phy_rx)/sizeof(u32);
	ipc_msg_to_low.payload_ptr       = &(ipc_msg_to_low_payload[0]);

	// Initialize the payload
	init_ipc_config(config_phy_rx, ipc_msg_to_low_payload, ipc_config_phy_rx);

	config_phy_rx->enable_dsss = dsss_value;

	ipc_mailbox_write_msg(&ipc_msg_to_low);
}

void set_backoff_slot_value( u32 num_slots ) {

	wlan_ipc_msg       ipc_msg_to_low;
	u32                ipc_msg_to_low_payload[1];
	ipc_config_mac*    config_mac;

	// Send message to CPU Low
	ipc_msg_to_low.msg_id            = IPC_MBOX_MSG_ID(IPC_MBOX_CONFIG_MAC);
	ipc_msg_to_low.num_payload_words = sizeof(ipc_config_phy_rx)/sizeof(u32);
	ipc_msg_to_low.payload_ptr       = &(ipc_msg_to_low_payload[0]);

	// Initialize the payload
	config_mac = (ipc_config_mac*) ipc_msg_to_low_payload;
	config_mac->slot_config = num_slots;

	ipc_mailbox_write_msg(&ipc_msg_to_low);
}



/*****************************************************************************/
/**
* Set tracking variable on CPU low's state
*
* @param    None.
*
* @return	None.
*
* @note		None.
*
******************************************************************************/

void set_cpu_low_not_ready() {
	cpu_high_status |= CPU_STATUS_WAIT_FOR_IPC_ACCEPT;
}


void set_cpu_low_ready() {
	cpu_high_status &= (~CPU_STATUS_WAIT_FOR_IPC_ACCEPT);
}




/*****************************************************************************/
/**
* Check variables on CPU low's state
*
* @param    None.
*
* @return	None.
*
* @note		None.
*
******************************************************************************/

int is_cpu_low_initialized(){
	return ( (cpu_low_status & CPU_STATUS_INITIALIZED) != 0 );
}

int is_cpu_low_ready(){
	// xil_printf("cpu_high_status = 0x%08x\n",cpu_high_status);
	return ((cpu_high_status & CPU_STATUS_WAIT_FOR_IPC_ACCEPT) == 0);
}













