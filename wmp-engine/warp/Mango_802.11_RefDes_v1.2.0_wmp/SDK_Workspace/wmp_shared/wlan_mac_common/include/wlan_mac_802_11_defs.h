////////////////////////////////////////////////////////////////////////////////
// File   : wlan_mac_802_11_defs.h
// Authors: Patrick Murphy (murphpo [at] mangocomm.com)
//			Chris Hunter (chunter [at] mangocomm.com)
// License: Copyright 2013, Mango Communications. All rights reserved.
//          Distributed under the Mango Communications Reference Design License
//				See LICENSE.txt included in the design archive or
//				at http://mangocomm.com/802.11/license
////////////////////////////////////////////////////////////////////////////////

#ifndef WLAN_MAC_802_11_H
#define WLAN_MAC_802_11_H

typedef struct{
	u8 frame_control_1;
	u8 frame_control_2;
	u16 duration_id;
	u8 address_1[6];
	u8 address_2[6];
	u8 address_3[6];
	u16 sequence_control;
	//u8 address_4[6];
} mac_header_80211;

//IEEE 802.11-2012 section 8.2.4:
//frame_control_1 bits[7:0]:
// 7:4: Subtype
// 3:2: Type
// 1:0: Protocol Version

#define MAC_FRAME_CTRL1_MASK_TYPE		0x0C
#define MAC_FRAME_CTRL1_MASK_SUBTYPE	0xF0

//Frame types (Table 8-1)
#define MAC_FRAME_CTRL1_TYPE_MGMT		0x00
#define MAC_FRAME_CTRL1_TYPE_CTRL		0x04
#define MAC_FRAME_CTRL1_TYPE_DATA		0x08
#define MAC_FRAME_CTRL1_TYPE_RSVD		0x0C

#define WLAN_IS_CTRL_FRAME(f) ((((mac_header_80211*)f)->frame_control_1) & MAC_FRAME_CTRL1_TYPE_CTRL)

//Frame sub-types (Table 8-1)
//Management (MAC_FRAME_CTRL1_TYPE_MGMT) sub-types
#define MAC_FRAME_CTRL1_SUBTYPE_ASSOC_REQ		(MAC_FRAME_CTRL1_TYPE_MGMT | 0x00)
#define MAC_FRAME_CTRL1_SUBTYPE_ASSOC_RESP		(MAC_FRAME_CTRL1_TYPE_MGMT | 0x10)
#define MAC_FRAME_CTRL1_SUBTYPE_REASSOC_REQ		(MAC_FRAME_CTRL1_TYPE_MGMT | 0x20)
#define MAC_FRAME_CTRL1_SUBTYPE_REASSOC_RESP	(MAC_FRAME_CTRL1_TYPE_MGMT | 0x30)
#define MAC_FRAME_CTRL1_SUBTYPE_PROBE_REQ		(MAC_FRAME_CTRL1_TYPE_MGMT | 0x40)
#define MAC_FRAME_CTRL1_SUBTYPE_PROBE_RESP		(MAC_FRAME_CTRL1_TYPE_MGMT | 0x50)
#define MAC_FRAME_CTRL1_SUBTYPE_BEACON 			(MAC_FRAME_CTRL1_TYPE_MGMT | 0x80)
#define MAC_FRAME_CTRL1_SUBTYPE_ATIM			(MAC_FRAME_CTRL1_TYPE_MGMT | 0x90)
#define MAC_FRAME_CTRL1_SUBTYPE_DISASSOC		(MAC_FRAME_CTRL1_TYPE_MGMT | 0xA0)
#define MAC_FRAME_CTRL1_SUBTYPE_AUTH  			(MAC_FRAME_CTRL1_TYPE_MGMT | 0xB0)
#define MAC_FRAME_CTRL1_SUBTYPE_DEAUTH  		(MAC_FRAME_CTRL1_TYPE_MGMT | 0xC0)
#define MAC_FRAME_CTRL1_SUBTYPE_ACTION			(MAC_FRAME_CTRL1_TYPE_MGMT | 0xD0)

