////////////////////////////////////////////////////////////////////////////////
// File   : wlan_mac_sta_uart_menu.c
// Authors: Patrick Murphy (murphpo [at] mangocomm.com)
//			Chris Hunter (chunter [at] mangocomm.com)
// License: Copyright 2013, Mango Communications. All rights reserved.
//          Distributed under the Mango Communications Reference Design License
//				See LICENSE.txt included in the design archive or
//				at http://mangocomm.com/802.11/license
////////////////////////////////////////////////////////////////////////////////

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
#include "wlan_mac_misc_util.h"
#include "wlan_mac_802_11_defs.h"
#include "wlan_mac_queue.h"
#include "wlan_mac_ltg.h"
#include "wlan_mac_util.h"
#include "wlan_mac_packet_types.h"
#include "wlan_mac_eth_util.h"
#include "ascii_characters.h"

/* WMP_START */
#include "wmp_high.h"
#include "wmp_high_util.h"
#include "wlan_mac_ipc.h"
#include "wmp_high_ap.h"
/* WMP_END */


#ifdef WLAN_USE_UART_MENU


// SSID variables
extern char*  access_point_ssid;

// Control variables
extern u8  default_unicast_rate;
extern int association_state;                      // Section 10.3 of 802.11-2012
extern u8  uart_mode;
extern u8  active_scan;

// Access point information
extern ap_info* ap_list;
extern u8       num_ap_list;

extern u8       access_point_num_basic_rates;
extern u8       access_point_basic_rates[NUM_BASIC_RATES_MAX];

extern u8 pause_queue;

/* WMP_START */
extern u8 modeofoperation;
/* WMP_END */


// Association Table variables
//   The last entry in associations[MAX_ASSOCIATIONS][] is swap space
extern station_info access_point;

// AP channel
extern u32 mac_param_chan;
extern u32 mac_param_chan_save;

// LTG variables
static u8 curr_traffic_type;
#define TRAFFIC_TYPE_PERIODIC_FIXED		1
#define TRAFFIC_TYPE_PERIODIC_RAND		2
#define TRAFFIC_TYPE_RAND_FIXED			3
#define TRAFFIC_TYPE_RAND_RAND			4

u32 num_slots = SLOT_CONFIG_RAND;

