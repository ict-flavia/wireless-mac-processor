/******************************************************************************
*
* File   :	wlan_exp_transport.c
* Authors:	Chris Hunter (chunter [at] mangocomm.com)
*			Patrick Murphy (murphpo [at] mangocomm.com)
*           Erik Welsh (welsh [at] mangocomm.com)
* License:  Copyright 2013, Mango Communications. All rights reserved.
*           Distributed under the Mango Communications Reference Design License
*				See LICENSE.txt included in the design archive or
*				at http://mangocomm.com/802.11/license
*
******************************************************************************/
/**
*
* @file wlan_exp_transport.c
*
* Implements the WARPNet Transport protocol layer for the embedded processor
* on the WARP Hardware.
*
* This implementation supports both WARP v2 and WARP v3 hardware and also
* supports both the use of the AXI FIFO as well as the AXI DMA in order
* to transport packets to/from the Ethernet controller.
*
* <pre>
* MODIFICATION HISTORY:
*
* Ver   Who  Date     Changes
* ----- ---- -------- -------------------------------------------------------
* 2.00a ejw  5/24/13  Updated for new Xilnet driver:  3.02.a
*
* </pre>
*
******************************************************************************/


// TODO:  Allow DMA initialization to different buffer location



/***************************** Include Files *********************************/

#include "warp_hw_ver.h"
#include "wlan_exp_common.h"
#include "wlan_exp_node.h"
#include "wlan_exp_transport.h"



#ifdef USE_WARPNET_WLAN_EXP

#include <stdlib.h>
#include <stdio.h>

#include <xparameters.h>
#include <xilnet_config.h>

#ifdef WARP_HW_VER_v3
#include <xaxiethernet.h>	// defines Axi Ethernet APIs
#endif

#ifdef WARP_HW_VER_v2
#include <xlltemac.h>
#endif


/*************************** Constant Definitions ****************************/



/*********************** Global Variable Definitions *************************/

extern wn_node_info node_info;

/*************************** Variable Definitions ****************************/

// NOTE:  This structure has different member types depending on the WARP version
wn_eth_device       wn_eth_devices[WN_NUM_ETH_DEVICES];

wn_host_message     toNode, fromNode;

wn_tag_parameter    transport_parameters[WN_NUM_ETH_DEVICES][TRANSPORT_MAX_PARAMETER];
wn_transport_info   transport_info[WN_NUM_ETH_DEVICES];

int                 sock_msg      = -1; // UDP socket
struct sockaddr_in  addr_msg;

int                 sock_trig     = -1; // UDP socket
struct sockaddr_in  addr_trig;

u8                  node_group_ID_membership;


// WLAN Exp Additions:
//   - Asynchronous transmit buffer - Used to transmit messages asynchronously back to a node and
//                                      not interfere with normal transport function.
//




/*************************** Function Prototypes *****************************/

void transport_null_callback(void* param){};
void (*usr_receiveCallback) ();

int transport_init_parameters( unsigned int eth_dev_num, u32 *info );


/******************************** Functions **********************************/


/*****************************************************************************/
/**
*
* This function is the Transport callback that allows WARPNet to process
* a received Ethernet packet
*
*
* @param	cmdHdr is a pointer to the WARPNet command header
* @param	cmdArgs is a pointer to the Transport command arguments
* @param	respHdr is a pointer to the WARPNet response header
* @param	respArgs is a pointer to the Transport response arguments
* @param	pktSrc is a pointer to the Ethenet packet source structure
* @param    eth_dev_num is an int that specifies the Ethernet interface to use
*
* @return	-NO_RESP_SENT to indicate no response has been sent
*		-RESP_SENT to indicate a response has been sent
*
* @note		The transport must be initialized before this function will be
*       called.  The user can modify the file to add additional functionality
*       to the WARPNet Transport.
*
******************************************************************************/

