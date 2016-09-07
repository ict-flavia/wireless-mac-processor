/*
 * wmp_high.c
 *
 *  Created on: Oct 7, 2013
 *      Author: Nicolo' Facchi
 */

//Xilinx SDK includes
#include "xparameters.h"
#include "stdio.h"
#include "stdlib.h"
#include "xtmrctr.h"
#include "xio.h"
#include "string.h"
#include "xintc.h"

//WARP includes
#include "wlan_mac_ipc_util.h"
#include "wlan_mac_ipc.h"
#include "wlan_mac_misc_util.h"
#include "wlan_mac_802_11_defs.h"
#include "wlan_mac_queue.h"
#include "wlan_mac_event_log.h"
#include "wlan_mac_events.h"
#include "wlan_mac_ltg.h"
#include "wlan_mac_util.h"
#include "wlan_mac_packet_types.h"
#include "wlan_mac_eth_util.h"
#include "wmp_high.h"
#include "ascii_characters.h"


// WLAN Exp includes
#include "wlan_exp_common.h"
#include "wlan_exp_node.h"
#include "wlan_exp_node_sta.h"
#include "wlan_exp_transport.h"

#include "wmp_high_util.h"
#include "wmp_high_ap.h"



/*************************** Constant Definitions ****************************/

#define  WLAN_EXP_ETH                  WN_ETH_B
#define  WLAN_EXP_TYPE                 WARPNET_TYPE_80211_BASE + WARPNET_TYPE_80211_STATION


#define  WLAN_CHANNEL                  14



/*********************** Global Variable Definitions *************************/



/*************************** Variable Definitions ****************************/

// If you want this station to try to associate to a known AP at boot, type
//   the string here. Otherwise, let it be an empty string.
/* WMP_START */
u8 modeofoperation = MODEOFOPERATION_STA; /* 0: STA, 1: AP */
char  apmode_default_ssid[] = "WARPWMPAP";
char default_AP_SSID[] = "";
char*  last_access_point_ssid;
/* WMP_END */
char*  access_point_ssid;

// Common TX header for 802.11 packets
mac_header_80211_common tx_header_common;


// Control variables
u8  default_unicast_rate;
int association_state;                      // Section 10.3 of 802.11-2012
u8  uart_mode;
u8  active_scan;
u8 pause_queue;


// Access point information
ap_info* ap_list;
u8       num_ap_list;

u8       access_point_num_basic_rates;
u8       access_point_basic_rates[NUM_BASIC_RATES_MAX];


// Association Table variables
//   The last entry in associations[MAX_ASSOCIATIONS][] is swap space
/* WMP_START */
station_info associations[MAX_ASSOCIATIONS+1];
station_info access_point;
u32          next_free_assoc_index;
u32			 max_queue_size;
u8 perma_assoc_mode;
u8 allow_assoc;
u16 beacon_interval;
/* WMP_END */


// AP channel
u32 mac_param_chan;
u32 mac_param_chan_save;


// AP MAC address / Broadcast address
u8 eeprom_mac_addr[6];
u8 bcast_addr[6]      = { 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF };

u16 ltg_packet_size;


/*************************** Functions Prototypes ****************************/



/******************************** Functions **********************************/