void uart_rx(u8 rxByte){
	/* WMP_START */
	u32 i;
	u32 tmp_chan;
	/* WMP_END */
	#define MAX_NUM_AP_CHARS 4
	static char numerical_entry[MAX_NUM_AP_CHARS+1];
	static u8 curr_decade = 0;

	#define MAX_NUM_CHARS 31
	static char text_entry[MAX_NUM_CHARS+1];
	static u8 curr_char = 0;

	u16 ap_sel;
	wlan_ipc_msg ipc_msg_to_low;
	u32 ipc_msg_to_low_payload[1];
	ipc_config_rf_ifc* config_rf_ifc;

	void* ltg_sched_state;
	u32 ltg_type;

	void* ltg_callback_arg;
	ltg_sched_periodic_params periodic_params;
	ltg_sched_uniform_rand_params rand_params;

	if(rxByte == ASCII_ESC){
		uart_mode = UART_MODE_MAIN;
		print_menu();

		ltg_sched_remove(LTG_REMOVE_ALL);

		return;
	}

	switch(uart_mode){
		case UART_MODE_MAIN:
			switch(rxByte){
				case ASCII_1:
					uart_mode = UART_MODE_INTERACTIVE;
					print_station_status(1);
				break;

				case ASCII_a:

					if (modeofoperation == MODEOFOPERATION_AP) {
						print_menu();
						xil_printf("\n\nScan is disabled in AP mode\n");
						break;
					}

					//Send bcast probe requests across all channels
					if(active_scan ==0){
						num_ap_list = 0;
						//xil_printf("- Free 0x%08x\n",ap_list);
						wlan_free(ap_list);
						ap_list = NULL;
						active_scan = 1;
						access_point_ssid = wlan_realloc(access_point_ssid, 1);
						*access_point_ssid = 0;
						//xil_printf("+++ starting active scan\n");
						pause_queue = 1;
						mac_param_chan_save = mac_param_chan;
						probe_req_transmit();
					}
				break;

				/* WMP_START */
				case ASCII_c:
					uart_mode = UART_MODE_CHAN_CHANGE;
					curr_char = 0;
					print_chan_menu();

				break;

				case ASCII_b:
					if (modeofoperation == MODEOFOPERATION_STA) {
						print_menu();
						xil_printf("\n\nBeacon inteval change not supported in STA mode\n");
						break;
					}
					uart_mode = UART_MODE_BEACON_TU_CHANGE;
					curr_char = 0;
					print_beacon_tu_menu();

				break;

				case ASCII_s:
					if (modeofoperation == MODEOFOPERATION_STA) {
						print_menu();
						xil_printf("\n\nSSID change not supported in STA mode\n");
						break;
					}
					uart_mode = UART_MODE_SSID_CHANGE;
					curr_char = 0;
					print_ssid_menu();
				break;
				/* WMP_END */

				case ASCII_r:
					if(default_unicast_rate > WLAN_MAC_RATE_6M){
						default_unicast_rate--;
					} else {
						default_unicast_rate = WLAN_MAC_RATE_6M;
					}

					for(i=0; i < next_free_assoc_index; i++){
						associations[i].tx_rate = default_unicast_rate;
					}

					access_point.tx_rate = default_unicast_rate;


					xil_printf("(-) Default Unicast Rate: %d Mbps\n", wlan_lib_mac_rate_to_mbps(default_unicast_rate));
				break;
				case ASCII_R:
					if(default_unicast_rate < WLAN_MAC_RATE_54M){
						default_unicast_rate++;
					} else {
						default_unicast_rate = WLAN_MAC_RATE_54M;
					}

					access_point.tx_rate = default_unicast_rate;

					for(i=0; i < next_free_assoc_index; i++){
						associations[i].tx_rate = default_unicast_rate;
					}

					xil_printf("(+) Default Unicast Rate: %d Mbps\n", wlan_lib_mac_rate_to_mbps(default_unicast_rate));
				break;
				case ASCII_n:
					if(num_slots == 0 || num_slots == SLOT_CONFIG_RAND){
						num_slots = SLOT_CONFIG_RAND;
						xil_printf("num_slots = SLOT_CONFIG_RAND\n");
					} else {
						num_slots--;
						xil_printf("num_slots = %d\n", num_slots);
					}


					set_backoff_slot_value(num_slots);
				break;

				case ASCII_N:
					if(num_slots == SLOT_CONFIG_RAND){
						num_slots = 0;
					} else {
						num_slots++;
					}

					xil_printf("num_slots = %d\n", num_slots);

					set_backoff_slot_value(num_slots);
				break;

				/* WMP_START */
				case ASCII_m:
					uart_mode = UART_MODE_MODECHOICE;
					print_modechoice_menu();
				break;
				/* WMP_END */
			}
		break;

		/* WMP_START */
		case UART_MODE_MODECHOICE:
			switch(rxByte){
			case ASCII_0:
				if (modeofoperation == MODEOFOPERATION_STA) {
					uart_mode = UART_MODE_MAIN;
					print_menu();
					break;
				}
				modeofoperation = MODEOFOPERATION_STA;
				ipc_msg_to_low.msg_id = IPC_MBOX_MSG_ID(IPC_MBOX_MODE);
				ipc_msg_to_low.num_payload_words = 0;
				ipc_msg_to_low.arg0 = modeofoperation;
				ipc_mailbox_write_msg(&ipc_msg_to_low);
				wlan_mac_util_set_eth_encap_mode(ENCAP_MODE_STA);
				access_point_ssid = wlan_realloc(access_point_ssid, strlen(default_AP_SSID)+1);
				strcpy(access_point_ssid,default_AP_SSID);

				deauthenticate_stations();

				wlan_mac_util_set_eth_rx_callback(       (void*)ethernet_receive);
				wlan_mac_util_set_mpdu_tx_done_callback( (void*)mpdu_transmit_done);
				wlan_mac_util_set_mpdu_rx_callback(      (void*)mpdu_rx_process);
				wlan_mac_util_set_ipc_rx_callback(       (void*)ipc_rx);
				wlan_mac_util_set_check_queue_callback(  (void*)check_tx_queue);

				wlan_mac_util_set_fcs_bad_rx_callback(   (void*)bad_fcs_rx_process);
				wlan_mac_util_set_uart_rx_callback(      (void*)uart_rx);
				wlan_mac_ltg_sched_set_callback(         (void*)ltg_event);
				max_queue_size = MAX_PER_FLOW_QUEUE;
				write_hex_display(0);
				uart_mode = UART_MODE_MAIN;
				print_menu();
				xil_printf("\nSet mode: STA\n");
			break;
			case ASCII_1:
				if (modeofoperation == MODEOFOPERATION_AP) {
					uart_mode = UART_MODE_MAIN;
					print_menu();
					break;
				}
				modeofoperation = MODEOFOPERATION_AP;
				ipc_msg_to_low.msg_id = IPC_MBOX_MSG_ID(IPC_MBOX_MODE);
				ipc_msg_to_low.num_payload_words = 0;
				ipc_msg_to_low.arg0 = modeofoperation;
				ipc_mailbox_write_msg(&ipc_msg_to_low);
				wlan_mac_util_set_eth_encap_mode(ENCAP_MODE_AP);
				bzero(&(associations[0]), sizeof(station_info)*(MAX_ASSOCIATIONS+1));

				for(i = 0; i < MAX_ASSOCIATIONS; i++){
					associations[i].AID = (1+i); //7.3.1.8 of 802.11-2007
					memset((void*)(&(associations[i].addr[0])), 0xFF,6);
					associations[i].seq = 0; //seq
				}
				max_queue_size = min((queue_total_size()- eth_bd_total_size()) / (next_free_assoc_index+1),MAX_PER_FLOW_QUEUE);
				if (strlen(last_access_point_ssid) > 0) {
					access_point_ssid = wlan_realloc(access_point_ssid, strlen(last_access_point_ssid)+1);
					strcpy(access_point_ssid, last_access_point_ssid);
				} else {
					access_point_ssid = wlan_realloc(access_point_ssid, strlen(apmode_default_ssid)+1);
					strcpy(access_point_ssid, apmode_default_ssid);
				}
				// TODO: Deauthentication
				// TODO: Disassociation
				wlan_mac_util_set_eth_rx_callback(       (void*)ethernet_receive_ap);
				wlan_mac_util_set_mpdu_tx_done_callback( (void*)mpdu_transmit_done_ap);
				wlan_mac_util_set_mpdu_rx_callback(      (void*)mpdu_rx_process_ap);
				wlan_mac_util_set_ipc_rx_callback(       (void*)ipc_rx);
				wlan_mac_util_set_check_queue_callback(  (void*)check_tx_queue_ap);

				wlan_mac_util_set_fcs_bad_rx_callback(   (void*)bad_fcs_rx_process_ap);
				wlan_mac_util_set_uart_rx_callback(      (void*)uart_rx);
				wlan_mac_ltg_sched_set_callback(         (void*)ltg_event_ap);
				wmp_high_util_update_beacon_template();
				memset(&access_point, 0,sizeof(station_info));
				association_state = -1;
				write_hex_display(0);
				uart_mode = UART_MODE_MAIN;
				print_menu();
				xil_printf("\nSet mode: AP\n");
			break;
			case ASCII_ESC:
				uart_mode = UART_MODE_MAIN;
				print_menu();
			break;
			default:
				print_modechoice_menu();
			break;
			}
		break;

		case UART_MODE_CHAN_CHANGE:
			switch(rxByte){
				case ASCII_ESC:
					uart_mode = UART_MODE_MAIN;
					curr_char = 0;
					print_menu();
				break;

				case ASCII_CR:
					text_entry[curr_char] = 0;
					curr_char = 0;
					uart_mode = UART_MODE_MAIN;

					tmp_chan = atoi(text_entry);

					if ((tmp_chan != mac_param_chan) ||
							((tmp_chan >= 1) && (tmp_chan <= 14))) {
						mac_param_chan = tmp_chan;
						set_mac_channel( mac_param_chan );
						print_menu();
						xil_printf("\nSetting new channel: %d\n", mac_param_chan);
					} else {
						print_menu();
						xil_printf("\nStay on channel: %d\n", mac_param_chan);
					}
				break;

				case ASCII_DEL:
					if(curr_char > 0){
						curr_char--;
						xil_printf("\b \b");
					}

				break;
				default:
					if( (rxByte >= ASCII_0) && (rxByte <= ASCII_9) ){
						//the user entered a character

						if(curr_char < MAX_NUM_CHARS){
							xil_printf("%c", rxByte);
							text_entry[curr_char] = rxByte;
							curr_char++;
						}
					}
				break;
			}
		break;

		case UART_MODE_BEACON_TU_CHANGE:
		switch(rxByte){
			case ASCII_ESC:
				uart_mode = UART_MODE_MAIN;
				curr_char = 0;
				print_menu();
			break;

			case ASCII_CR:
				text_entry[curr_char] = 0;
				curr_char = 0;
				uart_mode = UART_MODE_MAIN;

				beacon_interval = atoi(text_entry);
				wmp_high_util_update_beacon_template();

				print_menu();
				xil_printf("\nSetting new beacon interval: %d\n", beacon_interval);

			break;

			case ASCII_DEL:
				if(curr_char > 0){
					curr_char--;
					xil_printf("\b \b");
				}

			break;
			default:
				if( (rxByte >= ASCII_0) && (rxByte <= ASCII_9) ){
					//the user entered a character

					if(curr_char < MAX_NUM_CHARS){
						xil_printf("%c", rxByte);
						text_entry[curr_char] = rxByte;
						curr_char++;
					}
				}
			break;
		}
		break;

		case UART_MODE_SSID_CHANGE:
		switch(rxByte){
			case ASCII_ESC:
				uart_mode = UART_MODE_MAIN;
				curr_char = 0;
				print_menu();
			break;

			case ASCII_CR:
				text_entry[curr_char] = 0;
				curr_char = 0;
				uart_mode = UART_MODE_MAIN;

				if (memcmp(access_point_ssid, text_entry, strlen(access_point_ssid))) {
					access_point_ssid = wlan_realloc(access_point_ssid, strlen(text_entry)+1);
					strcpy(access_point_ssid,text_entry);
					deauthenticate_stations();
					wmp_high_util_update_beacon_template();
					print_menu();
					xil_printf("\nSetting new SSID: %s\n", access_point_ssid);
				} else {
					print_menu();
					xil_printf("\nStay with SSID: %s\n", access_point_ssid);
				}

			break;

			case ASCII_DEL:
				if(curr_char > 0){
					curr_char--;
					xil_printf("\b \b");
				}

			break;
			default:
				if(  (rxByte <= ASCII_z) && (rxByte >= ASCII_A) ){
					//the user entered a character

					if(curr_char < MAX_NUM_CHARS){
						xil_printf("%c", rxByte);
						text_entry[curr_char] = rxByte;
						curr_char++;
					}
				}
			break;
		}
		break;
		/* WMP_END */

		case UART_MODE_INTERACTIVE:
			switch(rxByte){
				case ASCII_r:
					//Reset statistics
					reset_station_statistics();
				break;
				case ASCII_1:
					if(access_point.AID != 0){
						uart_mode = UART_MODE_LTG_SIZE_CHANGE;
						curr_char = 0;
						curr_traffic_type = TRAFFIC_TYPE_PERIODIC_FIXED;

						if(ltg_sched_get_state(0,&ltg_type,&ltg_sched_state) == 0){
							//A scheduler of ID = 0 has been previously configured
							if(((ltg_sched_state_hdr*)ltg_sched_state)->enabled == 1){
								//This LTG is currently running. We'll turn it off.
								ltg_sched_stop(0);
								uart_mode = UART_MODE_INTERACTIVE;
								print_station_status(1);
								return;
							}
						}
						xil_printf("\n\n Configuring Local Traffic Generator (LTG) for AP\n");
						xil_printf("\nEnter packet payload size (in bytes): ");
					}
				break;
				case ASCII_Q:
					if(access_point.AID != 0){
						uart_mode = UART_MODE_LTG_SIZE_CHANGE;
						curr_char = 0;
						curr_traffic_type = TRAFFIC_TYPE_RAND_RAND;

						if(ltg_sched_get_state(0,&ltg_type,&ltg_sched_state) == 0){
							//A scheduler of ID = 0 has been previously configured
							if(((ltg_sched_state_hdr*)ltg_sched_state)->enabled == 1){
								//This LTG is currently running. We'll turn it off.
								ltg_sched_stop(0);
								uart_mode = UART_MODE_INTERACTIVE;
								print_station_status(1);
								return;
							}
						}
						xil_printf("\n\n Configuring Random Local Traffic Generator (LTG) for AP\n");
						xil_printf("\nEnter maximum payload size (in bytes): ");
					}
				break;
			}
		break;
		case UART_MODE_LTG_SIZE_CHANGE:
			switch(rxByte){
				case ASCII_CR:
					text_entry[curr_char] = 0;
					curr_char = 0;

					if(ltg_sched_get_callback_arg(0,&ltg_callback_arg) == 0){
						//This LTG has already been configured. We need to free the old callback argument so we can create a new one.
						ltg_sched_stop(0);
						wlan_free(ltg_callback_arg);
					}
					switch(curr_traffic_type){
							case TRAFFIC_TYPE_PERIODIC_FIXED:
								ltg_callback_arg = wlan_malloc(sizeof(ltg_pyld_fixed));
								if(ltg_callback_arg != NULL){
									((ltg_pyld_fixed*)ltg_callback_arg)->hdr.type = LTG_PYLD_TYPE_FIXED;
									((ltg_pyld_fixed*)ltg_callback_arg)->length = str2num(text_entry);

									//Note: This call to configure is incomplete. At this stage in the uart menu, the periodic_params argument hasn't been updated. This is
									//simply an artifact of the sequential nature of UART entry. We won't start the scheduler until we call configure again with that updated
									//entry.
									ltg_sched_configure(0, LTG_SCHED_TYPE_PERIODIC, &periodic_params, ltg_callback_arg, &ltg_cleanup);

									uart_mode = UART_MODE_LTG_INTERVAL_CHANGE;
									xil_printf("\nEnter packet Tx interval (in microseconds): ");
								} else {
									xil_printf("Error allocating memory for ltg_callback_arg\n");
									uart_mode = UART_MODE_INTERACTIVE;
									print_station_status(1);
								}

							break;
							case TRAFFIC_TYPE_RAND_RAND:
								ltg_callback_arg = wlan_malloc(sizeof(ltg_pyld_uniform_rand));
								if(ltg_callback_arg != NULL){
									((ltg_pyld_uniform_rand*)ltg_callback_arg)->hdr.type = LTG_PYLD_TYPE_UNIFORM_RAND;
									((ltg_pyld_uniform_rand*)ltg_callback_arg)->min_length = 0;
									((ltg_pyld_uniform_rand*)ltg_callback_arg)->max_length = str2num(text_entry);

									//Note: This call to configure is incomplete. At this stage in the uart menu, the periodic_params argument hasn't been updated. This is
									//simply an artifact of the sequential nature of UART entry. We won't start the scheduler until we call configure again with that updated
									//entry.
									ltg_sched_configure(0, LTG_SCHED_TYPE_UNIFORM_RAND, &rand_params, ltg_callback_arg, &ltg_cleanup);

									uart_mode = UART_MODE_LTG_INTERVAL_CHANGE;
									xil_printf("\nEnter maximum packet Tx interval (in microseconds): ");
								} else {
									xil_printf("Error allocating memory for ltg_callback_arg\n");
									uart_mode = UART_MODE_INTERACTIVE;
									print_station_status(1);
								}

							break;
						}

				break;
				case ASCII_DEL:
					if(curr_char > 0){
						curr_char--;
						xil_printf("\b \b");
					}
				break;
				default:
					if( (rxByte <= ASCII_9) && (rxByte >= ASCII_0) ){
						//the user entered a character
						if(curr_char < MAX_NUM_CHARS){
							xil_printf("%c", rxByte);
							text_entry[curr_char] = rxByte;
							curr_char++;
						}
					}
				break;
			}
		break;
		case UART_MODE_LTG_INTERVAL_CHANGE:
			switch(rxByte){
				case ASCII_CR:
					text_entry[curr_char] = 0;
					curr_char = 0;

					if(ltg_sched_get_callback_arg(0,&ltg_callback_arg) != 0){
						xil_printf("Error: expected to find an already configured LTG ID %d\n", 0);
						return;
					}

					switch(curr_traffic_type){
						case TRAFFIC_TYPE_PERIODIC_FIXED:
							if(ltg_callback_arg != NULL){
								periodic_params.interval_usec = str2num(text_entry);
								ltg_sched_configure(0, LTG_SCHED_TYPE_PERIODIC, &periodic_params, ltg_callback_arg, &ltg_cleanup);
								ltg_sched_start(0);
							} else {
								xil_printf("Error: ltg_callback_arg was NULL\n");
							}

						break;
						case TRAFFIC_TYPE_RAND_RAND:
							if(ltg_callback_arg != NULL){
								rand_params.min_interval = 0;
								rand_params.max_interval = str2num(text_entry);
								ltg_sched_configure(0, LTG_SCHED_TYPE_UNIFORM_RAND, &rand_params, ltg_callback_arg, &ltg_cleanup);
								ltg_sched_start(0);
							} else {
								xil_printf("Error: ltg_callback_arg was NULL\n");
							}

						break;
					}
					uart_mode = UART_MODE_INTERACTIVE;
					print_station_status(1);

				break;
				case ASCII_DEL:
					if(curr_char > 0){
						curr_char--;
						xil_printf("\b \b");
					}
				break;
				default:
					if( (rxByte <= ASCII_9) && (rxByte >= ASCII_0) ){
						//the user entered a character
						if(curr_char < MAX_NUM_CHARS){
							xil_printf("%c", rxByte);
							text_entry[curr_char] = rxByte;
							curr_char++;
						}
					}
				break;
			}
		break;
		case UART_MODE_AP_LIST:
			switch(rxByte){
				case ASCII_CR:

					numerical_entry[curr_decade] = 0;
					curr_decade = 0;

					ap_sel = str2num(numerical_entry);

					if( (ap_sel >= 0) && (ap_sel <= (num_ap_list-1))){

						if( ap_list[ap_sel].private == 0) {
							uart_mode = UART_MODE_MAIN;
							mac_param_chan = ap_list[ap_sel].chan;

							//Send a message to other processor to tell it to switch channels
							ipc_msg_to_low.msg_id = IPC_MBOX_MSG_ID(IPC_MBOX_CONFIG_RF_IFC);
							ipc_msg_to_low.num_payload_words = sizeof(ipc_config_rf_ifc)/sizeof(u32);
							ipc_msg_to_low.payload_ptr = &(ipc_msg_to_low_payload[0]);
							init_ipc_config(config_rf_ifc,ipc_msg_to_low_payload,ipc_config_rf_ifc);
							config_rf_ifc->channel = mac_param_chan;
							ipc_mailbox_write_msg(&ipc_msg_to_low);


							xil_printf("\nAttempting to join %s\n", ap_list[ap_sel].ssid);
							memcpy(access_point.addr, ap_list[ap_sel].bssid, 6);

							access_point_ssid = wlan_realloc(access_point_ssid, strlen(ap_list[ap_sel].ssid)+1);
							//xil_printf("allocated %d bytes in 0x%08x\n", strlen(ap_list[ap_sel].ssid), access_point_ssid);
							strcpy(access_point_ssid,ap_list[ap_sel].ssid);

							access_point_num_basic_rates = ap_list[ap_sel].num_basic_rates;
							memcpy(access_point_basic_rates, ap_list[ap_sel].basic_rates,access_point_num_basic_rates);

							association_state = 1;
							attempt_authentication();

						} else {
							xil_printf("\nInvalid selection, please choose an AP that is not private: ");
						}


					} else {

						xil_printf("\nInvalid selection, please choose a number between [0,%d]: ", num_ap_list-1);

					}



				break;
				case ASCII_DEL:
					if(curr_decade > 0){
						curr_decade--;
						xil_printf("\b \b");
					}

				break;
				default:
					if( (rxByte <= ASCII_9) && (rxByte >= ASCII_0) ){
						//the user entered a character

						if(curr_decade < MAX_NUM_AP_CHARS){
							xil_printf("%c", rxByte);
							numerical_entry[curr_decade] = rxByte;
							curr_decade++;
						}



					}

				break;

			}
		break;

	}


}