int transport_processCmd(const wn_cmdHdr* cmdHdr,const void* cmdArgs, wn_respHdr* respHdr,void* respArgs, void* pktSrc, unsigned int eth_dev_num){
	//IMPORTANT ENDIAN NOTES:
	// -cmdHdr is safe to access directly (pre-swapped if needed)
	// -cmdArgs is *not* pre-swapped, since the framework doesn't know what it is
	// -respHdr will be swapped by the framework; user code should fill it normally
	// -respArgs will *not* be swapped by the framework, since only user code knows what it is
	//    Any data added to respArgs by the code below must be endian-safe (swapped on AXI hardware)

	unsigned int  respSent   = NO_RESP_SENT;
	const u32    *cmdArgs32  = cmdArgs;
	u32          *respArgs32 = respArgs;
	unsigned int  cmdID      = WN_CMD_TO_CMDID(cmdHdr->cmd);


#ifdef _DEBUG_
	xil_printf("BEGIN transport_processCmd() \n");
#endif

	respHdr->cmd = cmdHdr->cmd;
	respHdr->length = 0;
	respHdr->numArgs = 0;

	switch(cmdID){
			case TRANS_PING_CMDID:
				//Nothing actually needs to be done when receiving the ping command. The framework is going
				//to respond regardless, which is all the host wants.
			break;
			case TRANS_IP_CMDID:
				//TODO: Only necessary for generalized discovery process
			break;
			case TRANS_PORT_CMDID:
				//TODO: Only necessary for generalized discovery process
			break;
			case TRANS_PAYLOADSIZETEST_CMDID:
				// Use the length of the toNode to determine the size of the payload
				respArgs32[0] = Xil_Ntohl(toNode.length - PAYLOAD_PAD_NBYTES);
				respHdr->length += (1 * sizeof(respArgs32));
				respHdr->numArgs = 1;
			break;
			case TRANS_NODEGRPID_ADD:
				node_group_ID_membership             = node_group_ID_membership | Xil_Htonl(cmdArgs32[0]);
                transport_info[eth_dev_num].group_id = node_group_ID_membership;
			break;
			case TRANS_NODEGRPID_CLEAR:
				node_group_ID_membership             = node_group_ID_membership &  ~Xil_Htonl(cmdArgs32[0]);
                transport_info[eth_dev_num].group_id = node_group_ID_membership;
			break;
			default:
				xil_printf("Unknown user command ID: %d\n", cmdID);
			break;
	}

#ifdef _DEBUG_
	xil_printf("END transport_processCmd() \n");
#endif

	return respSent;
}



/*****************************************************************************/
/**
*
* This function is the Transport callback that allows WARPNet to process
* a received Ethernet packet
*
*
* @param	buff is a pointer to the received packet buffer
* @param	len is an int that specifies the length of the recieved packet
* @param	pktSrc is a pointer to the Ethenet packet source structure
* @param    eth_dev_num is an int that specifies the Ethernet interface to use
*
* @return	-NO_RESP_SENT to indicate no response has been sent
*		-RESP_SENT to indicate a response has been sent
*
* @note		The transport must be initialized before this function will be
*       called.  The user can modify the file to add additional functionality
*       to the WARPNet Transport.
*
******************************************************************************/


void transport_receiveCallback(unsigned char* buff, unsigned int len, void* pktSrc, unsigned int eth_dev_num){

	unsigned char* buffPtr = buff + PAYLOAD_PAD_NBYTES;

#ifdef _DEBUG_
	xil_printf("BEGIN transport_receiveCallback() \n");
#endif

	toNode.buffer    = buffPtr;
	toNode.payload   = (unsigned int *)((unsigned char *) buffPtr + sizeof(wn_transport_header));
	toNode.length    = len;

	fromNode.buffer  = (unsigned char *)eth_device[eth_dev_num].sendbuf;
    fromNode.payload = wn_eth_devices[eth_dev_num].wn_TX_payload_ptr32;
	fromNode.length  = PAYLOAD_PAD_NBYTES;

	wn_transport_header* wn_header_rx = (wn_transport_header*)buffPtr;

	//Endian swap the received transport header (this is the first place we know what/where it is)
	wn_header_rx->destID = Xil_Ntohs(wn_header_rx->destID);
	wn_header_rx->srcID  = Xil_Ntohs(wn_header_rx->srcID);
	wn_header_rx->length = Xil_Ntohs(wn_header_rx->length);
	wn_header_rx->seqNum = Xil_Ntohs(wn_header_rx->seqNum);
	wn_header_rx->flags  = Xil_Ntohs(wn_header_rx->flags);

	switch(wn_header_rx->pktType){
		case PKTTYPE_HTON_MSG:

			if( ( (wn_header_rx->destID) != node_info.node ) &&
				( (wn_header_rx->destID) != BROADCAST_ID   ) &&
				( ((wn_header_rx->destID) & (0xFF00 | node_group_ID_membership))==0 ) ) return;

			//Form outgoing WARPNet header in case robust mode is on
			// Note- the u16/u32 fields here will be endian swapped in transport_send
			wn_eth_devices[eth_dev_num].wn_header_tx->destID  = wn_header_rx->srcID;
			wn_eth_devices[eth_dev_num].wn_header_tx->seqNum  = wn_header_rx->seqNum;
			wn_eth_devices[eth_dev_num].wn_header_tx->srcID   = node_info.node;
			wn_eth_devices[eth_dev_num].wn_header_tx->pktType = PKTTYPE_NTOH_MSG;

			usr_receiveCallback(&toNode, &fromNode, pktSrc, eth_dev_num);

			if( ((wn_header_rx->flags) & TRANSPORT_ROBUST_MASK) && fromNode.length > PAYLOAD_PAD_NBYTES) {
				transport_send(&fromNode, pktSrc, eth_dev_num);
			}

			fromNode.length = 0;
		break;
		default:
			xil_printf("Got packet with unknown type: %d\n", wn_header_rx->pktType);
			break;
	}

#ifdef _DEBUG_
	xil_printf("END transport_receiveCallback() \n");
#endif
}