int main(){

	/* WMP_START */
	wlan_ipc_msg ipc_msg_to_low;
	u32 i;
	/* WMP_END */

	//This function should be executed first. It will zero out memory, and if that
	//memory is used before calling this function, unexpected results may happen.
	wlan_mac_util_init_data();

    // Initialize AP list
	num_ap_list = 0;
	//free(ap_list);
	ap_list = NULL;

	/* WMP_START */
	next_free_assoc_index = 0;
	beacon_interval = BEACON_INTERVAL_MS;
	bzero(&(associations[0]), sizeof(station_info)*(MAX_ASSOCIATIONS+1));

	for(i = 0; i < MAX_ASSOCIATIONS; i++){
		associations[i].AID = (1+i); //7.3.1.8 of 802.11-2007
		memset((void*)(&(associations[i].addr[0])), 0xFF,6);
		associations[i].seq = 0; //seq
	}
	if (modeofoperation == MODEOFOPERATION_STA) {
		max_queue_size = MAX_PER_FLOW_QUEUE;
	} else if (modeofoperation == MODEOFOPERATION_AP) {
		max_queue_size = min((queue_total_size()- eth_bd_total_size()) / (next_free_assoc_index+1),MAX_PER_FLOW_QUEUE);
	}
	enable_associations( ASSOCIATION_ALLOW_PERMANENT );
	/* WMP_END */

	//Unpause the queue
	pause_queue = 0;

	xil_printf("\n\n\n\n----- wlan_mac_sta -----\n");
	xil_printf("Compiled %s %s\n\n", __DATE__, __TIME__);


	//xil_printf("_heap_start = 0x%x, %x\n", *(char*)(_heap_start),_heap_start);
	//xil_printf("_heap_end = 0x%x, %x\n", *(char*)(_heap_end),_heap_end);

    // Set Global variables
	default_unicast_rate = WLAN_MAC_RATE_36M;

#ifdef USE_WARPNET_WLAN_EXP
	node_info_set_max_assn( 1 );
#endif

	// Initialize the utility library
	wlan_lib_init();
	if (modeofoperation == MODEOFOPERATION_STA) {
		wlan_mac_util_set_eth_encap_mode(ENCAP_MODE_STA);
	} else if (modeofoperation == MODEOFOPERATION_AP) {
		wlan_mac_util_set_eth_encap_mode(ENCAP_MODE_AP);
	}
    wlan_mac_util_init( WLAN_EXP_TYPE, WLAN_EXP_ETH );


    if (modeofoperation == MODEOFOPERATION_STA) {
		// Initialize callbacks
		wlan_mac_util_set_eth_rx_callback(       (void*)ethernet_receive);
		wlan_mac_util_set_mpdu_tx_done_callback( (void*)mpdu_transmit_done);
		wlan_mac_util_set_mpdu_rx_callback(      (void*)mpdu_rx_process);
		wlan_mac_util_set_ipc_rx_callback(       (void*)ipc_rx);
		wlan_mac_util_set_check_queue_callback(  (void*)check_tx_queue);

		wlan_mac_util_set_fcs_bad_rx_callback(   (void*)bad_fcs_rx_process);
		wlan_mac_util_set_uart_rx_callback(      (void*)uart_rx);
		wlan_mac_ltg_sched_set_callback(         (void*)ltg_event);
    } else if (modeofoperation == MODEOFOPERATION_AP) {
		wlan_mac_util_set_eth_rx_callback(       (void*)ethernet_receive_ap);
		wlan_mac_util_set_mpdu_tx_done_callback( (void*)mpdu_transmit_done_ap);
		wlan_mac_util_set_mpdu_rx_callback(      (void*)mpdu_rx_process_ap);
		wlan_mac_util_set_ipc_rx_callback(       (void*)ipc_rx);
		wlan_mac_util_set_check_queue_callback(  (void*)check_tx_queue_ap);

		wlan_mac_util_set_fcs_bad_rx_callback(   (void*)bad_fcs_rx_process_ap);
		wlan_mac_util_set_uart_rx_callback(      (void*)uart_rx);
		wlan_mac_ltg_sched_set_callback(         (void*)ltg_event_ap);
    }


    // Initialize interrupts
	interrupt_init();


	// Initialize Association Table
	bzero(&(access_point), sizeof(station_info));

	access_point.AID = 0; //7.3.1.8 of 802.11-2007
	memset((void*)(&(access_point.addr[0])), 0xFF,6);
	access_point.seq = 0; //seq
	access_point.rx_timestamp = 0;

	// Set default SSID for AP
	if (modeofoperation == MODEOFOPERATION_STA) {
		access_point_ssid = wlan_malloc(strlen(default_AP_SSID)+1);
		strcpy(access_point_ssid,default_AP_SSID);
		last_access_point_ssid = wlan_malloc(1);
		last_access_point_ssid[0] = 0;
	} else if (modeofoperation == MODEOFOPERATION_AP) {
		access_point_ssid = wlan_malloc(strlen(apmode_default_ssid)+1);
		last_access_point_ssid = wlan_malloc(strlen(apmode_default_ssid)+1);
		strcpy(access_point_ssid,apmode_default_ssid);
		strcpy(last_access_point_ssid,apmode_default_ssid);
	}


	// Set Association state for station to AP
	association_state = 1;


    // Wait for CPU Low to initialize
	while( is_cpu_low_initialized() == 0){
		xil_printf("waiting on CPU_LOW to boot\n");
	};


	// CPU Low will pass HW information to CPU High as part of the boot process
	//   - Get necessary HW information
	memcpy((void*) &(eeprom_mac_addr[0]), (void*) get_eeprom_mac_addr(), 6);


    // Set Header information
	tx_header_common.address_2 = &(eeprom_mac_addr[0]);
	tx_header_common.seq_num = 0;


    // Initialize hex display
	write_hex_display(0);


	// Set up channel
	mac_param_chan = WLAN_CHANNEL;
	mac_param_chan_save = mac_param_chan;
	set_mac_channel( mac_param_chan );

	/* WMP_START */
	wmp_high_fsm_init();
	/* WMP_END */


	// Print Station information to the terminal
    xil_printf("WLAN MAC boot complete: \n");
    xil_printf("  Default SSID : %s \n", access_point_ssid);
    xil_printf("  Channel      : %d \n", mac_param_chan);
	xil_printf("  MAC Addr     : %x-%x-%x-%x-%x-%x\n\n",eeprom_mac_addr[0],eeprom_mac_addr[1],eeprom_mac_addr[2],eeprom_mac_addr[3],eeprom_mac_addr[4],eeprom_mac_addr[5]);


#ifdef WLAN_USE_UART_MENU
	uart_mode = UART_MODE_MAIN;

	xil_printf("\nAt any time, press the Esc key in your terminal to access the AP menu\n");
#endif

	/* WMP_START */
	ipc_msg_to_low.msg_id = IPC_MBOX_MSG_ID(IPC_MBOX_MODE);
	ipc_msg_to_low.num_payload_words = 0;
	ipc_msg_to_low.arg0 = modeofoperation;
	ipc_mailbox_write_msg(&ipc_msg_to_low);

	if (modeofoperation == MODEOFOPERATION_STA) {
		if( strlen(default_AP_SSID) > 0 ) {
			active_scan = 1;
			probe_req_transmit();
		}
	} else if (modeofoperation == MODEOFOPERATION_AP) {
		wmp_high_util_update_beacon_template();
	}
	/* WMP_END */


#ifdef USE_WARPNET_WLAN_EXP
	// Set AP processing callbacks
	node_set_process_callback( (void *)wlan_exp_node_sta_processCmd );
#endif

	/* WMP_START */
	//wmp_high_util_create_fake_assoc(&access_point);
	/* WMP_END */

	while(1){
		//The design is entirely interrupt based. When no events need to be processed, the processor
		//will spin in this loop until an interrupt happens

#ifdef USE_WARPNET_WLAN_EXP
		interrupt_stop();
		transport_poll( WLAN_EXP_ETH );
		interrupt_start();
#endif
	}
	return -1;
}



