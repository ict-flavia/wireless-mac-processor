////////////////////////////////////////////////////////////////////////////////
// File   :	wlan_exp_common.h
// Authors:	Chris Hunter (chunter [at] mangocomm.com)
//			Patrick Murphy (murphpo [at] mangocomm.com)
//          Erik Welsh (welsh [at] mangocomm.com)
// License:	Copyright 2013, Mango Communications. All rights reserved.
//			Distributed under the WARP license  (http://warpproject.org/license)
////////////////////////////////////////////////////////////////////////////////



/***************************** Include Files *********************************/
// Include xil_types so function prototypes can use u8/u16/u32 data types
#include "xil_types.h"
#include "warp_hw_ver.h"


// WLAN includes
#include "wlan_mac_util.h"


/*************************** Constant Definitions ****************************/
#ifndef WLAN_EXP_COMMON_H_
#define WLAN_EXP_COMMON_H_


// **********************************************************************
// Use WARPNet Interface
//
// Note: Please leave this undefined. WARPnet functionality will be added
// to a future release.
//

//#define  USE_WARPNET_WLAN_EXP

// #define  WLAN_EXP_WAIT_FOR_ETH


// **********************************************************************
// WARPNet Version Information
//

// Version info (MAJOR.MINOR.REV, all must be ints)
//   m-code requires C code MAJOR.MINOR match values in wl_version.ini
#define WARPNET_VER_MAJOR	2
#define WARPNET_VER_MINOR	0
#define WARPNET_VER_REV		0

#define REQ_HW_VER          (WARPNET_VER_MAJOR<<16)|(WARPNET_VER_MINOR<<8)|(WARPNET_VER_REV)


// Define the WARPNet Type to communicate the type of wn_node.  Current values are:
//   Type                              Values
//   WARPLab                           0x00000000 - 0x00000FFF
//     WARPLab Node                    0x00000000               
//   802.11                            0x00001000 - 0x00001FFF
//     802.11 AP                       0x00001000
//     802.11 Station                  0x00001001
//
#define WARPNET_TYPE_WARPLAB_BASE      0x00000000
#define WARPNET_TYPE_WARPLAB_NODE      0x00000000

#define WARPNET_TYPE_80211_BASE        0x00001000
#define WARPNET_TYPE_80211_AP          0x00000001
#define WARPNET_TYPE_80211_STATION     0x00000002



// **********************************************************************
// WARP Hardware Version Information
//
#ifdef WARP_HW_VER_v2
#define WARP_HW_VERSION                2
#endif

#ifdef WARP_HW_VER_v3
#define WARP_HW_VERSION                3
#endif



// **********************************************************************
// WARPNet Tag Parameter group defines
//
#define WARPNET_GRP             0xFF
#define NODE_GRP                0x00
#define TRANS_GRP               0x10


// Global WARPNet commands
#define WARPNET_TYPE            0xFFFFFF



// **********************************************************************
// Network Configuration Information
//

// Default network info
//   The base IP address should be a u32 with (at least) the last octet 0x00
#define NODE_IP_ADDR_BASE           0x0a000000 //10.0.0.0
#define BROADCAST_ID                0xFFFF

// Default ports- unicast ports are used for host-to-node, multicast for triggers and host-to-multinode
#define NODE_UDP_UNICAST_PORT_BASE	9000
#define NODE_UDP_MCAST_BASE			10000



// **********************************************************************
// WARPNet WLAN Exp Common Defines
//

#define PAYLOAD_PAD_NBYTES        2

#define RESP_SENT                 1
#define NO_RESP_SENT              0

#define LINK_READY                0
#define LINK_NOT_READY           -1

#define SUCCESS                   0
#define FAILURE                  -1

#define WN_CMD_TO_GRP(x)         ((x)>>24)
#define WN_CMD_TO_CMDID(x)       ((x)&0xffffff)

#define FPGA_DNA_LEN              2
#define IP_VERSION                4
#define ETH_ADDR_LEN	          6

#define TRANSMIT_OVER_NETWORK     1


/*********************** Global Structure Definitions ************************/
// 
// WARPNet WLAN Exp Structures
//

typedef struct{
	u32       cmd;
	u16       length;
	u16       numArgs;
} wn_cmdHdr;


typedef struct{
	void     *buffer;
	void     *payload;
	u32       length;
} wn_host_message;


typedef wn_cmdHdr wn_respHdr;


typedef int (*wn_function_ptr_t)();



// **********************************************************************
// WARPNet Tag Parameter Structure
//
typedef struct {
	u8    reserved;
	u8    group;
	u16   length;
	u32   command;
	u32  *value;
} wn_tag_parameter;



/*************************** Function Prototypes *****************************/
// 
// Define WARPNet Common Methods
//

void usleep( unsigned int duration );

#ifdef _DEBUG_
void print_wn_parameters( wn_tag_parameter *param, int num_params );
#endif


//
// Define WLAN Exp Common Methods
//
int get_station_status( station_info * stations, u32 num_stations, u32 * buffer, u32 max_words );




#endif /* WLAN_EXP_COMMON_H_ */