/*****************************************************************************/
/**
*
* Close the WARPNet Transport stream by closing the Xilnet Socket
*
* @param    eth_dev_num is an int that specifies the Ethernet interface to use
*
* @return	None.
*
* @note		None.
*
****************************************************************************/

void transport_close(unsigned int eth_dev_num) {
	xilsock_close(sock_msg, eth_dev_num);
}



/*****************************************************************************/
/**
*
* This function will initialize the transport
*
* @param    eth_dev_num is an int that specifies the Ethernet interface to use
*
* @return	-SUCCESS to indicate that the transport was initialized
*		-FAILURE to indicated that the transport was not initialized
*
* @note		None.
*
******************************************************************************/
int transport_init( unsigned int node, unsigned int eth_dev_num, unsigned char *ip_addr, unsigned char *hw_addr, unsigned int unicast_port, unsigned int bcast_port ){

	int                   i;
	int                   status = SUCCESS;

	unsigned int          mac_device_id;

#ifdef WARP_HW_VER_v2
    XLlTemac            * mac_instance_ptr;
    XLlTemac_Config     * mac_cfg_ptr;
#endif

#ifdef WARP_HW_VER_v3
	XAxiEthernet        * mac_instance_ptr;
    XAxiEthernet_Config * mac_cfg_ptr;
#endif


	xil_printf("  ETH %c MAC Address: %02x", wn_conv_eth_dev_num(eth_dev_num), hw_addr[0] );
	for ( i = 1; i < ETH_ADDR_LEN; i++ ) { xil_printf(":%02x", hw_addr[i] ); } xil_printf("\n");
    xil_printf("  ETH %c IP  Address: %d", wn_conv_eth_dev_num(eth_dev_num), ip_addr[0]);
	for ( i = 1; i < IP_VERSION; i++ ) { xil_printf(".%d", ip_addr[i] ); } xil_printf("\n");


    // Initialize the User callback
	usr_receiveCallback = transport_null_callback;

    // Reset node group ID membership
	node_group_ID_membership = 0;


	/******************* Ethernet ********************************/

	// Check to see if we are receiving on a valid interface
	if ( eth_dev_num >= WN_NUM_ETH_DEVICES ) {
		xil_printf("  **** ERROR:  Ethernet %c is not available on WARP HW \n", wn_conv_eth_dev_num(eth_dev_num) );
		return FAILURE;
	}


#ifdef WARP_HW_VER_v3

	// Populate the wn_eth_devices structure with constants from wlan_exp_transport.h
	switch (eth_dev_num) {
	case WN_ETH_A:
		wn_eth_devices[eth_dev_num].mac_device_id        = WN_ETH_A_MAC_DEVICE_ID;
		wn_eth_devices[eth_dev_num].eth_mdio_phyaddr     = WN_ETH_A_MDIO_PHYADDR;
		wn_eth_devices[eth_dev_num].eth_speed            = WN_ETH_A_SPEED;
		break;
	case WN_ETH_B:
		wn_eth_devices[eth_dev_num].mac_device_id        = WN_ETH_B_MAC_DEVICE_ID;
		wn_eth_devices[eth_dev_num].eth_mdio_phyaddr     = WN_ETH_B_MDIO_PHYADDR;
		wn_eth_devices[eth_dev_num].eth_speed            = WN_ETH_B_SPEED;
		break;
	default:
		break;
	}

	// Pull information based on the Ethernet device to initialize
	mac_device_id    =  wn_eth_devices[eth_dev_num].mac_device_id;
	mac_instance_ptr = &wn_eth_devices[eth_dev_num].mac_inst;

	// Find Ethernet device
	mac_cfg_ptr      = XAxiEthernet_LookupConfig(mac_device_id);

	// Initialize Xilnet for Ethernet device
	status = xilnet_eth_device_init( eth_dev_num, mac_cfg_ptr->AxiDevBaseAddress, ip_addr, hw_addr );
	if (status != SUCCESS)
		xil_printf("*** Transport Xilnet Ethernet Device %c initialization error:  %d \n", wn_conv_eth_dev_num(eth_dev_num), status);

	xilnet_eth_init_hw_addr_tbl(eth_dev_num);

	// Initialize Ethernet Device
	status = XAxiEthernet_CfgInitialize(mac_instance_ptr, mac_cfg_ptr, mac_cfg_ptr->BaseAddress);
	if (status != XST_SUCCESS)
		xil_printf("*** EMAC init error\n");

	status  = XAxiEthernet_ClearOptions(mac_instance_ptr, XAE_LENTYPE_ERR_OPTION | XAE_FLOW_CONTROL_OPTION | XAE_FCS_STRIP_OPTION);
	if (status != XST_SUCCESS)
		xil_printf("*** Error clearing EMAC A options\n, code %d", status);

	status |= XAxiEthernet_SetOptions(mac_instance_ptr, XAE_PROMISC_OPTION | XAE_MULTICAST_OPTION | XAE_BROADCAST_OPTION | XAE_RECEIVER_ENABLE_OPTION | XAE_TRANSMITTER_ENABLE_OPTION | XAE_JUMBO_OPTION);
	if (status != XST_SUCCESS)
		xil_printf("*** Error setting EMAC A options\n, code %d", status);

	XAxiEthernet_SetOperatingSpeed(mac_instance_ptr, wn_eth_devices[eth_dev_num].eth_speed);
	usleep(1 * 10000);

	XAxiEthernet_Start(mac_instance_ptr);

	// Start Xilnet
	xilnet_eth_device_start(eth_dev_num);
#endif    // END WARP_HW_VER_v3


#ifdef WARP_HW_VER_v2

	// Populate the wn_eth_devices structure with constants from wlan_exp_transport.h
	wn_eth_devices[eth_dev_num].mac_device_id        = WN_ETH_A_MAC_DEVICE_ID;
	wn_eth_devices[eth_dev_num].eth_mdio_phyaddr     = WN_ETH_A_MDIO_PHYADDR;
	wn_eth_devices[eth_dev_num].eth_speed            = WN_ETH_A_SPEED;

	// Pull information based on the Ethernet device to initialize
	mac_device_id    =  wn_eth_devices[eth_dev_num].mac_device_id;
	mac_instance_ptr = &wn_eth_devices[eth_dev_num].mac_inst;

	// Find Ethernet device
	mac_cfg_ptr      = XLlTemac_LookupConfig(mac_device_id);

	// Initialize Xilnet for Ethernet device
	status = xilnet_eth_device_init( eth_dev_num, mac_cfg_ptr->LLDevBaseAddress, ip_addr, hw_addr );
	if (status != SUCCESS)
		xil_printf("*** Transport Xilnet Ethernet Device %c initialization error:  %d \n", wn_conv_eth_dev_num(eth_dev_num), status);

	xilnet_eth_init_hw_addr_tbl(eth_dev_num);

	// Initialize Ethernet Device
	status = XLlTemac_CfgInitialize(mac_instance_ptr, mac_cfg_ptr, mac_cfg_ptr->BaseAddress);
	if (status != XST_SUCCESS)
		xil_printf("*** EMAC init error\n");

	status  = XLlTemac_ClearOptions(mac_instance_ptr, XTE_LENTYPE_ERR_OPTION | XTE_FLOW_CONTROL_OPTION | XTE_FCS_STRIP_OPTION);
	if (status != XST_SUCCESS)
		xil_printf("*** Error clearing EMAC A options\n, code %d", status);

	status |= XLlTemac_SetOptions(mac_instance_ptr, XTE_PROMISC_OPTION | XTE_MULTICAST_OPTION | XTE_BROADCAST_OPTION | XTE_RECEIVER_ENABLE_OPTION | XTE_TRANSMITTER_ENABLE_OPTION | XTE_JUMBO_OPTION);
	if (status != XST_SUCCESS)
		xil_printf("*** Error setting EMAC A options\n, code %d", status);

	XLlTemac_SetOperatingSpeed(mac_instance_ptr, wn_eth_devices[eth_dev_num].eth_speed);
	usleep(1 * 10000);

	XLlTemac_Start(mac_instance_ptr);

	// Start Xilnet
	xilnet_eth_device_start(eth_dev_num);
#endif    // END WARP_HW_VER_v2


	// Populate the wn_eth_devices structure
	wn_eth_devices[eth_dev_num].mac_cfg_ptr          = mac_cfg_ptr;
	wn_eth_devices[eth_dev_num].wn_header_tx         = (wn_transport_header*)(((unsigned char *)eth_device[eth_dev_num].sendbuf) + PAYLOAD_OFFSET);
	wn_eth_devices[eth_dev_num].wn_header_tx->srcID  = node_info.node;
	wn_eth_devices[eth_dev_num].wn_TX_payload_ptr32  = (unsigned int *)((((unsigned char *)eth_device[eth_dev_num].sendbuf) + PAYLOAD_OFFSET) + sizeof(wn_transport_header));

	// Configure the Sockets for each Ethernet Interface
	status = transport_config_sockets(eth_dev_num, unicast_port, bcast_port);

    
    // Initialize the tag parameters
    transport_info[eth_dev_num].type           = TRANSPORT_TYPE_UDP; 
    transport_info[eth_dev_num].hw_addr[0]     = (hw_addr[0]<<8)  |  hw_addr[1];
    transport_info[eth_dev_num].hw_addr[1]     = (hw_addr[2]<<24) | (hw_addr[3]<<16) | (hw_addr[4]<<8) | hw_addr[5];
    transport_info[eth_dev_num].ip_addr        = (ip_addr[0]<<24) | (ip_addr[1]<<16) | (ip_addr[2]<<8) | ip_addr[3];
    transport_info[eth_dev_num].unicast_port   = unicast_port;
    transport_info[eth_dev_num].broadcast_port = bcast_port;
    transport_info[eth_dev_num].group_id       = node_group_ID_membership;
    
    transport_init_parameters( eth_dev_num, (u32 *)&transport_info[eth_dev_num] );

#ifdef _DEBUG_
    print_wn_parameters( (wn_tag_parameter *)&transport_parameters[eth_dev_num][0], TRANSPORT_MAX_PARAMETER );
#endif

	return status;
}