void print_ltg_interval_menu(){

	xil_printf("\nEnter packet Tx interval (in microseconds): ");

}


void print_menu(){
	xil_printf("\f");
	xil_printf("********************** Station Menu **********************\n");
	xil_printf("[1]   - Interactive Station Status\n");
	xil_printf("\n");
	xil_printf("[a]   - active scan and display nearby APs (only for STA mode)\n");
	xil_printf("[b]   - change beacon interval TU (only for AP mode)\n");
	xil_printf("[c]   - change channel (note: changing channel will\n");
	xil_printf("        purge any associations, forcing stations to\n");
	xil_printf("        join the network again)\n");
	xil_printf("        Channel switch request will be satisfied only\n");
	xil_printf("        if the running XFSM handles the event SWITCH_CHAN_REQ\n");
	xil_printf("[r/R] - change default unicast rate\n");
	/* WMP_START */
	xil_printf("[m]   - choose operation mode (STA/AP)\n");
	xil_printf("[s]   - change SSID (note: changing SSID will purge)\n");
	xil_printf("        any associations)\n");
	/* WMP_END */
	xil_printf("**********************************************************\n");
}

/* WMP_START */
void print_modechoice_menu()
{
	xil_printf("\f");
	xil_printf("********************** Mode Selection **********************\n");
	xil_printf("\nCurrent mode: %s\n\n", ((modeofoperation == MODEOFOPERATION_STA) ? "STA" : "AP"));
	xil_printf("[0]   - STA\n");
	xil_printf("[1]   - AP\n");
	xil_printf("[ESC] - Return to main menu\n");
	xil_printf("\n");
}