//Control (MAC_FRAME_CTRL1_TYPE_CTRL) sub-types
#define MAC_FRAME_CTRL1_SUBTYPE_BLK_ACK_REQ		(MAC_FRAME_CTRL1_TYPE_CTRL | 0x80)
#define MAC_FRAME_CTRL1_SUBTYPE_BLK_ACK			(MAC_FRAME_CTRL1_TYPE_CTRL | 0x90)
#define MAC_FRAME_CTRL1_SUBTYPE_PS_POLL			(MAC_FRAME_CTRL1_TYPE_CTRL | 0xA0)
#define MAC_FRAME_CTRL1_SUBTYPE_RTS				(MAC_FRAME_CTRL1_TYPE_CTRL | 0xB0)
#define MAC_FRAME_CTRL1_SUBTYPE_CTS				(MAC_FRAME_CTRL1_TYPE_CTRL | 0xC0)
#define MAC_FRAME_CTRL1_SUBTYPE_ACK				(MAC_FRAME_CTRL1_TYPE_CTRL | 0xD0)
#define MAC_FRAME_CTRL1_SUBTYPE_CF_END			(MAC_FRAME_CTRL1_TYPE_CTRL | 0xE0)
#define MAC_FRAME_CTRL1_SUBTYPE_CF_END_CF_ACK	(MAC_FRAME_CTRL1_TYPE_CTRL | 0xF0)

//Data (MAC_FRAME_CTRL1_TYPE_DATA) sub-types

#define MAC_FRAME_CTRL1_SUBTYPE_DATA			(MAC_FRAME_CTRL1_TYPE_DATA | 0x00)

//IEEE 802.11-2012 section 8.2.4:
//frame_control_2 bits[7:0]:
#define MAC_FRAME_CTRL2_FLAG_ORDER 		0x80
#define MAC_FRAME_CTRL2_FLAG_WEP_DS		0x40
#define MAC_FRAME_CTRL2_FLAG_MORE_DATA	0x20
#define MAC_FRAME_CTRL2_FLAG_POWER_MGMT	0x10
#define MAC_FRAME_CTRL2_FLAG_RETRY		0x08
#define MAC_FRAME_CTRL2_FLAG_MORE_FLAGS	0x04
#define MAC_FRAME_CTRL2_FLAG_FROM_DS	0x02
#define MAC_FRAME_CTRL2_FLAG_TO_DS		0x01

typedef struct{
	u64 timestamp;
	u16 beacon_interval;
	u16 capabilities;
} beacon_probe_frame;

///////Capabilities
#define CAPABILITIES_ESS					0x0001
#define CAPABILITIES_IBSS					0x0002
//#define CAPABILITIES_CFP
#define CAPABILITIES_PRIVACY				0x0010
#define CAPABILITIES_SHORT_PREAMBLE			0x0020
#define CAPABILITIES_PBCC					0x0040
#define CAPABILITIES_CHAN_AGILITY			0x0080
#define CAPABILITIES_SPEC_MGMT				0x0100
#define CAPABILITIES_SHORT_TIMESLOT			0x0400
#define CAPABILITIES_APSD					0x0800
#define CAPABILITIES_DSSS_OFDM				0x2000
#define CAPABILITIES_DELAYED_BLOCK_ACK		0x4000
#define CAPABILITIES_IMMEDIATE_BLOCK_ACK	0x8000

/////// Management frame Tags
#define TAG_SSID_PARAMS				0x00
#define TAG_SUPPORTED_RATES			0x01
#define TAG_EXT_SUPPORTED_RATES		0x32
#define TAG_DS_PARAMS				0x03
#define TAG_HT_CAPABILITIES			0x45

#define RATE_BASIC 0x80


//Warning: DSSS rate is only valid for Rx. There is no DSSS transmitter.
//0x66 is an arbitrary value which cannot be confused with another PHY rate
#define WLAN_MAC_RATE_1M	0x66

#define WLAN_MAC_RATE_6M	1
#define WLAN_MAC_RATE_9M	2
#define WLAN_MAC_RATE_12M	3
#define WLAN_MAC_RATE_18M	4
#define WLAN_MAC_RATE_24M	5
#define WLAN_MAC_RATE_36M	6
#define WLAN_MAC_RATE_48M	7
#define WLAN_MAC_RATE_54M	8

#endif /* WLAN_MAC_802_11_H */