/* WMP_START */
void check_tx_queue(){

	static u32 station_index = 0;
	u8 i;

	if (modeofoperation == MODEOFOPERATION_STA) {
		if(pause_queue == 0){
			static u32 queue_index = 0;
			if( is_cpu_low_ready() ){
				for(i=0;i<2;i++){
					//Alternate between checking the unassociated queue and the associated queue
					queue_index = (queue_index+1)%2;
					if(wlan_mac_poll_tx_queue(queue_index)){
						return;
					}
				}
			}
		}
	} else if (modeofoperation == MODEOFOPERATION_AP) {
		if (pause_queue == 0) {
			if( is_cpu_low_ready() ){
				for(i = 0; i < (next_free_assoc_index+1); i++){
					station_index = (station_index+1)%(next_free_assoc_index+1);

					if(station_index == next_free_assoc_index){
						//Check Broadcast Queue

						if(wlan_mac_poll_tx_queue(0)){
							return;
						}
					} else {
						//Check Station Queue
						if(wlan_mac_poll_tx_queue(associations[station_index].AID)){
							return;
						}
					}
				}

			}
		}
	}

}
/* WMP_END */



void mpdu_transmit_done(tx_frame_info* tx_mpdu){
	tx_event* tx_event_log_entry;

	void * mpdu = (void*)tx_mpdu + PHY_TX_PKT_BUF_MPDU_OFFSET;
	u8* mpdu_ptr_u8 = (u8*)mpdu;
	mac_header_80211* tx_80211_header;
	tx_80211_header = (mac_header_80211*)((void *)mpdu_ptr_u8);



	tx_event_log_entry = get_next_empty_tx_event();

	if(tx_event_log_entry != NULL){
		tx_event_log_entry->state                    = tx_mpdu->state;
		tx_event_log_entry->AID                      = 1;
		tx_event_log_entry->power                    = 0; //TODO
		tx_event_log_entry->length                   = tx_mpdu->length;
		tx_event_log_entry->rate                     = tx_mpdu->rate;
		tx_event_log_entry->mac_type                 = tx_80211_header->frame_control_1;
		tx_event_log_entry->seq                      = ((tx_80211_header->sequence_control)>>4)&0xFFF;
		tx_event_log_entry->retry_count              = tx_mpdu->retry_count;
		tx_event_log_entry->tx_mpdu_accept_timestamp = tx_mpdu->tx_mpdu_accept_timestamp;
		tx_event_log_entry->tx_mpdu_done_timestamp   = tx_mpdu->tx_mpdu_done_timestamp;
	}

	wlan_mac_util_process_tx_done(tx_mpdu, &(access_point));
}




void attempt_association(){
	//It is assumed that the global "access_point" has a valid BSSID (MAC Address).
	//This function should only be called after selecting an access point through active scan

	static u8      curr_try = 0;
	u16            tx_length;
	packet_bd_list checkout;
	packet_bd*	   tx_queue;

	switch(association_state){

		case 1:
			//Initial start state, unauthenticated, unassociated
			//Checkout 1 element from the queue;
			curr_try = 0;
		break;

		case 2:
			//Authenticated, not associated
			curr_try = 0;
			//Checkout 1 element from the queue;
			queue_checkout(&checkout,1);
			if(checkout.length == 1){ //There was at least 1 free queue element
				tx_queue = checkout.first;

		 		setup_tx_header( &tx_header_common, access_point.addr, access_point.addr );

				tx_length = wlan_create_association_req_frame((void*)((tx_packet_buffer*)(tx_queue->buf_ptr))->frame, &tx_header_common, (u8)strlen(access_point_ssid), (u8*)access_point_ssid, access_point_num_basic_rates, access_point_basic_rates);

		 		setup_tx_queue ( tx_queue, NULL, tx_length, MAX_RETRY,
		 				         (TX_MPDU_FLAGS_FILL_DURATION | TX_MPDU_FLAGS_REQ_TO) );

				enqueue_after_end(0, &checkout);
				check_tx_queue();
			}
			if( curr_try < (ASSOCIATION_NUM_TRYS - 1) ){
				wlan_mac_schedule_event(SCHEDULE_COARSE, ASSOCIATION_TIMEOUT_US, (void*)attempt_association);
				curr_try++;
			} else {
				curr_try = 0;
			}

		break;

		case 3:
			//Authenticated and associated (Pending RSN Authentication)
			//Not-applicable for current 802.11 Reference Design
			curr_try = 0;
		break;

		case 4:
			//Authenticated and associated
			curr_try = 0;

		break;
	}

	return;
}