/*****************************************************************************/
/**
*
* This is a wrapper function that will set the MAC and IP addresses
*   for a given interface
*
*
* @param    eth_dev_num is an int that specifies the Ethernet interface to use
* @param	ip_addr is a pointer to an unsigned char array to store the IP address
* @param	hw_addr is a pointer to an unsigned char array to store the MAC address
*
* @return	-SUCCESS to indicate that the MAC and IP are valid
*		    -FAILURE to indicate that the MAC and IP are not valid
*
* @note		None.
*
******************************************************************************/
int transport_set_hw_info( unsigned int eth_dev_num, unsigned char* ip_addr, unsigned char* hw_addr) {

    // Update the Tag Parameters
    transport_info[eth_dev_num].hw_addr[0]     = (hw_addr[0]<<8)  |  hw_addr[1];
    transport_info[eth_dev_num].hw_addr[1]     = (hw_addr[2]<<24) | (hw_addr[3]<<16) | (hw_addr[4]<<8) | hw_addr[5];
    transport_info[eth_dev_num].ip_addr        = (ip_addr[0]<<24) | (ip_addr[1]<<16) | (ip_addr[2]<<8) | ip_addr[3];

    return xilnet_eth_set_inf_hw_info( eth_dev_num, ip_addr, hw_addr );
}



