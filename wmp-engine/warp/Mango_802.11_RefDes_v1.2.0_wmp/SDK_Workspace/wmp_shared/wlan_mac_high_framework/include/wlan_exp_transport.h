////////////////////////////////////////////////////////////////////////////////
// File   :	wlan_exp_transport.h
// Authors:	Chris Hunter (chunter [at] mangocomm.com)
//			Patrick Murphy (murphpo [at] mangocomm.com)
//          Erik Welsh (welsh [at] mangocomm.com)
// License:	Copyright 2013, Mango Communications. All rights reserved.
//			Distributed under the WARP license  (http://warpproject.org/license)
////////////////////////////////////////////////////////////////////////////////


/***************************** Include Files *********************************/
#include "wlan_exp_common.h"
#include <xilnet_udp.h>

#ifdef WARP_HW_VER_v3
#include <xaxiethernet.h>	// defines Axi Ethernet APIs
#endif


/*************************** Constant Definitions ****************************/
#ifndef WLAN_EXP_TRANSPORT_H_
#define WLAN_EXP_TRANSPORT_H_


// ****************************************************************************
// Define Warpnet Transport Commands
//
#define TRANS_PING_CMDID 			1
#define TRANS_IP_CMDID 				2
#define TRANS_PORT_CMDID 			3
#define TRANS_PAYLOADSIZETEST_CMDID 4
#define TRANS_NODEGRPID_ADD			5
#define TRANS_NODEGRPID_CLEAR		6



// ****************************************************************************
// Define Warpnet Transport Ethernet Information
//
#define WN_NUM_ETH_DEVICES          XILNET_NUM_ETH_DEVICES

#ifdef WARP_HW_VER_v2
#define WN_ETH_A                    TRIMODE_MAC_GMII
#define WN_ETH_A_MAC_DEVICE_ID		XPAR_LLTEMAC_0_DEVICE_ID
#define WN_ETH_A_SPEED              1000
#define WN_ETH_A_MDIO_PHYADDR       0x0

#define TEMAC_DEVICE_ID		        XPAR_LLTEMAC_0_DEVICE_ID
#define FIFO_DEVICE_ID		        XPAR_LLFIFO_0_DEVICE_ID
#endif

#ifdef WARP_HW_VER_v3
#define WN_ETH_A                    ETH_A_MAC
#define WN_ETH_A_MAC_DEVICE_ID      XPAR_ETH_A_MAC_DEVICE_ID
#define WN_ETH_A_SPEED              1000
#define WN_ETH_A_MDIO_PHYADDR       0x6

#define WN_ETH_B                    ETH_B_MAC
#define WN_ETH_B_MAC_DEVICE_ID      XPAR_ETH_B_MAC_DEVICE_ID
#define WN_ETH_B_SPEED              1000
#define WN_ETH_B_MDIO_PHYADDR       0x7
#endif

#define wn_conv_eth_dev_num(x)      (char)(((int)'A') + x)

#define PAYLOAD_OFFSET              LINK_HDR_LEN+IP_HDR_LEN*4+UDP_HDR_LEN+PAYLOAD_PAD_NBYTES

#define TRANSPORT_ROBUST_MASK       0x1

#define ETHPHYREG_17_0_LINKUP       0x0400

#define WAITDURATION_SEC            2

#define ETHERTYPE_IP                0x0800
#define IPPROTO_UDP                 0x11

#define PKTTYPE_TRIGGER             0
#define PKTTYPE_HTON_MSG            1
#define PKTTYPE_NTOH_MSG            2



// ****************************************************************************
// Define Transport Parameters
//   - NOTE:  To add another parameter, add the define before "NODE_MAX_PARAMETER"
//     and then change the value of "NODE_MAX_PARAMETER" to be the largest value
//     in the list so it is easy to iterate over all parameters
//
#define TRANSPORT_TYPE              0
#define TRANSPORT_HW_ADDR           1
#define TRANSPORT_IP_ADDR           2
#define TRANSPORT_UNICAST_PORT      3
#define TRANSPORT_BCAST_PORT        4
#define TRANSPORT_GRP_ID            5
#define TRANSPORT_MAX_PARAMETER     6


// TRANSPORT_TYPE values
#define TRANSPORT_TYPE_UDP          0

  

/*********************** Global Structure Definitions ************************/

// WARPNet Transport header
typedef struct {
	u16 destID;
	u16 srcID;
	u8 reserved;
	u8 pktType;
	u16 length;
	u16 seqNum;
	u16 flags;
} wn_transport_header;


// WARPNet Ethernet device structure
typedef struct  {

	// Ethernet instances
	unsigned int          mac_device_id;

#ifdef WARP_HW_VER_v2
	XLlTemac              mac_inst;
	XLlTemac_Config     * mac_cfg_ptr;
#endif

#ifdef WARP_HW_VER_v3
	XAxiEthernet          mac_inst;
	XAxiEthernet_Config * mac_cfg_ptr;
#endif

	// Pointers to WARPNet specific offsets
	wn_transport_header * wn_header_tx;
	unsigned int        * wn_TX_payload_ptr32;

	// Other Ethernet device specific fields
	unsigned int          eth_mdio_phyaddr;
	unsigned int          eth_speed;

} wn_eth_device;


// Transport info structure for Tag parameter information
typedef struct {

	u32  type;
	u32  hw_addr[2];
	u32  ip_addr;
	u32  unicast_port;
	u32  broadcast_port;
	u32  group_id;

} wn_transport_info;



/*************************** Function Prototypes *****************************/

int  transport_init               ( unsigned int node, unsigned int eth_dev_num, unsigned char *hw_addr, unsigned char *ip_addr, unsigned int unicast_port, unsigned int bcast_port );
int  transport_linkStatus         ( unsigned int eth_dev_num);
int  transport_processCmd         ( const wn_cmdHdr*, const void*, wn_respHdr*, void*, void*, unsigned int eth_dev_num);
void transport_receiveCallback    ( unsigned char*, unsigned int, void*, unsigned int );
int  transport_setReceiveCallback ( void(*handler) );
void transport_poll               ( unsigned int eth_dev_num);
void transport_send               ( wn_host_message*, pktSrcInfo*, unsigned int eth_dev_num);
void transport_close              ( unsigned int eth_dev_num);

int  transport_set_hw_info        ( unsigned int eth_dev_num, unsigned char* ip_addr, unsigned char* hw_addr);
int  transport_get_hw_addr        ( unsigned int eth_dev_num, unsigned char* hw_addr);
int  transport_get_ip_addr        ( unsigned int eth_dev_num, unsigned char* ip_addr);
int  transport_config_sockets     ( unsigned int eth_dev_num, unsigned int unicast_port, unsigned int bcast_port);

int transport_get_parameters      ( unsigned int eth_dev_num, u32* buffer, unsigned int max_words, unsigned char network );


#endif /* WLAN_EXP_TRANSPORT_H_ */
