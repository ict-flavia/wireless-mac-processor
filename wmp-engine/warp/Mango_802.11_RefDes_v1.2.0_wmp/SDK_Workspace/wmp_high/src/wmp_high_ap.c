/*
 * wmp_high_ap.c
 *
 *  Created on: May 8, 2014
 *      Author: Nicolo' Facchi
 */

#include "stdlib.h"

#include "wmp_fsm.h"
#include "wmp_common_sw_reg.h"
#include "wmp_high_fsm_slots_handler.h"

#include "wlan_mac_ipc_util.h"
#include "wlan_mac_802_11_defs.h"

#include "xil_types.h"
#include "xparameters.h"
#include "wmp_high_ap.h"

#include "xintc.h"
#include "wlan_mac_event_log.h"
#include "wlan_mac_events.h"
#include "wlan_mac_eth_util.h"
#include "wlan_mac_ltg.h"
#include "wlan_mac_ipc.h"

static void remove_station( unsigned int station_index ) {

	// If there are stations in the association table and the station to remove
	//   is in the association table, then remove it.

#ifdef _DEBUG
	xil_printf("next_free_assoc_index = %d \n", next_free_assoc_index);
#endif

	if( ( next_free_assoc_index > 0 ) && ( station_index < MAX_ASSOCIATIONS ) ) {

		// Decrement global variable
		next_free_assoc_index--;

		max_queue_size = min((queue_total_size()- eth_bd_total_size()) / (next_free_assoc_index+1),MAX_PER_FLOW_QUEUE);

		// Clear Association Address
		memcpy(&(associations[station_index].addr[0]), bcast_addr, 6);

		// If this station is not the last in the table, then re-pack
		if( station_index < next_free_assoc_index ) {
			//Copy from current index to the swap space
			memcpy(&(associations[MAX_ASSOCIATIONS]), &(associations[station_index]), sizeof(station_info));

			//Shift later entries back into the freed association entry
			memcpy(&(associations[station_index]), &(associations[station_index+1]), (next_free_assoc_index - station_index)*sizeof(station_info));

			//Copy from swap space to current free index
			memcpy(&(associations[next_free_assoc_index]), &(associations[MAX_ASSOCIATIONS]), sizeof(station_info));
		}
	}
}

static void print_associations(){
	u64 timestamp = get_usec_timestamp();
	u32 i;

	write_hex_display(next_free_assoc_index);
	xil_printf("\n   Current Associations\n (MAC time = %d usec)\n",timestamp);
			xil_printf("|-ID-|----- MAC ADDR ----|\n");
	for(i=0; i < next_free_assoc_index; i++){
		if(wlan_addr_eq(associations[i].addr, bcast_addr)) {
			xil_printf("| %02x |                   |\n", associations[i].AID);
		} else {
			xil_printf("| %02x | %02x:%02x:%02x:%02x:%02x:%02x |\n", associations[i].AID,
					associations[i].addr[0],associations[i].addr[1],associations[i].addr[2],associations[i].addr[3],associations[i].addr[4],associations[i].addr[5]);
		}
	}
			xil_printf("|------------------------|\n");

	return;
}