void print_chan_menu(){
	xil_printf("\f");
	xil_printf("Current channel: %d\n", mac_param_chan);
	xil_printf("To change the current channel,\n");
	xil_printf("please type a new channel number and press enter\n");
	xil_printf("(Press ESC to return to main menu)\n");
	xil_printf(": ");
}

void print_beacon_tu_menu(){
	xil_printf("\f");
	xil_printf("Current beacon interval: %d\n", beacon_interval);
	xil_printf("To change the current beacon interval,\n");
	xil_printf("please type a new beacon interval (ms) and press enter\n");
	xil_printf("(Press ESC to return to main menu)\n");
	xil_printf(": ");
}

void print_ssid_menu(){
	xil_printf("\f");
	xil_printf("Current SSID: %s\n", access_point_ssid);
	xil_printf("To change the current SSID, please type a new string and press enter\n");
	xil_printf("(Press ESC to return to main menu)\n");
	xil_printf(": ");
}

/* WMP_END */

void print_station_status(u8 manual_call){

	u64 timestamp;
	static u8 print_scheduled = 0;
	void* ltg_sched_state;
	void* ltg_sched_parameters;
	void* ltg_pyld_callback_arg;

	u32 ltg_type;


	if((manual_call == 1 && print_scheduled == 0) || (manual_call == 0 && print_scheduled == 1)){
		//This awkward logic is to handle the fact that our event scheduler doesn't currently have a
		//way to remove a scheduled event and stop it from occurring. Without this protection, quick
		//UART inputs could easy begin a chain of print_station events > 1 per second. Eventually
		//you'd run out of scheduled event slots and cause problems.
		if(uart_mode == UART_MODE_INTERACTIVE){
			timestamp = get_usec_timestamp();
			xil_printf("\f");

			xil_printf("---------------------------------------------------\n");
			xil_printf(" AID: %02x -- MAC Addr: %02x:%02x:%02x:%02x:%02x:%02x\n", access_point.AID,
				access_point.addr[0],access_point.addr[1],access_point.addr[2],access_point.addr[3],access_point.addr[4],access_point.addr[5]);
				if(access_point.AID > 0){
					if(ltg_sched_get_state(0,&ltg_type,&ltg_sched_state) == 0){

						ltg_sched_get_params(0, &ltg_type, &ltg_sched_parameters);
						ltg_sched_get_callback_arg(0,&ltg_pyld_callback_arg);

						if(((ltg_sched_state_hdr*)ltg_sched_state)->enabled == 1){
							switch(ltg_type){
								case LTG_SCHED_TYPE_PERIODIC:
									xil_printf("  Periodic LTG Schedule Enabled\n");
									xil_printf("  Packet Tx Interval: %d microseconds\n", ((ltg_sched_periodic_params*)(ltg_sched_parameters))->interval_usec);
								break;
								case LTG_SCHED_TYPE_UNIFORM_RAND:
									xil_printf("  Uniform Random LTG Schedule Enabled\n");
									xil_printf("  Packet Tx Interval: Uniform over range of [%d,%d] microseconds\n", ((ltg_sched_uniform_rand_params*)(ltg_sched_parameters))->min_interval,((ltg_sched_uniform_rand_params*)(ltg_sched_parameters))->max_interval);
								break;
							}

							switch(((ltg_pyld_hdr*)(ltg_sched_state))->type){
								case LTG_PYLD_TYPE_FIXED:
									xil_printf("  Fixed Packet Length: %d bytes\n", ((ltg_pyld_fixed_length*)(ltg_pyld_callback_arg))->length);
								break;
								case LTG_PYLD_TYPE_UNIFORM_RAND:
									xil_printf("  Random Packet Length: Uniform over [%d,%d] bytes\n", ((ltg_pyld_uniform_rand*)(ltg_pyld_callback_arg))->min_length,((ltg_pyld_uniform_rand*)(ltg_pyld_callback_arg))->max_length);
								break;
							}

						}
					}
					xil_printf("     - Last heard from %d ms ago\n",((u32)(timestamp - (access_point.rx_timestamp)))/1000);
					xil_printf("     - Last Rx Power: %d dBm\n",access_point.last_rx_power);
					xil_printf("     - # of queued MPDUs: %d\n", queue_num_queued(1));
					xil_printf("     - # Tx MPDUs: %d (%d successful)\n", access_point.num_tx_total, access_point.num_tx_success);
					xil_printf("     - # Tx Retry: %d\n", access_point.num_retry);
					xil_printf("     - # Rx MPDUs: %d (%d bytes)\n", access_point.num_rx_success, access_point.num_rx_bytes);
				}
			xil_printf("---------------------------------------------------\n");
			xil_printf("\n");
			xil_printf("[r] - reset statistics\n\n");
			xil_printf(" The interactive STA menu supports sending arbitrary traffic\n");
			xil_printf(" to an associated AP. To use this feature, press the number 1\n");
			xil_printf(" Pressing Esc at any time will halt all local traffic\n");
			xil_printf(" generation and return you to the main menu.");

			//Update display
			wlan_mac_schedule_event(SCHEDULE_COARSE, 1000000, (void*)print_station_status);
			print_scheduled = 1;
		} else {
			print_scheduled = 0;
		}
	}
}

void ltg_cleanup(u32 id, void* callback_arg){
	wlan_free(callback_arg);
}




#endif


