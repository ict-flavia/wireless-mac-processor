/*
 * wmp_high_ap.h
 *
 *  Created on: May 8, 2014
 *      Author: Nicolo' Facchi
 */

#ifndef WMP_HIGH_AP_H_
#define WMP_HIGH_AP_H_

#include "wlan_mac_packet_types.h"
#include "wlan_mac_util.h"
#include "string.h"
#include "wmp_high.h"

#define BEACON_INTERVAL_MS             (100)
#define BEACON_INTERVAL_US             (BEACON_INTERVAL_MS*1000)

#define LTG_ID_TO_AID(ltg_id) (ltg_id)


void wmp_high_util_update_beacon_template();
int ethernet_receive_ap(packet_bd_list* tx_queue_list, u8* eth_dest, u8* eth_src, u16 tx_length);
void mpdu_transmit_done_ap(tx_frame_info* tx_mpdu);
void mpdu_rx_process_ap(void* pkt_buf_addr, u8 rate, u16 length);
void bad_fcs_rx_process_ap(void* pkt_buf_addr, u8 rate, u16 length);
void check_tx_queue_ap();
void ltg_event_ap(u32 id, void* callback_arg);
void deauthenticate_stations();
u32  deauthenticate_station( u32 association_index );

#endif /* WMP_HIGH_AP_H_ */