void attempt_authentication(){
	//It is assumed that the global "access_point" has a valid BSSID (MAC Address).
	//This function should only be called after selecting an access point through active scan

	static u8      curr_try = 0;
	u16            tx_length;
	packet_bd_list checkout;
	packet_bd*	   tx_queue;

	switch(association_state){

		case 1:
			//Initial start state, unauthenticated, unassociated
			//Checkout 1 element from the queue;
			queue_checkout(&checkout,1);
			if(checkout.length == 1){ //There was at least 1 free queue element
				tx_queue = checkout.first;

		 		setup_tx_header( &tx_header_common, access_point.addr, access_point.addr );

				tx_length = wlan_create_auth_frame((void*)((tx_packet_buffer*)(tx_queue->buf_ptr))->frame, &tx_header_common, AUTH_ALGO_OPEN_SYSTEM, AUTH_SEQ_REQ, STATUS_SUCCESS);

		 		setup_tx_queue ( tx_queue, NULL, tx_length, MAX_RETRY,
		 				         (TX_MPDU_FLAGS_FILL_DURATION | TX_MPDU_FLAGS_REQ_TO) );

				enqueue_after_end(0, &checkout);
				check_tx_queue();
			}
			if( curr_try < (AUTHENTICATION_NUM_TRYS - 1) ){
				wlan_mac_schedule_event(SCHEDULE_COARSE, AUTHENTICATION_TIMEOUT_US, (void*)attempt_authentication);
				curr_try++;
			} else {
				curr_try = 0;
			}


		break;

		case 2:
			//Authenticated, not associated
			curr_try = 0;
		break;

		case 3:
			//Authenticated and associated (Pending RSN Authentication)
			//Not-applicable for current 802.11 Reference Design
			curr_try = 0;
		break;

		case 4:
			//Authenticated and associated
			curr_try = 0;

		break;

	}

	return;
}





void probe_req_transmit(){
	/* WMP_START */
	//u32 i;
	/* WMP_END */

	static u8 curr_channel_index = 0;
	/* WMP_START */
	/*u16 tx_length;
	packet_bd_list checkout;
	packet_bd*	tx_queue;*/
	/* WMP_END */

	mac_param_chan = curr_channel_index + 1; //+1 is to shift [0,10] index to [1,11] channel number

	//xil_printf("+++ probe_req_transmit mac_param_chan = %d\n", mac_param_chan);

	//Send a message to other processor to tell it to switch channels
	set_mac_channel( mac_param_chan );

	//wlan_mac_schedule_event(SCHEDULE_COARSE, 3000000, (void*)print_ap_list);
	//return;
	//Send probe request

	//xil_printf("Probe Req SSID: %s, Len: %d\n",access_point_ssid, strlen(access_point_ssid));

	/* WMP_START */
	/*for(i = 0; i<NUM_PROBE_REQ; i++){
	//Checkout 1 element from the queue;
	queue_checkout(&checkout,1);
		if(checkout.length == 1){ //There was at least 1 free queue element
			tx_queue = checkout.first;

			setup_tx_header( &tx_header_common, bcast_addr, bcast_addr );

			tx_length = wlan_create_probe_req_frame((void*)((tx_packet_buffer*)(tx_queue->buf_ptr))->frame,&tx_header_common, strlen(access_point_ssid), (u8*)access_point_ssid, mac_param_chan);

	 		setup_tx_queue ( tx_queue, NULL, tx_length, 0, 0 );

			enqueue_after_end(0, &checkout);
			check_tx_queue();
		}
	}*/

	curr_channel_index = (curr_channel_index+1)%14;

	if(curr_channel_index > 0){
		wlan_mac_schedule_event(SCHEDULE_COARSE, 200000, (void*)probe_req_transmit);
	} else {
		wlan_mac_schedule_event(SCHEDULE_COARSE, 200000, (void*)print_ap_list);
	}
	/* WMP_END */
}




int ethernet_receive(packet_bd_list* tx_queue_list, u8* eth_dest, u8* eth_src, u16 tx_length){

	//Receives the pre-encapsulated Ethernet frames
	packet_bd* tx_queue = tx_queue_list->first;

	//setup_tx_header( &tx_header_common, (u8*)(&(eth_dest[0])), (u8*)(&(eth_src[0])) );
	setup_tx_header( &tx_header_common, (u8*)access_point.addr,(u8*)(&(eth_dest[0])));

	wlan_create_data_frame((void*)((tx_packet_buffer*)(tx_queue->buf_ptr))->frame, &tx_header_common, MAC_FRAME_CTRL2_FLAG_TO_DS);

	if(wlan_addr_eq(bcast_addr, eth_dest)){
		if(queue_num_queued(0) < max_queue_size){
			setup_tx_queue ( tx_queue, NULL, tx_length, 0, 0 );

			enqueue_after_end(0, tx_queue_list);
			check_tx_queue();
		} else {
			return 0;
		}

	} else {

		if(access_point.AID != 0){

			if(queue_num_queued(1) < max_queue_size){

				setup_tx_queue ( tx_queue, (void*)&(access_point), tx_length, MAX_RETRY,
								 (TX_MPDU_FLAGS_FILL_DURATION | TX_MPDU_FLAGS_REQ_TO) );

				enqueue_after_end(1, tx_queue_list);
				check_tx_queue();
			} else {
				return 0;
			}
		}

	}

	return 1;


}