/*****************************************************************************/
/**
*
* This is a wrapper function that will get the MAC address for a given interface
*
* @param    eth_dev_num is an int that specifies the Ethernet interface to use
* @param	hw_addr is a pointer to an unsigned char array to store the MAC address
*
* @return	- SUCCESS to indicate that the MAC is valid
*		    - FAILURE to indicate that the MAC is not valid
*
* @note		None.
*
******************************************************************************/
int transport_get_hw_addr( unsigned int eth_dev_num, unsigned char* hw_addr ) {

    return xilnet_eth_get_inf_hw_addr( eth_dev_num, hw_addr );
}



/*****************************************************************************/
/**
*
* This is a wrapper function that will get the IP address for a given interface
*
* @param    eth_dev_num is an int that specifies the Ethernet interface to use
* @param	ip_addr is a pointer to an unsigned char array to store the IP address
*
* @return	-SUCCESS to indicate that the MAC and IP are valid
*		-FAILURE to indicate that the MAC and IP are not valid
*
* @note		None.
*
******************************************************************************/
int transport_get_ip_addr( unsigned int eth_dev_num, unsigned char* ip_addr ) {

    return xilnet_eth_get_inf_ip_addr( eth_dev_num, ip_addr );
}



/*****************************************************************************/
/**
*
* This function will configure the Xilnet sockets to be used by the transport
*
*
* @param    eth_dev_num is an int that specifies the Ethernet interface to use
*
* @return	-SUCCESS to indicate sockets successfully configured
*		-FAILURE to indicate the sockets were not configured
*
* @note		None.
*
******************************************************************************/

