////////////////////////////////////////////////////////////////////////////////
// File   : wlan_mac_packet_types.c
// Authors: Patrick Murphy (murphpo [at] mangocomm.com)
//			Chris Hunter (chunter [at] mangocomm.com)
// License: Copyright 2013, Mango Communications. All rights reserved.
//          Distributed under the Mango Communications Reference Design License
//				See LICENSE.txt included in the design archive or
//				at http://mangocomm.com/802.11/license
////////////////////////////////////////////////////////////////////////////////
//Xilinx SDK includes
#include "stdio.h"
#include "stdlib.h"
#include "xio.h"
#include "string.h"
#include "xil_types.h"
#include "xintc.h"

//WARP includes
#include "wlan_mac_ipc_util.h"
#include "wlan_mac_802_11_defs.h"
#include "wlan_mac_packet_types.h"
#include "wlan_mac_util.h"

int wlan_create_beacon_probe_frame(void* pkt_buf, u8 frame_control_1,mac_header_80211_common* common, u16 beacon_interval, u8 ssid_len, u8* ssid, u8 chan) {
	u32 packetLen_bytes;
	u8* txBufferPtr_u8;

	txBufferPtr_u8 = (u8*)pkt_buf;

	mac_header_80211* beacon_80211_header;
	beacon_80211_header = (mac_header_80211*)(txBufferPtr_u8);

	beacon_80211_header->frame_control_1 = frame_control_1;
	beacon_80211_header->frame_control_2 = 0;

	//This field may be overwritten by CPU_LOW
	beacon_80211_header->duration_id = 0;

	memcpy(beacon_80211_header->address_1,common->address_1,6);
	memcpy(beacon_80211_header->address_2,common->address_2,6);
	memcpy(beacon_80211_header->address_3,common->address_3,6);

	beacon_80211_header->sequence_control = (((common->seq_num)&0xFFF)<<4);

	beacon_probe_frame* beacon_probe_mgmt_header;
	beacon_probe_mgmt_header = (beacon_probe_frame*)(pkt_buf + sizeof(mac_header_80211));

	//This field may be overwritten by CPU_LOW
	beacon_probe_mgmt_header->timestamp = 0;

	beacon_probe_mgmt_header->beacon_interval = beacon_interval;
	beacon_probe_mgmt_header->capabilities = (CAPABILITIES_ESS | CAPABILITIES_SHORT_PREAMBLE | CAPABILITIES_SHORT_TIMESLOT);

	txBufferPtr_u8 = (u8 *)((void *)(txBufferPtr_u8) + sizeof(mac_header_80211) + sizeof(beacon_probe_frame));
	txBufferPtr_u8[0] = 0; //Tag 0: SSID parameter set
	txBufferPtr_u8[1] = ssid_len;
	memcpy((void *)(&(txBufferPtr_u8[2])),(void *)(&ssid[0]),ssid_len);

	txBufferPtr_u8+=(ssid_len+2); //Move up to next tag

	//http://my.safaribooksonline.com/book/networking/wireless/0596100523/4dot-802dot11-framing-in-detail/wireless802dot112-chp-4-sect-3
	//Top bit is whether or not the rate is mandatory (basic). Bottom 7 bits is in units of "number of 500kbps"
	txBufferPtr_u8[0] = 1; //Tag 1: Supported Rates
	txBufferPtr_u8[1] = 8; //tag length... doesn't include the tag itself and the tag length
	txBufferPtr_u8[2] = RATE_BASIC | (0x0C); 	//6Mbps  (BPSK,   1/2)
	txBufferPtr_u8[3] = (0x12);				 	//9Mbps  (BPSK,   3/4)
	txBufferPtr_u8[4] = RATE_BASIC | (0x18); 	//12Mbps (QPSK,   1/2)
	txBufferPtr_u8[5] = (0x24); 				//18Mbps (QPSK,   3/4)
	txBufferPtr_u8[6] = RATE_BASIC | (0x30); 	//24Mbps (16-QAM, 1/2)
	txBufferPtr_u8[7] = (0x48); 				//36Mbps (16-QAM, 3/4)
	txBufferPtr_u8[8] = (0x60); 				//48Mbps  (64-QAM, 2/3)
	txBufferPtr_u8[9] = (0x6C); 				//54Mbps  (64-QAM, 3/4)
	txBufferPtr_u8+=(8+2); //Move up to next tag

	txBufferPtr_u8[0] = 3; //Tag 3: DS Parameter set
	txBufferPtr_u8[1] = 1; //tag length... doesn't include the tag itself and the tag length
	txBufferPtr_u8[2] = chan;
	txBufferPtr_u8+=(1+2);

	txBufferPtr_u8[0] = 5; //Tag 5: Traffic Indication Map (TIM)
	txBufferPtr_u8[1] = 4; //tag length... doesn't include the tag itself and the tag length
	txBufferPtr_u8[2] = 0; //DTIM count
	txBufferPtr_u8[3] = 1; //DTIM period
	txBufferPtr_u8[4] = 1; //Bitmap control 1 //0 to disable direct multicast
	txBufferPtr_u8[5] = 0; //Bitmap control 1
	txBufferPtr_u8+=(4+2);

	txBufferPtr_u8[0] = 42; //Tag 42: ERP Info
	txBufferPtr_u8[1] = 1; //tag length... doesn't include the tag itself and the tag length
	txBufferPtr_u8[2] = 0; //Non ERP Present - not set, don't use protection, no barker preamble mode
	txBufferPtr_u8+=(1+2);

	txBufferPtr_u8[0] = 47; //Tag 47: ERP Info
	txBufferPtr_u8[1] = 1; //tag length... doesn't include the tag itself and the tag length
	txBufferPtr_u8[2] = 0; //Non ERP Present - not set, don't use protection, no barker preamble mode
	txBufferPtr_u8+=(1+2);

	packetLen_bytes = txBufferPtr_u8 - (u8*)(pkt_buf);

	(common->seq_num)++;

	return packetLen_bytes;
}