void mpdu_rx_process(void* pkt_buf_addr, u8 rate, u16 length) {
	u32 i;
	void * mpdu = pkt_buf_addr + PHY_RX_PKT_BUF_MPDU_OFFSET;
	u8* mpdu_ptr_u8 = (u8*)mpdu;

	ap_info* curr_ap_info = NULL;
	char* ssid;

	mac_header_80211* rx_80211_header;
	rx_80211_header = (mac_header_80211*)((void *)mpdu_ptr_u8);
	u16 rx_seq;

	void* rx_event_log_entry;

	rx_frame_info* mpdu_info = (rx_frame_info*)pkt_buf_addr;

	u8 is_associated = 0;

	/* WMP_START */
	wlan_ipc_msg ipc_msg_to_low;
	u8 ipc_msg_to_low_payload[8]; // multiple of 4 bytes
	/* WMP_END */

	/* WMP_START */
	/* MERGE RX_DEV_DOMENICO_2 */
	//debug START
	typedef struct{
		u8 state;
		u8 rate;
		u16 length;
		char rx_power;
		u8 rf_gain;
		u8 bb_gain;
		u8 channel;
		u8 flags;
		u8 reserved[7];
		u32 channel_est[64];
	} rx_frame_info;

	/* xil_printf( "state = 0x%02x "
				"rx_power = %c "
				"rf_gain = 0x%02x "
				"bb_gain = 0x%02x "
				"length = 0x%04x "
				"rate = 0x%02x \n",
				mpdu_info->state,
				mpdu_info->rx_power,
				mpdu_info->rf_gain,
				mpdu_info->bb_gain,
				mpdu_info->length,
				mpdu_info->rate);
			//	rx_80211_header->frame_control_1,
			//	((rx_80211_header->sequence_control)>>4)&0xFFF,
			//	mpdu_info->flags);
*/



	//debug END
	/* WMP_END */


	if(rate != WLAN_MAC_RATE_1M){
			rx_event_log_entry = (void*)get_next_empty_rx_ofdm_event();

			if(rx_event_log_entry != NULL){
				((rx_ofdm_event*)rx_event_log_entry)->state    = mpdu_info->state;
				((rx_ofdm_event*)rx_event_log_entry)->AID      = 0;
				((rx_ofdm_event*)rx_event_log_entry)->power    = mpdu_info->rx_power;
				((rx_ofdm_event*)rx_event_log_entry)->rf_gain  = mpdu_info->rf_gain;
				((rx_ofdm_event*)rx_event_log_entry)->bb_gain  = mpdu_info->bb_gain;
				((rx_ofdm_event*)rx_event_log_entry)->length   = mpdu_info->length;
				((rx_ofdm_event*)rx_event_log_entry)->rate     = mpdu_info->rate;
				((rx_ofdm_event*)rx_event_log_entry)->mac_type = rx_80211_header->frame_control_1;
				((rx_ofdm_event*)rx_event_log_entry)->seq      = ((rx_80211_header->sequence_control)>>4)&0xFFF;
				((rx_ofdm_event*)rx_event_log_entry)->flags    = mpdu_info->flags;

		#ifdef WLAN_MAC_EVENTS_LOG_CHAN_EST
				if(rate != WLAN_MAC_RATE_1M) wlan_mac_cdma_start_transfer(((rx_ofdm_event*)rx_event_log_entry)->channel_est, mpdu_info->channel_est, sizeof(mpdu_info->channel_est));
		#endif

			}
		} else {
			rx_event_log_entry = (void*)get_next_empty_rx_dsss_event();

			if(rx_event_log_entry != NULL){
				((rx_dsss_event*)rx_event_log_entry)->state    = mpdu_info->state;
				((rx_dsss_event*)rx_event_log_entry)->AID      = 0;
				((rx_dsss_event*)rx_event_log_entry)->power    = mpdu_info->rx_power;
				((rx_ofdm_event*)rx_event_log_entry)->rf_gain  = mpdu_info->rf_gain;
				((rx_ofdm_event*)rx_event_log_entry)->bb_gain  = mpdu_info->bb_gain;
				((rx_dsss_event*)rx_event_log_entry)->length   = mpdu_info->length;
				((rx_dsss_event*)rx_event_log_entry)->rate     = mpdu_info->rate;
				((rx_dsss_event*)rx_event_log_entry)->mac_type = rx_80211_header->frame_control_1;
				((rx_dsss_event*)rx_event_log_entry)->seq      = ((rx_80211_header->sequence_control)>>4)&0xFFF;
				((rx_dsss_event*)rx_event_log_entry)->flags    = mpdu_info->flags;
			}
		}


	if(wlan_addr_eq(access_point.addr, (rx_80211_header->address_2))) {
		is_associated = 1;

		if(rate != WLAN_MAC_RATE_1M){
			if(rx_event_log_entry != NULL) ((rx_ofdm_event*)rx_event_log_entry)->AID = 1;
		} else {
			if(rx_event_log_entry != NULL) ((rx_dsss_event*)rx_event_log_entry)->AID = 1;
		}
		rx_seq = ((rx_80211_header->sequence_control)>>4)&0xFFF;
		//Check if duplicate
		access_point.rx_timestamp = get_usec_timestamp();
		access_point.last_rx_power = mpdu_info->rx_power;

		if( (access_point.seq != 0)  && (access_point.seq == rx_seq) ) {
			//Received seq num matched previously received seq num for this STA; ignore the MPDU and return
#ifdef WLAN_MAC_EVENTS_LOG_CHAN_EST
			if(rate != WLAN_MAC_RATE_1M) wlan_mac_cdma_finish_transfer();
#endif
			return;

		} else {
			access_point.seq = rx_seq;
		}
	}

	switch(rx_80211_header->frame_control_1) {
	case (MAC_FRAME_CTRL1_SUBTYPE_DATA): //Data Packet
		if(is_associated){
			if((rx_80211_header->frame_control_2) & MAC_FRAME_CTRL2_FLAG_FROM_DS) {
				//MPDU is flagged as destined to the DS - send it for de-encapsulation and Ethernet Tx (if appropriate)

				(access_point.num_rx_success)++;
				(access_point.num_rx_bytes) += mpdu_info->length;

				wlan_mpdu_eth_send(mpdu,length);
			}
		}
		break;

		case (MAC_FRAME_CTRL1_SUBTYPE_ASSOC_RESP): //Association response
			if(association_state == 2){
				mpdu_ptr_u8 += sizeof(mac_header_80211);

				if(((association_response_frame*)mpdu_ptr_u8)->status_code == STATUS_SUCCESS){
					association_state = 4;
					access_point.AID = (((association_response_frame*)mpdu_ptr_u8)->association_id)&~0xC000;
					write_hex_display(access_point.AID);
					access_point.tx_rate = default_unicast_rate;

					/* WMP_START */
					ipc_msg_to_low.msg_id = IPC_MBOX_MSG_ID(IPC_MBOX_ASSOC_BEACON_MAC);
					ipc_msg_to_low.arg0 = 0;
					ipc_msg_to_low.num_payload_words = (sizeof(ipc_msg_to_low_payload)/sizeof(u32));
					memcpy(ipc_msg_to_low_payload, access_point.addr, 6);
					ipc_msg_to_low.payload_ptr       = (u32 *)&(ipc_msg_to_low_payload[0]);
					ipc_mailbox_write_msg(&ipc_msg_to_low);
					/* WMP_END */

					xil_printf("Association succeeded\n");
				} else {
					association_state = -1;
					xil_printf("Association failed, reason code %d\n", ((association_response_frame*)mpdu_ptr_u8)->status_code);
				}
			}

		break;

		case (MAC_FRAME_CTRL1_SUBTYPE_AUTH): //Authentication
				if(association_state == 1 && wlan_addr_eq(rx_80211_header->address_3, access_point.addr) && wlan_addr_eq(rx_80211_header->address_1, eeprom_mac_addr)) {
					mpdu_ptr_u8 += sizeof(mac_header_80211);
					switch(((authentication_frame*)mpdu_ptr_u8)->auth_algorithm){
						case AUTH_ALGO_OPEN_SYSTEM:
							if(((authentication_frame*)mpdu_ptr_u8)->auth_sequence == AUTH_SEQ_RESP){//This is an auth response
								if(((authentication_frame*)mpdu_ptr_u8)->status_code == STATUS_SUCCESS){
									//AP is letting us authenticate
									association_state = 2;
									attempt_association();
								}
#ifdef WLAN_MAC_EVENTS_LOG_CHAN_EST
								if(rate != WLAN_MAC_RATE_1M) wlan_mac_cdma_finish_transfer();
#endif
								return;
							}
						break;
					}
				}

		break;

		case (MAC_FRAME_CTRL1_SUBTYPE_DEAUTH): //Deauthentication
				if(wlan_addr_eq(rx_80211_header->address_1, eeprom_mac_addr)){
					access_point.AID = 0;
					write_hex_display(access_point.AID);
					//memset((void*)(&(access_point.addr[0])), 0xFF,6);
					access_point.seq = 0; //seq

					//Attempt reauthentication
					association_state = 1;
					attempt_authentication();
				}
		break;

		case (MAC_FRAME_CTRL1_SUBTYPE_BEACON): //Beacon Packet
		case (MAC_FRAME_CTRL1_SUBTYPE_PROBE_RESP): //Probe Response Packet

				if(active_scan){

				for (i=0;i<num_ap_list;i++){

					if(wlan_addr_eq(ap_list[i].bssid, rx_80211_header->address_3)){
						curr_ap_info = &(ap_list[i]);
						//xil_printf("     Matched at 0x%08x\n", curr_ap_info);
						break;
					}
				}

				if(curr_ap_info == NULL){

					if(ap_list == NULL){
						ap_list = wlan_malloc(sizeof(ap_info)*(num_ap_list+1));
					} else {
						ap_list = wlan_realloc(ap_list, sizeof(ap_info)*(num_ap_list+1));
					}

					if(ap_list != NULL){
						num_ap_list++;
						curr_ap_info = &(ap_list[num_ap_list-1]);
					} else {
						xil_printf("Reallocation of ap_list failed\n");
#ifdef WLAN_MAC_EVENTS_LOG_CHAN_EST
						if(rate != WLAN_MAC_RATE_1M) wlan_mac_cdma_finish_transfer();
#endif
						return;
					}

				}

				curr_ap_info->rx_power = mpdu_info->rx_power;
				curr_ap_info->num_basic_rates = 0;

				//Copy BSSID into ap_info struct
				memcpy(curr_ap_info->bssid, rx_80211_header->address_3,6);

				mpdu_ptr_u8 += sizeof(mac_header_80211);
				if((((beacon_probe_frame*)mpdu_ptr_u8)->capabilities)&CAPABILITIES_PRIVACY){
					curr_ap_info->private = 1;
				} else {
					curr_ap_info->private = 0;
				}

				mpdu_ptr_u8 += sizeof(beacon_probe_frame);
				//xil_printf("\n");
				while(((u32)mpdu_ptr_u8 -  (u32)mpdu)<= length){ //Loop through tagged parameters
					switch(mpdu_ptr_u8[0]){ //What kind of tag is this?
						case TAG_SSID_PARAMS: //SSID parameter set
							ssid = (char*)(&(mpdu_ptr_u8[2]));


							memcpy(curr_ap_info->ssid, ssid ,min(mpdu_ptr_u8[1],SSID_LEN_MAX-1));
							//Terminate the string
							(curr_ap_info->ssid)[min(mpdu_ptr_u8[1],SSID_LEN_MAX-1)] = 0;

							//xil_printf("[%d] SSID:     %s\n", i, curr_ap_info->ssid);

						break;
						case TAG_SUPPORTED_RATES: //Supported rates
							for(i=0;i < mpdu_ptr_u8[1]; i++){
								if(mpdu_ptr_u8[2+i]&RATE_BASIC){
									//This is a basic rate. It is required by the AP in order to associate.
									if((curr_ap_info->num_basic_rates) < NUM_BASIC_RATES_MAX){

										if(valid_tagged_rate(mpdu_ptr_u8[2+i])){

											(curr_ap_info->basic_rates)[(curr_ap_info->num_basic_rates)] = mpdu_ptr_u8[2+i];
											(curr_ap_info->num_basic_rates)++;
										} else {

										}
									} else {
									}
								}
							}


						break;
						case TAG_EXT_SUPPORTED_RATES: //Extended supported rates
							for(i=0;i < mpdu_ptr_u8[1]; i++){
									if(mpdu_ptr_u8[2+i]&RATE_BASIC){
										//This is a basic rate. It is required by the AP in order to associate.
										if((curr_ap_info->num_basic_rates) < NUM_BASIC_RATES_MAX){

											if(valid_tagged_rate(mpdu_ptr_u8[2+i])){
											//	xil_printf("Basic rate #%d: 0x%x\n", (curr_ap_info->num_basic_rates), mpdu_ptr_u8[2+i]);

												(curr_ap_info->basic_rates)[(curr_ap_info->num_basic_rates)] = mpdu_ptr_u8[2+i];
												(curr_ap_info->num_basic_rates)++;
											} else {
												//xil_printf("Invalid tagged rate. ignoring.");
											}
										} else {
											//xil_printf("Error: too many rates were flagged as basic. ignoring.");
										}
									}
								}

						break;
						case TAG_DS_PARAMS: //DS Parameter set (e.g. channel)
							curr_ap_info->chan = mpdu_ptr_u8[2];
						break;
					}
					mpdu_ptr_u8 += mpdu_ptr_u8[1]+2; //Move up to the next tag
				}

			}

		break;

		default:
			//This should be left as a verbose print. It occurs often when communicating with mobile devices since they tend to send
			//null data frames (type: DATA, subtype: 0x4) for power management reasons.
			warp_printf(PL_VERBOSE, "Received unknown frame control type/subtype %x\n",rx_80211_header->frame_control_1);
		break;
	}
#ifdef WLAN_MAC_EVENTS_LOG_CHAN_EST
	if(rate != WLAN_MAC_RATE_1M) wlan_mac_cdma_finish_transfer();
#endif
	return;
}