void wmp_high_util_update_beacon_template()
{
	mac_header_80211_common tx_80211_header_common;
	wlan_ipc_msg ipc_msg_to_low;
	u16 tx_length;
	tx_frame_info* tx_mpdu;

	ipc_msg_to_low.msg_id = IPC_MBOX_MSG_ID(IPC_MBOX_UPDATE);
	ipc_msg_to_low.num_payload_words = 0;
	ipc_msg_to_low.arg0 = WMP_IPC_MBOX_UPDATE_BEACON_TEMPLATE_INVALID;
	ipc_mailbox_write_msg(&ipc_msg_to_low);

	if (lock_pkt_buf_tx(TX_BUFFER_BEACON) == PKT_BUF_MUTEX_SUCCESS) {
		setup_tx_header( &tx_80211_header_common, bcast_addr, eeprom_mac_addr );

        tx_length = wlan_create_beacon_frame(
        		(void*)(TX_PKT_BUF_TO_ADDR(TX_BUFFER_BEACON)+PHY_TX_PKT_BUF_MPDU_OFFSET),
        		&tx_80211_header_common, beacon_interval, strlen(access_point_ssid),
        		(u8*)access_point_ssid, mac_param_chan);

        last_access_point_ssid = wlan_realloc(last_access_point_ssid, strlen(access_point_ssid)+1);
        strcpy(last_access_point_ssid,access_point_ssid);

        tx_mpdu = (tx_frame_info*)TX_PKT_BUF_TO_ADDR(TX_BUFFER_BEACON);
        tx_mpdu->length = tx_length;
        tx_mpdu->retry_max = 0;
        tx_mpdu->flags = TX_MPDU_FLAGS_FILL_TIMESTAMP;

        if(unlock_pkt_buf_tx(TX_BUFFER_BEACON) != PKT_BUF_MUTEX_SUCCESS){
			warp_printf(PL_ERROR, "Error: unable to unlock beacon pkt_buf %d\n", TX_BUFFER_BEACON);
			return;
		}

        ipc_msg_to_low.msg_id = IPC_MBOX_MSG_ID(IPC_MBOX_UPDATE);
		ipc_msg_to_low.num_payload_words = 0;
		ipc_msg_to_low.arg0 = WMP_IPC_MBOX_UPDATE_BEACON_TEMPLATE;
		ipc_mailbox_write_msg(&ipc_msg_to_low);
	} else {
		warp_printf(PL_WARNING, "TX template update delayed\n", TX_BUFFER_BEACON);
		wlan_mac_schedule_event(SCHEDULE_COARSE, 100000, (void*)wmp_high_util_update_beacon_template);
	}
}

int ethernet_receive_ap(packet_bd_list* tx_queue_list, u8* eth_dest, u8* eth_src, u16 tx_length){
	//Receives the pre-encapsulated Ethernet frames

	packet_bd* tx_queue = tx_queue_list->first;

	u32 i;
	u8 is_associated = 0;

	setup_tx_header( &tx_header_common, (u8*)(&(eth_dest[0])), (u8*)(&(eth_src[0])) );

	wlan_create_data_frame((void*)((tx_packet_buffer*)(tx_queue->buf_ptr))->frame, &tx_header_common, MAC_FRAME_CTRL2_FLAG_FROM_DS);

	if(wlan_addr_eq(bcast_addr, eth_dest)){
		if(queue_num_queued(0) < max_queue_size){
			setup_tx_queue ( tx_queue, NULL, tx_length, 0, 0 );

			enqueue_after_end(0, tx_queue_list);
			check_tx_queue();
		} else {
			return 0;
		}

	} else {
		//Check associations
		//Is this packet meant for a station we are associated with?
		for(i=0; i < next_free_assoc_index; i++) {
			if(wlan_addr_eq(associations[i].addr, eth_dest)) {
				is_associated = 1;
				break;
			}
		}
		if(is_associated) {
			if(queue_num_queued(associations[i].AID) < max_queue_size){
				setup_tx_queue ( tx_queue, (void*)&(associations[i]), tx_length, MAX_RETRY,
								 (TX_MPDU_FLAGS_FILL_DURATION | TX_MPDU_FLAGS_REQ_TO) );

				enqueue_after_end(associations[i].AID, tx_queue_list);
				check_tx_queue();
			} else {
				return 0;
			}
		} else {
			//Checkin this packet_bd so that it can be checked out again
			return 0;
		}
	}

	return 1;

}

void mpdu_transmit_done_ap(tx_frame_info* tx_mpdu){
	u32 i;
	tx_event* tx_event_log_entry;

	void * mpdu = (void*)tx_mpdu + PHY_TX_PKT_BUF_MPDU_OFFSET;
	u8* mpdu_ptr_u8 = (u8*)mpdu;
	mac_header_80211* tx_80211_header;
	tx_80211_header = (mac_header_80211*)((void *)mpdu_ptr_u8);

	tx_event_log_entry = get_next_empty_tx_event();

	if(tx_event_log_entry != NULL){
		tx_event_log_entry->state                    = tx_mpdu->state_verbose;
		tx_event_log_entry->AID                      = 0;
		tx_event_log_entry->power                    = 0; //TODO
		tx_event_log_entry->length                   = tx_mpdu->length;
		tx_event_log_entry->rate                     = tx_mpdu->rate;
		tx_event_log_entry->mac_type                 = tx_80211_header->frame_control_1;
		tx_event_log_entry->seq                      = ((tx_80211_header->sequence_control)>>4)&0xFFF;
		tx_event_log_entry->retry_count              = tx_mpdu->retry_count;
		tx_event_log_entry->tx_mpdu_accept_timestamp = tx_mpdu->tx_mpdu_accept_timestamp;
		tx_event_log_entry->tx_mpdu_done_timestamp   = tx_mpdu->tx_mpdu_done_timestamp;
	}


	if(tx_mpdu->AID != 0){
		for(i=0; i<next_free_assoc_index; i++){
			if( (associations[i].AID) == (tx_mpdu->AID) ) {

				if(tx_event_log_entry != NULL) tx_event_log_entry->AID = associations[i].AID;

				//Process this TX MPDU DONE event to update any statistics used in rate adaptation
				wlan_mac_util_process_tx_done(tx_mpdu, &(associations[i]));
				break;
			}
		}
	}
}