int wlan_create_probe_req_frame(void* pkt_buf, mac_header_80211_common* common, u8 ssid_len, u8* ssid, u8 chan){
	u32 packetLen_bytes;
	u8* txBufferPtr_u8;

	txBufferPtr_u8 = (u8*)pkt_buf;

	mac_header_80211* probe_req_80211_header;
	probe_req_80211_header = (mac_header_80211*)(txBufferPtr_u8);

	probe_req_80211_header->frame_control_1 = MAC_FRAME_CTRL1_SUBTYPE_PROBE_REQ;
	probe_req_80211_header->frame_control_2 = 0;

	//This field may be overwritten by CPU_LOW
	probe_req_80211_header->duration_id = 0;

	memcpy(probe_req_80211_header->address_1,common->address_1,6);
	memcpy(probe_req_80211_header->address_2,common->address_2,6);
	memcpy(probe_req_80211_header->address_3,common->address_3,6);

	probe_req_80211_header->sequence_control = (((common->seq_num)&0xFFF)<<4);

	txBufferPtr_u8 = (u8 *)((void *)(txBufferPtr_u8) + sizeof(mac_header_80211));
	txBufferPtr_u8[0] = 0; //Tag 0: SSID parameter set
	txBufferPtr_u8[1] = ssid_len;
	memcpy((void *)(&(txBufferPtr_u8[2])),(void *)(&ssid[0]),ssid_len);

	txBufferPtr_u8+=(ssid_len+2); //Move up to next tag

	//http://my.safaribooksonline.com/book/networking/wireless/0596100523/4dot-802dot11-framing-in-detail/wireless802dot112-chp-4-sect-3
	//Top bit is whether or not the rate is mandatory (basic). Bottom 7 bits is in units of "number of 500kbps"
	txBufferPtr_u8[0] = 1; //Tag 1: Supported Rates
	txBufferPtr_u8[1] = 8; //tag length... doesn't include the tag itself and the tag length
	txBufferPtr_u8[2] = (0x0C); 				//6Mbps  (BPSK,   1/2)
	txBufferPtr_u8[3] = (0x12);				 	//9Mbps  (BPSK,   3/4)
	txBufferPtr_u8[4] = (0x18); 				//12Mbps (QPSK,   1/2)
	txBufferPtr_u8[5] = (0x24); 				//18Mbps (QPSK,   3/4)
	txBufferPtr_u8[6] = (0x30); 				//24Mbps (16-QAM, 1/2)
	txBufferPtr_u8[7] = (0x48); 				//36Mbps (16-QAM, 3/4)
	txBufferPtr_u8[8] = (0x60); 				//48Mbps  (64-QAM, 2/3)
	txBufferPtr_u8[9] = (0x6C); 				//54Mbps  (64-QAM, 3/4)
	txBufferPtr_u8+=(8+2); //Move up to next tag

	txBufferPtr_u8[0] = 3; //Tag 3: DS Parameter set
	txBufferPtr_u8[1] = 1; //tag length... doesn't include the tag itself and the tag length
	txBufferPtr_u8[2] = chan;
	txBufferPtr_u8+=(1+2);

	packetLen_bytes = txBufferPtr_u8 - (u8*)(pkt_buf);

	(common->seq_num)++;

	//DEBUG
	//xil_printf("\n packetLen_bytes = %d\n", packetLen_bytes);
	//u32 i;
	//for(i = 0; i<packetLen_bytes; i++){
	//	xil_printf("%x ", ((u8*)pkt_buf)[i]);
	//}
	//xil_printf("\n");

	return packetLen_bytes;
}