int transport_config_sockets(unsigned int eth_dev_num, unsigned int unicast_port, unsigned int bcast_port) {
	int status = SUCCESS;
	int tempStatus = 0;

    // Release sockets if they are already bound
    if ( sock_msg  != -1 ) { xilsock_close( sock_msg,  eth_dev_num ); }
    if ( sock_trig != -1 ) { xilsock_close( sock_trig, eth_dev_num ); }

    // Create new sockets and bind them
	sock_msg = xilsock_socket(AF_INET, SOCK_DGRAM, 0, eth_dev_num);	// Create UDP socket with domain Internet and UDP connection.
	if (sock_msg == -1) {
		xil_printf("Error in creating sock_msg\n");
		status = FAILURE;
		return status;
	}

	sock_trig = xilsock_socket(AF_INET, SOCK_DGRAM, 0, eth_dev_num);	// Create UDP socket with domain Internet and UDP connection.
	if (sock_trig == -1) {
		xil_printf("Error in creating sock_msg\n");
		status = FAILURE;
		return status;
	}

	addr_msg.sin_family       = AF_INET;
	addr_msg.sin_port         = unicast_port;
	addr_msg.sin_addr.s_addr  = INADDR_ANY;			// Create the input socket with any incoming address. (0x00000000)

	addr_trig.sin_family      = AF_INET;
	addr_trig.sin_port        = bcast_port;
	addr_trig.sin_addr.s_addr = INADDR_ANY;			// Create the input socket with any incoming address. (0x00000000)

	tempStatus = xilsock_bind(sock_msg, (struct sockaddr *)&addr_msg, sizeof(struct sockaddr),(void *)transport_receiveCallback, eth_dev_num);
	if (tempStatus != 1) {
		xil_printf("Unable to bind sock_msg\n");
		status = -1;
		return status;
	}

	tempStatus = xilsock_bind(sock_trig, (struct sockaddr *)&addr_trig, sizeof(struct sockaddr),(void *)transport_receiveCallback, eth_dev_num);
	if (tempStatus != 1) {
		xil_printf("Unable to bind sock_trig\n");
		status = -1;
		return status;
	}

    // Update the Tag Parameters
    transport_info[eth_dev_num].unicast_port   = unicast_port;
    transport_info[eth_dev_num].broadcast_port = bcast_port;
    
	xil_printf("  Listening on UDP ports %d (unicast) and %d (broadcast)\n", unicast_port, bcast_port);

	return status;
}



/*****************************************************************************/
/**
*
* This function is the Transport callback that allows WARPNet to process
* a received Ethernet packet
*
*
* @param	handler is a pointer to the receive callback function
*
* @return	Always returns SUCCESS
*
* @note		None.
*
******************************************************************************/

int transport_setReceiveCallback(void(*handler)){
	usr_receiveCallback = handler;
	return SUCCESS;
}



/*****************************************************************************/
/**
*
* This function will poll the Ethernet interfaces
*
*
* @param    eth_dev_num is an int that specifies the Ethernet interface to use
*
* @return	None.
*
* @note		None.
*
******************************************************************************/

void transport_poll(unsigned int eth_dev_num){
    xilnet_eth_recv_frame(eth_dev_num);
}


/*****************************************************************************/
/**
*
* This function is used to send a message over Ethernet
*
*
* @param	currMsg is a pointer to the WARPNet Host Message
* @param	pktSrc is a pointer to the Ethenet packet source structure
* @param    eth_dev_num is an int that specifies the Ethernet interface to use
*
* @return	None.
*
* @note		The transport must be initialized before this function will be
*       called.  The user can modify the file to add additional functionality
*       to the WARPNet Transport.
*
******************************************************************************/

void transport_send(wn_host_message* currMsg, pktSrcInfo* pktSrc, unsigned int eth_dev_num){

	int                   len_to_send;
	wn_transport_header   tmp_hdr;
	wn_transport_header * wn_header_tx = (wn_transport_header *)(currMsg->buffer + PAYLOAD_OFFSET);

#ifdef _DEBUG_
	xil_printf("BEGIN transport_send() \n");
#endif

	len_to_send = currMsg->length + sizeof(wn_transport_header);

	memcpy(&tmp_hdr, wn_header_tx, sizeof(wn_transport_header));

	// Update length field in outgoing transport header (size of the payload)
	wn_header_tx->length = currMsg->length - sizeof(wn_transport_header);

	// Make the outgoing transport header endian safe for sending on the network
	wn_header_tx->destID = Xil_Htons(wn_header_tx->destID);
	wn_header_tx->srcID  = Xil_Htons(wn_header_tx->srcID);
	wn_header_tx->length = Xil_Htons(wn_header_tx->length);
	wn_header_tx->seqNum = Xil_Htons(wn_header_tx->seqNum);
	wn_header_tx->flags  = Xil_Htons(wn_header_tx->flags);

	struct sockaddr_in sendAddr;

	sendAddr.sin_addr.s_addr = pktSrc->srcIPAddr;
	sendAddr.sin_family      = AF_INET;
	sendAddr.sin_port        = pktSrc->destPort;

#ifdef _DEBUG_
	xil_printf("sendAddr.sin_addr.s_addr = %d.%d.%d.%d\n",(sendAddr.sin_addr.s_addr>>24)&0xFF,(sendAddr.sin_addr.s_addr>>16)&0xFF,(sendAddr.sin_addr.s_addr>>8)&0xFF,(sendAddr.sin_addr.s_addr)&0xFF);
	xil_printf("sendAddr.sin_family      = %d\n",sendAddr.sin_family);
	xil_printf("sendAddr.sin_port        = %d\n",sendAddr.sin_port);

	xil_printf("buffer                   = 0x%x;\n", currMsg->buffer );
	xil_printf("len                      = %d;  \n", len_to_send );

//	print_pkt((unsigned char *)eth_device[eth_dev_num].sendbuf, len_to_send);
#endif

	// Check the interrupt status; Disable interrupts if enabled
    // TODO


	// NOTE:  This command is not safe to execute when interrupts are enabled when commands can
	//        arbitrarily send ethernet packets.  Technically, we only have to wrap the xilnet_eth_send_frame() call
	//        but that would require modifying the WARPxilnet driver and having it understand interrupts
	//
	xilsock_sendto(sock_msg, (unsigned char *)currMsg->buffer, len_to_send, (struct sockaddr *)&sendAddr, eth_dev_num);

	// Restore interrupts
    // TODO


	//Restore wn_header_tx
	memcpy(wn_header_tx, &tmp_hdr, sizeof(wn_transport_header));

#ifdef _DEBUG_
	xil_printf("END transport_send() \n");
#endif
}