void ltg_event(u32 id, void* callback_arg){
	packet_bd_list checkout;
	packet_bd* tx_queue;
	u32 tx_length;
	u8* mpdu_ptr_u8;
	llc_header* llc_hdr;
	u32 payload_length = 0;

	switch(((ltg_pyld_hdr*)callback_arg)->type){
		case LTG_PYLD_TYPE_FIXED:
			payload_length = ((ltg_pyld_fixed*)callback_arg)->length;
		break;
		case LTG_PYLD_TYPE_UNIFORM_RAND:
			payload_length = (rand()%(((ltg_pyld_uniform_rand*)(callback_arg))->max_length - ((ltg_pyld_uniform_rand*)(callback_arg))->min_length))+((ltg_pyld_uniform_rand*)(callback_arg))->min_length;
		break;
		default:
		break;
	}

	if(id == 0 && (access_point.AID > 0)){
		//Send a Data packet to AP
		//Checkout 1 element from the queue;
		queue_checkout(&checkout,1);

		if(checkout.length == 1){ //There was at least 1 free queue element
			tx_queue = checkout.first;

	 		setup_tx_header( &tx_header_common, access_point.addr, access_point.addr );

			mpdu_ptr_u8 = (u8*)((tx_packet_buffer*)(tx_queue->buf_ptr))->frame;
			tx_length = wlan_create_data_frame((void*)((tx_packet_buffer*)(tx_queue->buf_ptr))->frame, &tx_header_common, MAC_FRAME_CTRL2_FLAG_TO_DS);

			mpdu_ptr_u8 += sizeof(mac_header_80211);
			llc_hdr = (llc_header*)(mpdu_ptr_u8);

			//Prepare the MPDU LLC header
			llc_hdr->dsap = LLC_SNAP;
			llc_hdr->ssap = LLC_SNAP;
			llc_hdr->control_field = LLC_CNTRL_UNNUMBERED;
			bzero((void *)(llc_hdr->org_code), 3); //Org Code 0x000000: Encapsulated Ethernet
			llc_hdr->type = LLC_TYPE_CUSTOM;

			tx_length += sizeof(llc_header);
			tx_length += payload_length;

	 		setup_tx_queue ( tx_queue, (void*)&(access_point), tx_length, MAX_RETRY,
	 				         (TX_MPDU_FLAGS_FILL_DURATION | TX_MPDU_FLAGS_REQ_TO) );

			enqueue_after_end(1, &checkout);
			check_tx_queue();
		}
	}

}