int wlan_create_auth_frame(void* pkt_buf, mac_header_80211_common* common, u16 auth_algorithm,  u16 auth_seq, u16 status_code){
	u32 packetLen_bytes;
	u8* txBufferPtr_u8;

	txBufferPtr_u8 = (u8*)pkt_buf;

	mac_header_80211* auth_80211_header;
	auth_80211_header = (mac_header_80211*)(txBufferPtr_u8);

	auth_80211_header->frame_control_1 = MAC_FRAME_CTRL1_SUBTYPE_AUTH;
	auth_80211_header->frame_control_2 = 0;

	//duration can be filled in by CPU_LOW
	auth_80211_header->duration_id = 0;
	memcpy(auth_80211_header->address_1,common->address_1,6);
	memcpy(auth_80211_header->address_2,common->address_2,6);
	memcpy(auth_80211_header->address_3,common->address_3,6);

	auth_80211_header->sequence_control = (((common->seq_num)&0xFFF)<<4);

	authentication_frame* auth_mgmt_header;
	auth_mgmt_header = (authentication_frame*)(pkt_buf + sizeof(mac_header_80211));
	auth_mgmt_header->auth_algorithm = auth_algorithm;
	auth_mgmt_header->auth_sequence = auth_seq;
	auth_mgmt_header->status_code = status_code;

	txBufferPtr_u8 = (u8 *)((void *)(txBufferPtr_u8) + sizeof(mac_header_80211) + sizeof(authentication_frame));

	packetLen_bytes = txBufferPtr_u8 - (u8*)(pkt_buf);

	(common->seq_num)++;

	return packetLen_bytes;

}