/*****************************************************************************/
/**
*
* This function will check the link status of all Ethernet controllers
*
*
* @param    eth_dev_num is an int that specifies the Ethernet interface to use
*
* @return	-LINK_READY to indicate both Ethernet controllers (depending on defines)
*       are ready to be used.
*		-LINK_NOT_READY to indicate one of the Ethernet controllers is not
*		read to be used.
*
* @note		The transport must be initialized before this function will be
*       called.  The user can modify the file to add additional functionality
*       to the WARPNet Transport.
*
******************************************************************************/

int transport_linkStatus(unsigned int eth_dev_num) {

	u16 status = LINK_READY;
	u16 regA   = 0;

	// Check to see if we are receiving on a valid interface
	if ( eth_dev_num >= WN_NUM_ETH_DEVICES ) {
		xil_printf("  **** ERROR:  Ethernet %c is not available on WARP HW \n", wn_conv_eth_dev_num(eth_dev_num));
		return LINK_NOT_READY;
	}

//Check if the Ethernet PHY reports a valid link
#ifdef WARP_HW_VER_v2

	if (eth_dev_num != WN_ETH_A) {
		xil_printf("**** Error:  Ethernet B is not available on WARP HW V2\n");
		return LINK_NOT_READY;
	}

	XLlTemac_PhyRead(&wn_eth_devices[eth_dev_num].mac_inst, wn_eth_devices[eth_dev_num].eth_mdio_phyaddr, 17, &regA);
#endif    // End WARP_HW_VER_v2

#ifdef WARP_HW_VER_v3

	XAxiEthernet_PhyRead(&wn_eth_devices[eth_dev_num].mac_inst, wn_eth_devices[eth_dev_num].eth_mdio_phyaddr, 17, &regA);

#endif    // End WARP_HW_VER_v3

	if(regA & ETHPHYREG_17_0_LINKUP) {
		status = LINK_READY;
	} else {
		status = LINK_NOT_READY;
	}

	return status;
}



/*****************************************************************************/
/**
* Initialize the TAG parameters structure
*
* @param    Pointer to info structure from which to pull all the tag parameter values
*
* @return	Total number of bytes of the TAG parameter structure
*
* @note     Please make sure that the *_info structure and the parameter values
*           maintain the same order
*
******************************************************************************/
int transport_init_parameters( unsigned int eth_dev_num, u32 *info ) {

	int              i;
	int              length;
	int              size;
	wn_tag_parameter temp_param;

    
    unsigned int       num_params = TRANSPORT_MAX_PARAMETER;
    wn_tag_parameter * parameters = (wn_tag_parameter *) &transport_parameters[eth_dev_num][0];

    
	// Initialize variables
	length = 0;
	size   = sizeof(wn_tag_parameter);

    for( i = 0; i < num_params; i++ ) {

    	// Set reserved space to 0xFF
    	temp_param.reserved = 0xFF;

    	// Common parameter settings
    	temp_param.group    = TRANS_GRP;
    	temp_param.command  = i;

    	// Any parameter specific code
    	switch ( i ) {
            case TRANSPORT_HW_ADDR:
    		    temp_param.length = 2;
    		break;

            default:
            	temp_param.length = 1;
    	    break;
    	}

    	// Set pointer to parameter values in info structure
        temp_param.value = &info[length];

        // Increment length so that we get the correct index in to info structure
        length += temp_param.length;

        // Copy the temp parameter to the tag parameter array
        memcpy( &parameters[i], &temp_param, size );
    }

    return ( ( size * i ) + ( length * 4 ) ) ;
}