void print_ap_list(){
	u32 i,j;
	char str[4];
	u16 ap_sel;

	uart_mode = UART_MODE_AP_LIST;
	active_scan = 0;
	pause_queue = 0;

	//Revert to the previous channel that we were on prior to the active scan
	mac_param_chan = mac_param_chan_save;
	set_mac_channel( mac_param_chan );

//	xil_printf("\f");

	xil_printf("************************ AP List *************************\n");

	for(i=0; i<num_ap_list; i++){
		xil_printf("[%d] SSID:     %s ", i, ap_list[i].ssid);
		if(ap_list[i].private == 1){
			xil_printf("(*)\n");
		} else {
			xil_printf("\n");
		}

		xil_printf("    BSSID:         %02x-%02x-%02x-%02x-%02x-%02x\n", ap_list[i].bssid[0],ap_list[i].bssid[1],ap_list[i].bssid[2],ap_list[i].bssid[3],ap_list[i].bssid[4],ap_list[i].bssid[5]);
		xil_printf("    Channel:       %d\n",ap_list[i].chan);
		xil_printf("    Rx Power:      %d dBm\n",ap_list[i].rx_power);
		xil_printf("    Basic Rates:   ");
		for(j = 0; j < (ap_list[i].num_basic_rates); j++ ){
			tagged_rate_to_readable_rate(ap_list[i].basic_rates[j], str);
			xil_printf("%s, ",str);
		}
		xil_printf("\b\b \n");

	}

	/* WMP_START */
	if (modeofoperation == MODEOFOPERATION_STA) {
		if(strlen(access_point_ssid) == 0){
			xil_printf("\n(*) Private Network (not supported)\n");
			xil_printf("\n To join a network, type the number next to the SSID that\n");
			xil_printf("you want to join and press enter. Otherwise, press Esc to return\n");
			xil_printf("AP Selection: ");
		} else {
			for(i=0; i<num_ap_list; i++){
				if(strcmp(access_point_ssid,ap_list[i].ssid) == 0){
					ap_sel = i;
					if( ap_list[ap_sel].private == 0) {
						mac_param_chan = ap_list[ap_sel].chan;

						//Send a message to other processor to tell it to switch channels
						set_mac_channel( mac_param_chan );

						xil_printf("\nAttempting to join %s\n", ap_list[ap_sel].ssid);
						memcpy(access_point.addr, ap_list[ap_sel].bssid, 6);

						access_point_ssid = wlan_realloc(access_point_ssid, strlen(ap_list[ap_sel].ssid)+1);
						strcpy(access_point_ssid,ap_list[ap_sel].ssid);

						access_point_num_basic_rates = ap_list[ap_sel].num_basic_rates;
						memcpy(access_point_basic_rates, ap_list[ap_sel].basic_rates,access_point_num_basic_rates);

						association_state = 1;
						attempt_authentication();
						return;
					} else {
						xil_printf("AP with SSID %s is private\n", access_point_ssid);
						return;
					}
				}
			}
			xil_printf("Failed to find AP with SSID of %s\n", access_point_ssid);
		}
	}
	/* WMP_END */

}