int wlan_create_deauth_frame(void* pkt_buf, mac_header_80211_common* common, u16 reason_code){
	u32 packetLen_bytes;
	u8* txBufferPtr_u8;

	txBufferPtr_u8 = (u8*)pkt_buf;

	mac_header_80211* deauth_80211_header;
	deauth_80211_header = (mac_header_80211*)(txBufferPtr_u8);

	deauth_80211_header->frame_control_1 = MAC_FRAME_CTRL1_SUBTYPE_DEAUTH;
	deauth_80211_header->frame_control_2 = 0;

	//duration can be filled in by CPU_LOW
	deauth_80211_header->duration_id = 0;
	memcpy(deauth_80211_header->address_1,common->address_1,6);
	memcpy(deauth_80211_header->address_2,common->address_2,6);
	memcpy(deauth_80211_header->address_3,common->address_3,6);

	deauth_80211_header->sequence_control = (((common->seq_num)&0xFFF)<<4);

	deauthentication_frame* deauth_mgmt_header;
	deauth_mgmt_header = (deauthentication_frame*)(pkt_buf + sizeof(mac_header_80211));
	deauth_mgmt_header->reason_code = reason_code;

	txBufferPtr_u8 = (u8 *)((void *)(txBufferPtr_u8) + sizeof(mac_header_80211) + sizeof(authentication_frame));

	packetLen_bytes = txBufferPtr_u8 - (u8*)(pkt_buf);

	(common->seq_num)++;

	return packetLen_bytes;

}

int wlan_create_reassoc_assoc_req_frame(void* pkt_buf, u8 frame_control_1, mac_header_80211_common* common, u8 ssid_len, u8* ssid, u8 num_basic_rates, u8* basic_rates){
	u32 packetLen_bytes;
	u8* txBufferPtr_u8;
	u8 num_rates;
	u32 i;

	#define NUM_STA_SUPPORTED_RATES 8
	u8 sta_supported_rates[NUM_STA_SUPPORTED_RATES] = {0x0c, 0x12, 0x18, 0x24, 0x30, 0x48, 0x60, 0x6c};

	txBufferPtr_u8 = (u8*)pkt_buf;

	mac_header_80211* assoc_80211_header;
	assoc_80211_header = (mac_header_80211*)(txBufferPtr_u8);

	assoc_80211_header->frame_control_1 = frame_control_1;
	assoc_80211_header->frame_control_2 = 0;
	//duration can be filled in by CPU_LOW
	assoc_80211_header->duration_id = 0;

	memcpy(assoc_80211_header->address_1,common->address_1,6);
	memcpy(assoc_80211_header->address_2,common->address_2,6);
	memcpy(assoc_80211_header->address_3,common->address_3,6);

	assoc_80211_header->sequence_control = (((common->seq_num)&0xFFF)<<4);

	association_request_frame* association_req_mgmt_header;
	association_req_mgmt_header = (association_request_frame*)(pkt_buf + sizeof(mac_header_80211));
	association_req_mgmt_header->capabilities = (CAPABILITIES_ESS | CAPABILITIES_SHORT_PREAMBLE | CAPABILITIES_SHORT_TIMESLOT);

	association_req_mgmt_header->listen_interval = 0x000f; //FIXME: hardcoded temporarily

	txBufferPtr_u8 = (u8 *)((void *)(txBufferPtr_u8) + sizeof(mac_header_80211) + sizeof(association_request_frame));

	txBufferPtr_u8[0] = 0; //Tag 0: SSID parameter set
	txBufferPtr_u8[1] = ssid_len;
	memcpy((void *)(&(txBufferPtr_u8[2])),(void *)(&ssid[0]),ssid_len);

	txBufferPtr_u8+=(ssid_len+2); //Move up to next tag




/*	//http://my.safaribooksonline.com/book/networking/wireless/0596100523/4dot-802dot11-framing-in-detail/wireless802dot112-chp-4-sect-3
	//Top bit is whether or not the rate is mandatory (basic). Bottom 7 bits is in units of "number of 500kbps"
	txBufferPtr_u8[0] = 1; //Tag 1: Supported Rates
	txBufferPtr_u8[1] = 8; //tag length... doesn't include the tag itself and the tag length
	txBufferPtr_u8[2] = RATE_BASIC | (0x0C); 	//6Mbps  (BPSK,   1/2)
	txBufferPtr_u8[3] = (0x12);				 	//9Mbps  (BPSK,   3/4)
	txBufferPtr_u8[4] = RATE_BASIC | (0x18); 	//12Mbps (QPSK,   1/2)
	txBufferPtr_u8[5] = (0x24); 				//18Mbps (QPSK,   3/4)
	txBufferPtr_u8[6] = RATE_BASIC | (0x30); 	//24Mbps (16-QAM, 1/2)
	txBufferPtr_u8[7] = (0x48); 				//36Mbps (16-QAM, 3/4)
	txBufferPtr_u8[8] = (0x60); 				//48Mbps  (64-QAM, 2/3)
	txBufferPtr_u8[9] = (0x6C); 				//54Mbps  (64-QAM, 3/4)
	txBufferPtr_u8+=(8+2); //Move up to next tag */

	//Top bit is whether or not the rate is mandatory (basic). Bottom 7 bits is in units of "number of 500kbps"
	txBufferPtr_u8[0] = 1; //Tag 1: Supported Rates
	num_rates = rate_union(&txBufferPtr_u8[2], num_basic_rates, basic_rates, NUM_STA_SUPPORTED_RATES, sta_supported_rates);
	if(num_rates <= 8){
		txBufferPtr_u8[1] = num_rates;
		txBufferPtr_u8+=(num_rates+2);
	} else {

		txBufferPtr_u8[1] = 8;
		txBufferPtr_u8+=(8+2);

		memmove(txBufferPtr_u8+2, txBufferPtr_u8, num_rates-8);

		txBufferPtr_u8[0] = 50; //Tag 50: Extended Supported Rates
		txBufferPtr_u8[2] = num_rates-8; //Tag 50: Extended Supported Rates
		txBufferPtr_u8+=(num_rates-8+2);

		//xil_printf("Error: too many rates to fill into supported rates tag. Need to used extended supported rates.\n");

//		for(i = 0; i< num_rates; i++){
//			xil_printf("0x%x\n", txBufferPtr_u8[2+i]);
//		}

	}





	packetLen_bytes = txBufferPtr_u8 - (u8*)(pkt_buf);

	(common->seq_num)++;

	return packetLen_bytes;
}

