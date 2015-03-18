////////////////////////////////////////////////////////////////////////////////
// File   : wlan_mac_packet_types.h
// Authors: Patrick Murphy (murphpo [at] mangocomm.com)
//			Chris Hunter (chunter [at] mangocomm.com)
// License: Copyright 2013, Mango Communications. All rights reserved.
//          Distributed under the Mango Communications Reference Design License
//				See LICENSE.txt included in the design archive or
//				at http://mangocomm.com/802.11/license
////////////////////////////////////////////////////////////////////////////////


#ifndef WLAN_MAC_PACKET_TYPES_H_
#define WLAN_MAC_PACKET_TYPES_H_
#include "xil_types.h"
typedef struct{
	u8* address_1;
	u8* address_2;
	u8* address_3;
	u16 seq_num;
	u8 frag_num;
} mac_header_80211_common;

typedef struct{
	u16 auth_algorithm;
	u16 auth_sequence;
	u16 status_code;
} authentication_frame;

typedef struct{
	u16 reason_code;
} deauthentication_frame;

typedef struct{
	u16 capabilities;
	u16 status_code;
	u16 association_id;
} association_response_frame;

typedef struct{
	u16 capabilities;
	u16 listen_interval;
} association_request_frame;

#define AUTH_ALGO_OPEN_SYSTEM 0x00

#define AUTH_SEQ_REQ 0x01
#define AUTH_SEQ_RESP 0x02

//Class 3 frame received from nonassociated STA
#define DEAUTH_REASON_INACTIVITY		4
#define DEAUTH_REASON_NONASSOCIATED_STA	7

// Status Codes: Table 7-23 in 802.11-2007
#define STATUS_SUCCESS 0
#define STATUS_AUTH_REJECT_CHALLENGE_FAILURE 15

#define wlan_create_beacon_frame(pkt_buf,common, beacon_interval, ssid_len, ssid, chan) wlan_create_beacon_probe_frame(pkt_buf, MAC_FRAME_CTRL1_SUBTYPE_BEACON, common, beacon_interval, ssid_len, ssid, chan)
#define wlan_create_probe_resp_frame(pkt_buf,common, beacon_interval, ssid_len, ssid, chan) wlan_create_beacon_probe_frame(pkt_buf, MAC_FRAME_CTRL1_SUBTYPE_PROBE_RESP, common, beacon_interval, ssid_len, ssid, chan)
int wlan_create_beacon_probe_frame(void* pkt_buf, u8 subtype, mac_header_80211_common* common, u16 beacon_interval, u8 ssid_len, u8* ssid, u8 chan);
int wlan_create_probe_req_frame(void* pkt_buf, mac_header_80211_common* common, u8 ssid_len, u8* ssid, u8 chan);
int wlan_create_auth_frame(void* pkt_buf, mac_header_80211_common* common, u16 auth_algorithm,  u16 auth_seq, u16 status_code);
int wlan_create_deauth_frame(void* pkt_buf, mac_header_80211_common* common, u16 reason_code);
int wlan_create_association_response_frame(void* pkt_buf, mac_header_80211_common* common, u16 status, u16 AID);
#define wlan_create_association_req_frame(pkt_buf, common, ssid_len, ssid, num_basic_rates, basic_rates) wlan_create_reassoc_assoc_req_frame(pkt_buf, MAC_FRAME_CTRL1_SUBTYPE_ASSOC_REQ, common, ssid_len, ssid, num_basic_rates, basic_rates)
#define wlan_create_reassociation_req_frame(pkt_buf, common, ssid_len, ssid, num_basic_rates, basic_rates) wlan_create_reassoc_assoc_req_frame(pkt_buf, MAC_FRAME_CTRL1_SUBTYPE_REASSOC_REQ, common, ssid_len, ssid, num_basic_rates, basic_rates)
int wlan_create_reassoc_assoc_req_frame(void* pkt_buf, u8 frame_control_1, mac_header_80211_common* common, u8 ssid_len, u8* ssid, u8 num_basic_rates, u8* basic_rates);
int wlan_create_data_frame(void* pkt_buf, mac_header_80211_common* common, u8 flags);
u8 rate_union(u8* rate_vec_out, u8 num_rate_basic, u8* rate_basic, u8 num_rate_other, u8* rate_other);

#endif /* WLAN_MAC_PACKET_TYPES_H_ */