void bad_fcs_rx_process(void* pkt_buf_addr, u8 rate, u16 length) {
	bad_fcs_event* bad_fcs_event_log_entry = get_next_empty_bad_fcs_event();
	bad_fcs_event_log_entry->length = length;
	bad_fcs_event_log_entry->rate = rate;
}

void reset_station_statistics(){
	access_point.num_tx_total = 0;
	access_point.num_tx_success = 0;
	access_point.num_retry = 0;
	access_point.num_rx_success = 0;
	access_point.num_rx_bytes = 0;
}




/*****************************************************************************/
/**
* Get AP List
*
* This function will populate the buffer with:
*   buffer[0]      = Number of stations
*   buffer[1 .. N] = memcpy of the station information structure
* where N is less than max_words
*
* @param    stations      - Station info pointer
*           num_stations  - Number of stations to copy
*           buffer        - u32 pointer to the buffer to transfer the data
*           max_words     - The maximum number of words in the buffer
*
* @return	Number of words copied in to the buffer
*
* @note     None.
*
******************************************************************************/
int get_ap_list( ap_info * ap_list, u32 num_ap, u32 * buffer, u32 max_words ) {

	unsigned int size;
	unsigned int index;

	index     = 0;

	// Set number of Association entries
	buffer[ index++ ] = num_ap;

	// Get total size (in bytes) of data to be transmitted
	size   = num_ap * sizeof( ap_info );

	// Get total size of data (in words) to be transmitted
	index += size / sizeof( u32 );

    if ( (size > 0 ) && (index < max_words) ) {

        memcpy( &buffer[1], ap_list, size );
    }

// #ifdef _DEBUG_
	#ifdef USE_WARPNET_WLAN_EXP
    wlan_exp_print_ap_list( ap_list, num_ap );
	#endif
// #endif

	return index;
}

/* WMP_START */
void enable_associations( u32 permanent_association ){
	// Send a message to other processor to tell it to enable associations
#ifdef _DEBUG_
	xil_printf("Allowing new associations\n");
#endif

	// Set the DSSS value in CPU Low
	set_dsss_value( 1 );

    // Set the global variable
	allow_assoc = 1;

	// Set the global variable for permanently allowing associations
	switch ( permanent_association ) {

        case ASSOCIATION_ALLOW_PERMANENT:
        	perma_assoc_mode = 1;
        break;

        case ASSOCIATION_ALLOW_TEMPORARY:
        	perma_assoc_mode = 0;
        break;
	}
}
/* WMP_END */