int wlan_create_association_response_frame(void* pkt_buf, mac_header_80211_common* common, u16 status, u16 AID) {
	u32 packetLen_bytes;
	u8* txBufferPtr_u8;

	txBufferPtr_u8 = (u8*)pkt_buf;

	mac_header_80211* assoc_80211_header;
	assoc_80211_header = (mac_header_80211*)(txBufferPtr_u8);

	assoc_80211_header->frame_control_1 = MAC_FRAME_CTRL1_SUBTYPE_ASSOC_RESP;
	assoc_80211_header->frame_control_2 = 0;
	//duration can be filled in by CPU_LOW
	assoc_80211_header->duration_id = 0;

	memcpy(assoc_80211_header->address_1,common->address_1,6);
	memcpy(assoc_80211_header->address_2,common->address_2,6);
	memcpy(assoc_80211_header->address_3,common->address_3,6);

	assoc_80211_header->sequence_control = (((common->seq_num)&0xFFF)<<4);

	association_response_frame* association_resp_mgmt_header;
	association_resp_mgmt_header = (association_response_frame*)(pkt_buf + sizeof(mac_header_80211));
	association_resp_mgmt_header->capabilities = (CAPABILITIES_ESS | CAPABILITIES_SHORT_PREAMBLE | CAPABILITIES_SHORT_TIMESLOT);

	association_resp_mgmt_header->status_code = status;
	association_resp_mgmt_header->association_id = 0xC000 | AID;

	txBufferPtr_u8 = (u8 *)((void *)(txBufferPtr_u8) + sizeof(mac_header_80211) + sizeof(association_response_frame));

	//http://my.safaribooksonline.com/book/networking/wireless/0596100523/4dot-802dot11-framing-in-detail/wireless802dot112-chp-4-sect-3
	//Top bit is whether or not the rate is mandatory (basic). Bottom 7 bits is in units of "number of 500kbps"
	txBufferPtr_u8[0] = 1; //Tag 1: Supported Rates
	txBufferPtr_u8[1] = 8; //tag length... doesn't include the tag itself and the tag length
	txBufferPtr_u8[2] = RATE_BASIC | (0x0C); 	//6Mbps  (BPSK,   1/2)
	txBufferPtr_u8[3] = (0x12);				 	//9Mbps  (BPSK,   3/4)
	txBufferPtr_u8[4] = RATE_BASIC | (0x18); 	//12Mbps (QPSK,   1/2)
	txBufferPtr_u8[5] = (0x24); 				//18Mbps (QPSK,   3/4)
	txBufferPtr_u8[6] = RATE_BASIC | (0x30); 	//24Mbps (16-QAM, 1/2)
	txBufferPtr_u8[7] = (0x48); 				//36Mbps (16-QAM, 3/4)
	txBufferPtr_u8[8] = (0x60); 				//48Mbps  (64-QAM, 2/3)
	txBufferPtr_u8[9] = (0x6C); 				//54Mbps  (64-QAM, 3/4)
	txBufferPtr_u8+=(8+2); //Move up to next tag



	packetLen_bytes = txBufferPtr_u8 - (u8*)(pkt_buf);

	(common->seq_num)++;

	return packetLen_bytes;
}