/*****************************************************************************/
/**
*
* This function will populate a buffer with tag parameter information
*
* @param    eth_dev_num is an int that specifies the Ethernet interface to use
*           buffer is a u32 pointer to store the tag parameter information
*           max_words is a integer to specify the max number of u32 words in the buffer
*
* @return	number_of_words is number of words used of the buffer for the tag
*             parameter information
*
* @note		The tag parameters must be initialized before this function will be
*       called.  The user can modify the file to add additional functionality
*       to the WARPNet Transport.
*
******************************************************************************/
int transport_get_parameters(unsigned int eth_dev_num, u32 * buffer, unsigned int max_words, unsigned char network) {

    int i, j;
    int num_total_words;
    int num_param_words;

    u32 length;
    u32 temp_word;

    // NOTE:  This code is mostly portable between WARPNet components.
    //        Please modify  if you are copying this function for other WARPNet extensions    
    unsigned int       num_params = TRANSPORT_MAX_PARAMETER;
    wn_tag_parameter * parameters = (wn_tag_parameter *) &transport_parameters[eth_dev_num][0];
    
    
    // Initialize the total number of words used
    num_total_words = 0;
    
    // Iterate through all tag parameters
    for( i = 0; i < num_params; i++ ) {

        length = parameters[i].length;
    
        // The number of words in a tag parameter is the number of value words + 2 header words
        num_param_words = length + 2;
    
        // Make sure we have space in the buffer to put the parameter
        if ( ( num_total_words + num_param_words ) < max_words ) {
    
            temp_word = ( ( parameters[i].reserved << 24 ) | 
                          ( parameters[i].group    << 16 ) |
                          ( length                       ) );

            if ( network == TRANSMIT_OVER_NETWORK ) {

				buffer[num_total_words]     = Xil_Htonl( temp_word );
				buffer[num_total_words + 1] = Xil_Htonl( parameters[i].command );

				for( j = 0; j < length; j++ ) {
					buffer[num_total_words + 2 + j] = Xil_Htonl( parameters[i].value[j] );
				}

            } else {
            
				buffer[num_total_words]     = temp_word;
				buffer[num_total_words + 1] = parameters[i].command;

				for( j = 0; j < length; j++ ) {
					buffer[num_total_words + 2 + j] = parameters[i].value[j];
				}
            }

            num_total_words += num_param_words;
            
        } else {
            // Exit the loop because there is no more space
            break;
        }
    }
    
    return num_total_words;

}



#ifdef WARP_HW_VER_v3
/*****************************************************************************/
/**
*
* Debug printing functions
*
* @param    See function.
*
* @return	None.
*
* @note		None.
*
******************************************************************************/

#ifdef _DEBUG_

void print_XAxiEthernet_Config( XAxiEthernet_Config * ETH_CFG_ptr ) {

	xil_printf("Ethernet Config Pointer: \n");
    xil_printf("  DeviceId:          0x%x \n", ETH_CFG_ptr->DeviceId);
    xil_printf("  BaseAddress:       0x%x \n", ETH_CFG_ptr->BaseAddress);
    xil_printf("  TemacType:         0x%x \n", ETH_CFG_ptr->TemacType);
    xil_printf("  Checksum:     TX:  0x%x      RX: 0x%x\n", ETH_CFG_ptr->TxCsum, ETH_CFG_ptr->RxCsum );
    xil_printf("  PhyType:           0x%x \n", ETH_CFG_ptr->PhyType);
    xil_printf("  VlanTran:     TX:  0x%x      RX: 0x%x\n", ETH_CFG_ptr->TxVlanTran, ETH_CFG_ptr->RxVlanTran);
    xil_printf("  VlanTag:      TX:  0x%x      RX: 0x%x\n", ETH_CFG_ptr->TxVlanTag, ETH_CFG_ptr->RxVlanTag);
    xil_printf("  VlanStrp:     TX:  0x%x      RX: 0x%x\n", ETH_CFG_ptr->TxVlanStrp, ETH_CFG_ptr->RxVlanStrp);
    xil_printf("  ExtMcast:          0x%x \n", ETH_CFG_ptr->ExtMcast);
    xil_printf("  Stats:             0x%x \n", ETH_CFG_ptr->Stats);
    xil_printf("  Avb:               0x%x \n", ETH_CFG_ptr->Avb);
    xil_printf("  TemacIntr:         0x%x \n", ETH_CFG_ptr->TemacIntr);
    xil_printf("  AxiDevBaseAddress: 0x%x \n", ETH_CFG_ptr->AxiDevBaseAddress);
    xil_printf("  AxiDevType:        0x%x \n", ETH_CFG_ptr->AxiDevType);
    xil_printf("  AxiFifoIntr:       0x%x \n", ETH_CFG_ptr->AxiFifoIntr);
    xil_printf("  AxiDmaRxIntr:      0x%x \n", ETH_CFG_ptr->AxiDmaRxIntr);
    xil_printf("  AxiDmaTxIntr:      0x%x \n", ETH_CFG_ptr->AxiDmaTxIntr);
	xil_printf("\n");
}

#endif

#endif


#endif