void mpdu_rx_process_ap(void* pkt_buf_addr, u8 rate, u16 length) {
	void * mpdu = pkt_buf_addr + PHY_RX_PKT_BUF_MPDU_OFFSET;
	u8* mpdu_ptr_u8 = (u8*)mpdu;
	u16 tx_length;
	u8 send_response, allow_association, allow_disassociation, new_association;
	mac_header_80211* rx_80211_header;
	rx_80211_header = (mac_header_80211*)((void *)mpdu_ptr_u8);
	u16 rx_seq;
	packet_bd_list checkout;
	packet_bd*	tx_queue;
	station_info* associated_station;
	u8 eth_send;

	void* rx_event_log_entry;

	rx_frame_info* mpdu_info = (rx_frame_info*)pkt_buf_addr;

	u32 i;
	u8 is_associated = 0;
	new_association = 0;

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

	for(i=0; i < next_free_assoc_index; i++) {
		if(wlan_addr_eq(associations[i].addr, (rx_80211_header->address_2))) {
			is_associated = 1;
			associated_station = &(associations[i]);
			rx_seq = ((rx_80211_header->sequence_control)>>4)&0xFFF;

			if(rate != WLAN_MAC_RATE_1M){
				if(rx_event_log_entry != NULL) ((rx_ofdm_event*)rx_event_log_entry)->AID = associations[i].AID;
			} else {
				if(rx_event_log_entry != NULL) ((rx_dsss_event*)rx_event_log_entry)->AID = associations[i].AID;
			}

			//Check if duplicate
			associations[i].rx_timestamp = get_usec_timestamp();
			associations[i].last_rx_power = mpdu_info->rx_power;

			if( (associations[i].seq != 0)  && (associations[i].seq == rx_seq) ) {
				//Received seq num matched previously received seq num for this STA; ignore the MPDU and return
#ifdef WLAN_MAC_EVENTS_LOG_CHAN_EST
				if(rate != WLAN_MAC_RATE_1M) wlan_mac_cdma_finish_transfer();
#endif
				return;

			} else {
				associations[i].seq = rx_seq;
			}

			break;
		}
	}


	switch(rx_80211_header->frame_control_1) {
		case (MAC_FRAME_CTRL1_SUBTYPE_DATA): //Data Packet
			if(is_associated){
				if((rx_80211_header->frame_control_2) & MAC_FRAME_CTRL2_FLAG_TO_DS) {
					//MPDU is flagged as destined to the DS

					///TODO: TEMP
					//xil_printf("(mpdu_info->channel_est) - mpdu_info = %d:\n", (void*)(mpdu_info->channel_est) - (void*)mpdu_info);
					//for(i = 0; i < 64; i++){
						//xil_printf("%d\n", (mpdu_info->channel_est)[i]);
					//	xil_printf("%d\n", (mpdu_info->channel_est)[i]);

					//}
					//xil_printf("\n");
					///TODO: TEMP

					(associated_station->num_rx_success)++;
					(associated_station->num_rx_bytes) += mpdu_info->length;

					eth_send = 1;

					if(wlan_addr_eq(rx_80211_header->address_3,bcast_addr)){

						 	queue_checkout(&checkout,1);

						 	if(checkout.length == 1){ //There was at least 1 free queue element
						 		tx_queue = checkout.first;
						 		setup_tx_header( &tx_header_common, bcast_addr, rx_80211_header->address_2);
						 		mpdu_ptr_u8 = (u8*)((tx_packet_buffer*)(tx_queue->buf_ptr))->frame;
								tx_length = wlan_create_data_frame((void*)((tx_packet_buffer*)(tx_queue->buf_ptr))->frame, &tx_header_common, MAC_FRAME_CTRL2_FLAG_FROM_DS);
								mpdu_ptr_u8 += sizeof(mac_header_80211);
								memcpy(mpdu_ptr_u8, (void*)rx_80211_header + sizeof(mac_header_80211), mpdu_info->length - sizeof(mac_header_80211));
						 		setup_tx_queue ( tx_queue, NULL, mpdu_info->length, 0, 0 );
						 		enqueue_after_end(0, &checkout);
						 		check_tx_queue();
						 	}

					} else {
						for(i=0; i < next_free_assoc_index; i++) {
							if(wlan_addr_eq(associations[i].addr, (rx_80211_header->address_3))) {
								queue_checkout(&checkout,1);

								if(checkout.length == 1){ //There was at least 1 free queue element
									tx_queue = checkout.first;
									setup_tx_header( &tx_header_common, rx_80211_header->address_3, rx_80211_header->address_2);
									mpdu_ptr_u8 = (u8*)((tx_packet_buffer*)(tx_queue->buf_ptr))->frame;
									tx_length = wlan_create_data_frame((void*)((tx_packet_buffer*)(tx_queue->buf_ptr))->frame, &tx_header_common, MAC_FRAME_CTRL2_FLAG_FROM_DS);
									mpdu_ptr_u8 += sizeof(mac_header_80211);
									memcpy(mpdu_ptr_u8, (void*)rx_80211_header + sizeof(mac_header_80211), mpdu_info->length - sizeof(mac_header_80211));
									setup_tx_queue ( tx_queue, (void*)&(associations[i]), mpdu_info->length, MAX_RETRY,
										 				         (TX_MPDU_FLAGS_FILL_DURATION | TX_MPDU_FLAGS_REQ_TO) );

									enqueue_after_end(associations[i].AID,  &checkout);

									check_tx_queue();
									#ifndef ALLOW_ETH_TX_OF_WIRELESS_TX
									eth_send = 0;
									#endif
								}

								break;
							}
						}
					}

					if(eth_send){
						wlan_mpdu_eth_send(mpdu,length);
					}

				}
			} else {
				//TODO: Formally adopt conventions from 10.3 in 802.11-2012 for STA state transitions
				if(wlan_addr_eq(rx_80211_header->address_1, eeprom_mac_addr)){
					if((rx_80211_header->address_3[0] == 0x33) && (rx_80211_header->address_3[1] == 0x33)){
						//TODO: This is an IPv6 Multicast packet. It should get de-encapsulated and sent over the wire
					} else {
						//Received a data frame from a STA that claims to be associated with this AP but is not in the AP association table
						// Discard the MPDU and reply with a de-authentication frame to trigger re-association at the STA

						warp_printf(PL_WARNING, "Data from non-associated station: [%x %x %x %x %x %x], issuing de-authentication\n", rx_80211_header->address_2[0],rx_80211_header->address_2[1],rx_80211_header->address_2[2],rx_80211_header->address_2[3],rx_80211_header->address_2[4],rx_80211_header->address_2[5]);
						warp_printf(PL_WARNING, "Address 3: [%x %x %x %x %x %x]\n", rx_80211_header->address_3[0],rx_80211_header->address_3[1],rx_80211_header->address_3[2],rx_80211_header->address_3[3],rx_80211_header->address_3[4],rx_80211_header->address_3[5]);

						//Send De-authentication
						//Checkout 1 element from the queue;
							queue_checkout(&checkout,1);

							if(checkout.length == 1){ //There was at least 1 free queue element
								tx_queue = checkout.first;

						 		setup_tx_header( &tx_header_common, rx_80211_header->address_2, eeprom_mac_addr );

								tx_length = wlan_create_deauth_frame((void*)((tx_packet_buffer*)(tx_queue->buf_ptr))->frame, &tx_header_common, DEAUTH_REASON_NONASSOCIATED_STA);

						 		setup_tx_queue ( tx_queue, NULL, tx_length, MAX_RETRY,
						 				         (TX_MPDU_FLAGS_FILL_DURATION | TX_MPDU_FLAGS_REQ_TO) );

								enqueue_after_end(0, &checkout);
								check_tx_queue();
							}
					}
				}
			}//END if(is_associated)

		break;

		case (MAC_FRAME_CTRL1_SUBTYPE_PROBE_REQ): //Probe Request Packet
			if(wlan_addr_eq(rx_80211_header->address_3, bcast_addr)) {
				//BSS Id: Broadcast
				mpdu_ptr_u8 += sizeof(mac_header_80211);
				while(((u32)mpdu_ptr_u8 -  (u32)mpdu)<= length){ //Loop through tagged parameters
					switch(mpdu_ptr_u8[0]){ //What kind of tag is this?
						case TAG_SSID_PARAMS: //SSID parameter set
							if((mpdu_ptr_u8[1]==0) || (memcmp(mpdu_ptr_u8+2, (u8*)access_point_ssid,mpdu_ptr_u8[1])==0)) {
								//Broadcast SSID or my SSID - send unicast probe response
								send_response = 1;
							}
						break;
						case TAG_SUPPORTED_RATES: //Supported rates
						break;
						case TAG_EXT_SUPPORTED_RATES: //Extended supported rates
						break;
						case TAG_DS_PARAMS: //DS Parameter set (e.g. channel)
						break;
					}
					mpdu_ptr_u8 += mpdu_ptr_u8[1]+2; //Move up to the next tag
				}
				if(send_response && allow_assoc) {

					//Checkout 1 element from the queue;
					queue_checkout(&checkout,1);

					if(checkout.length == 1){ //There was at least 1 free queue element
						tx_queue = checkout.first;

						setup_tx_header( &tx_header_common, rx_80211_header->address_2, eeprom_mac_addr );

						tx_length = wlan_create_probe_resp_frame((void*)((tx_packet_buffer*)(tx_queue->buf_ptr))->frame, &tx_header_common, BEACON_INTERVAL_MS, strlen(access_point_ssid), (u8*)access_point_ssid, mac_param_chan);

				 		setup_tx_queue ( tx_queue, NULL, tx_length, MAX_RETRY,
				 				         (TX_MPDU_FLAGS_FILL_TIMESTAMP | TX_MPDU_FLAGS_FILL_DURATION | TX_MPDU_FLAGS_REQ_TO) );

						enqueue_after_end(0, &checkout);
						check_tx_queue();
					}
#ifdef WLAN_MAC_EVENTS_LOG_CHAN_EST
					if(rate != WLAN_MAC_RATE_1M) wlan_mac_cdma_finish_transfer();
#endif
					return;
				}
			}
		break;

		case (MAC_FRAME_CTRL1_SUBTYPE_AUTH): //Authentication Packet

			if(wlan_addr_eq(rx_80211_header->address_3, eeprom_mac_addr)) {
					mpdu_ptr_u8 += sizeof(mac_header_80211);
					switch(((authentication_frame*)mpdu_ptr_u8)->auth_algorithm){
						case AUTH_ALGO_OPEN_SYSTEM:
							if(((authentication_frame*)mpdu_ptr_u8)->auth_sequence == AUTH_SEQ_REQ){//This is an auth packet from a requester
								//Checkout 1 element from the queue;
								queue_checkout(&checkout,1);

								if(checkout.length == 1){ //There was at least 1 free queue element
									tx_queue = checkout.first;

							 		setup_tx_header( &tx_header_common, rx_80211_header->address_2, eeprom_mac_addr );

									tx_length = wlan_create_auth_frame((void*)((tx_packet_buffer*)(tx_queue->buf_ptr))->frame, &tx_header_common, AUTH_ALGO_OPEN_SYSTEM, AUTH_SEQ_RESP, STATUS_SUCCESS);

							 		setup_tx_queue ( tx_queue, NULL, tx_length, MAX_RETRY,
							 				         (TX_MPDU_FLAGS_FILL_DURATION | TX_MPDU_FLAGS_REQ_TO) );

									enqueue_after_end(0, &checkout);
									check_tx_queue();
								}
#ifdef WLAN_MAC_EVENTS_LOG_CHAN_EST
								if(rate != WLAN_MAC_RATE_1M) wlan_mac_cdma_finish_transfer();
#endif
								return;
							}
						break;
						default:

							//Checkout 1 element from the queue;
							queue_checkout(&checkout,1);

							if(checkout.length == 1){ //There was at least 1 free queue element
								tx_queue = checkout.first;

						 		setup_tx_header( &tx_header_common, rx_80211_header->address_2, eeprom_mac_addr );

								tx_length = wlan_create_auth_frame((void*)((tx_packet_buffer*)(tx_queue->buf_ptr))->frame, &tx_header_common, AUTH_ALGO_OPEN_SYSTEM, AUTH_SEQ_RESP, STATUS_AUTH_REJECT_CHALLENGE_FAILURE);

						 		setup_tx_queue ( tx_queue, NULL, tx_length, MAX_RETRY,
						 				         (TX_MPDU_FLAGS_FILL_DURATION | TX_MPDU_FLAGS_REQ_TO) );

								enqueue_after_end(0, &checkout);
								check_tx_queue();
							}

							warp_printf(PL_WARNING,"Unsupported authentication algorithm (0x%x)\n", ((authentication_frame*)mpdu_ptr_u8)->auth_algorithm);
							#ifdef WLAN_MAC_EVENTS_LOG_CHAN_EST
								if(rate != WLAN_MAC_RATE_1M) wlan_mac_cdma_finish_transfer();
							#endif
							return;
						break;
					}
				}
		break;

		case (MAC_FRAME_CTRL1_SUBTYPE_REASSOC_REQ): //Re-association Request
		case (MAC_FRAME_CTRL1_SUBTYPE_ASSOC_REQ): //Association Request
			if(wlan_addr_eq(rx_80211_header->address_3, eeprom_mac_addr)) {
				for(i=0; i <= next_free_assoc_index; i++) {
					if(wlan_addr_eq((associations[i].addr), bcast_addr)) {
						allow_association = 1;
						new_association = 1;

						if(next_free_assoc_index < (MAX_ASSOCIATIONS-2)) {
							next_free_assoc_index++;
							max_queue_size = min((queue_total_size()- eth_bd_total_size()) / (next_free_assoc_index+1),MAX_PER_FLOW_QUEUE);
						}
						break;

					} else if(wlan_addr_eq((associations[i].addr), rx_80211_header->address_2)) {
						allow_association = 1;
						new_association = 0;
						break;
					}
				}

				if(allow_association) {
					//Keep track of this association of this association
					memcpy(&(associations[i].addr[0]), rx_80211_header->address_2, 6);
					associations[i].tx_rate = default_unicast_rate; //Default tx_rate for this station. Rate adaptation may change this value.
					associations[i].num_tx_total = 0;
					associations[i].num_tx_success = 0;
					associations[i].num_retry = 0;

					//associations[i].tx_rate = WLAN_MAC_RATE_16QAM34; //Default tx_rate for this station. Rate adaptation may change this value.

					//Checkout 1 element from the queue;
					queue_checkout(&checkout,1);

					if(checkout.length == 1){ //There was at least 1 free queue element
						tx_queue = checkout.first;

				 		setup_tx_header( &tx_header_common, rx_80211_header->address_2, eeprom_mac_addr );

						tx_length = wlan_create_association_response_frame((void*)((tx_packet_buffer*)(tx_queue->buf_ptr))->frame, &tx_header_common, STATUS_SUCCESS, associations[i].AID);

				 		setup_tx_queue ( tx_queue, (void*)&(associations[i]), tx_length, MAX_RETRY,
				 				         (TX_MPDU_FLAGS_FILL_DURATION | TX_MPDU_FLAGS_REQ_TO) );

						enqueue_after_end(associations[i].AID, &checkout);
						check_tx_queue();
					}

					if(new_association == 1) {
						xil_printf("\n\nNew Association - ID %d\n", associations[i].AID);

						//Print the updated association table to the UART (slow, but useful for observing association success)
						print_associations();
					}
#ifdef WLAN_MAC_EVENTS_LOG_CHAN_EST
						if(rate != WLAN_MAC_RATE_1M) wlan_mac_cdma_finish_transfer();
#endif
					return;
				}

			}
		break;

		case (MAC_FRAME_CTRL1_SUBTYPE_DISASSOC): //Disassociation
				if(wlan_addr_eq(rx_80211_header->address_3, eeprom_mac_addr)) {
					for(i=0;i<next_free_assoc_index;i++){
						if(wlan_addr_eq(associations[i].addr, rx_80211_header->address_2)) {
								allow_disassociation = 1;
							break;
						}
					}

					if(allow_disassociation) {
						remove_station( i );
						xil_printf("\n\nDisassociation:\n");
						print_associations();
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

void bad_fcs_rx_process_ap(void* pkt_buf_addr, u8 rate, u16 length) {
	bad_fcs_event* bad_fcs_event_log_entry = get_next_empty_bad_fcs_event();
	bad_fcs_event_log_entry->length = length;
	bad_fcs_event_log_entry->rate = rate;
}

void check_tx_queue_ap(){

	static u32 station_index = 0;
	u32 i;
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

void ltg_event_ap(u32 id, void* callback_arg){
	u32 i;
	packet_bd_list checkout;
	packet_bd* tx_queue;
	u32 tx_length;
	u32 payload_length = 0;
	u8* mpdu_ptr_u8;
	llc_header* llc_hdr;

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

	for(i=0; i < next_free_assoc_index; i++){
		if((u32)(associations[i].AID) == LTG_ID_TO_AID(id)){
			//The AID <-> LTG ID connection is arbitrary. In this design, we use the LTG_ID_TO_AID
			//macro to map multiple different LTG IDs onto an AID for a specific station. This allows
			//multiple LTG flows to target a single user in the network.

			//We implement a soft limit on the size of the queue allowed for any
			//given station. This avoids the scenario where multiple backlogged
			//LTG flows favor a single user and starve everyone else.
			if(queue_num_queued(associations[i].AID) < max_queue_size){
				//Send a Data packet to this station
				//Checkout 1 element from the queue;
				queue_checkout(&checkout,1);

				if(checkout.length == 1){ //There was at least 1 free queue element
					tx_queue = checkout.first;

					setup_tx_header( &tx_header_common, associations[i].addr, eeprom_mac_addr );

					mpdu_ptr_u8 = (u8*)((tx_packet_buffer*)(tx_queue->buf_ptr))->frame;
					tx_length = wlan_create_data_frame((void*)((tx_packet_buffer*)(tx_queue->buf_ptr))->frame, &tx_header_common, MAC_FRAME_CTRL2_FLAG_FROM_DS);

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

					setup_tx_queue ( tx_queue, (void*)&(associations[i]), tx_length, MAX_RETRY,
									 (TX_MPDU_FLAGS_FILL_DURATION | TX_MPDU_FLAGS_REQ_TO) );

					enqueue_after_end(associations[i].AID, &checkout);
					check_tx_queue();
				}
			}
		}
	}
}

void deauthenticate_stations(){
	u32 i;

	// Start at the back of the list and deauthenticate the stations so there
	//   are not unnecessary copies when compacting the assocation table.
	//
	for( i = next_free_assoc_index; i > 0; i--) {
		deauthenticate_station( i );
	}
}

u32  deauthenticate_station( u32 association_index ) {

	packet_bd_list checkout;
	packet_bd*     tx_queue;
	u32            tx_length;
	u32            aid;

	if ( association_index > next_free_assoc_index ) {
		return -1;
	}

	// Get the AID
	aid = associations[association_index].AID;

	// Checkout 1 element from the queue
	queue_checkout(&checkout,1);

	if(checkout.length == 1){ //There was at least 1 free queue element
		tx_queue = checkout.first;

		purge_queue(aid);

		// Create deauthentication packet
		setup_tx_header( &tx_header_common, associations[association_index].addr, eeprom_mac_addr );

		tx_length = wlan_create_deauth_frame((void*)((tx_packet_buffer*)(tx_queue->buf_ptr))->frame, &tx_header_common, DEAUTH_REASON_INACTIVITY);

		setup_tx_queue ( tx_queue, (void*)&(associations[association_index]), tx_length, MAX_RETRY,
						 (TX_MPDU_FLAGS_FILL_DURATION | TX_MPDU_FLAGS_REQ_TO) );

		//
		enqueue_after_end(aid, &checkout);
		check_tx_queue();

		// Remove this STA from association list
		remove_station(association_index);
	}

	write_hex_display(next_free_assoc_index);

	return aid;
}