int wlan_create_data_frame(void* pkt_buf, mac_header_80211_common* common, u8 flags) {

	u8* txBufferPtr_u8;
	txBufferPtr_u8 = (u8*)pkt_buf;

	mac_header_80211* data_80211_header;
	data_80211_header = (mac_header_80211*)(txBufferPtr_u8);

	data_80211_header->frame_control_1 = MAC_FRAME_CTRL1_SUBTYPE_DATA;
	data_80211_header->frame_control_2 = flags;

	data_80211_header->duration_id = 0;

	memcpy(data_80211_header->address_1,common->address_1,6);
	memcpy(data_80211_header->address_2,common->address_2,6);
	memcpy(data_80211_header->address_3,common->address_3,6);

	data_80211_header->sequence_control = (((common->seq_num)&0xFFF)<<4);

	(common->seq_num)++;

	return sizeof(mac_header_80211);
}

u8 rate_union(u8* rate_vec_out, u8 num_rate_basic, u8* rate_basic, u8 num_rate_other, u8* rate_other){

	u32 i,j;
	char str[4];

	u8 num_rate_other_temp = num_rate_other;
	u8* rate_other_temp = wlan_malloc(num_rate_other);

	memcpy(rate_other_temp, rate_other, num_rate_other);

	for(i = 0; i < num_rate_basic; i++ ){

		//tagged_rate_to_readable_rate(rate_basic[i] & ~RATE_BASIC, str);
		//xil_printf(" %d: rate: 0x%x, (%s Mbps)\n",i, rate_basic[i] & ~RATE_BASIC, str);
		rate_vec_out[i] = RATE_BASIC | rate_basic[i];

		for(j = 0; j < num_rate_other_temp; j++ ){
			//tagged_rate_to_readable_rate(rate_other_temp[j] & ~RATE_BASIC, str);
			//xil_printf("    %d: rate_other: 0x%x, (%s Mbps)\n", j, rate_other_temp[j],str);
			if(rate_other_temp[j] == (rate_basic[i] & ~RATE_BASIC )){
				//We have a duplicate rate. Remove it from the rate_other_temp vector
				num_rate_other_temp--;
				memmove(&rate_other_temp[j], &rate_other_temp[j+1], num_rate_other_temp - j);

				//xil_printf("    %d: new other num: %d, 0x%08x -> 0x%08x, len: %d\n", j, num_rate_other_temp, &rate_other_temp[j+1], &rate_other_temp[j], num_rate_other_temp - j );
				break;
			}
		}
	}

//	for(i = 0; i < num_rate_other_temp; i++ ){
//		xil_printf("0x%x\n", rate_other_temp[i]);
//	}

	memcpy(rate_vec_out + num_rate_basic, rate_other_temp, num_rate_other_temp);

	wlan_free(rate_other_temp);

	return (num_rate_other_temp + num_rate_basic);
}


