////////////////////////////////////////////////////////////////////////////////
// File   :	wlan_exp_node.c
// Authors:	Chris Hunter (chunter [at] mangocomm.com)
//			Patrick Murphy (murphpo [at] mangocomm.com)
//          Erik Welsh (welsh [at] mangocomm.com)
// License: Copyright 2013, Mango Communications. All rights reserved.
//          Distributed under the Mango Communications Reference Design License
//				See LICENSE.txt included in the design archive or
//				at http://mangocomm.com/802.11/license
////////////////////////////////////////////////////////////////////////////////


/***************************** Include Files *********************************/

#include "wlan_exp_common.h"
#include "wlan_exp_node.h"
#include "wlan_exp_transport.h"

#ifdef USE_WARPNET_WLAN_EXP

#include <xparameters.h>
#include <xil_io.h>
#include <Xio.h>
#include <stdlib.h>


// WLAN includes
#include "wlan_mac_ipc.h"
#include "wlan_mac_event_log.h"
#include "wlan_mac_events.h"
#include "wlan_mac_ltg.h"




/*************************** Constant Definitions ****************************/

// #define _DEBUG_

/*********************** Global Variable Definitions *************************/



/*************************** Variable Definitions ****************************/

wn_node_info       node_info;
wn_tag_parameter   node_parameters[NODE_MAX_PARAMETER];

wn_function_ptr_t  node_process_callback;
extern function_ptr_t check_queue_callback;

/*************************** Functions Prototypes ****************************/

int  node_init_parameters( u32 *info );
int  node_processCmd(const wn_cmdHdr* cmdHdr,const void* cmdArgs, wn_respHdr* respHdr,void* respArgs, void* pktSrc, unsigned int eth_dev_num);

void node_ltg_cleanup(u32 id, void* callback_arg);

#ifdef _DEBUG_
void print_wn_node_info( wn_node_info * info );
void print_wn_parameters( wn_tag_parameter *param, int num_params );
#endif





/******************************** Functions **********************************/


/*****************************************************************************/
/**
* Node Processes Null Callback
*
* This function is part of the callback system for processing node commands.
* If there are no additional node commands, then this will return appropriate values.
*
* To processes additional node commands, please set the node_process_callback
*
* @param    void * param  - Parameters for the callback
*
* @return	None.
*
* @note		None.
*
******************************************************************************/
int wlan_exp_null_process_callback(unsigned int cmdID, void* param){

	xil_printf("Unknown node command: %d\n", cmdID);

	return NO_RESP_SENT;
};



/*****************************************************************************/
/**
* Node Transport Processing
*
* This function is part of the callback system for the Ethernet transport.
* Based on the Command Group field in the header, it will call the appropriate
* processing function.
*
* @param    Message to Node   - WARPNet Host Message to the node
*           Message from Node - WARPNet Host Message from the node
*           Packet Source          - Ethernet Packet Source
*           Ethernet Device Number - Indicates which Ethernet device packet came from
*
* @return	None.
*
* @note		None.
*
******************************************************************************/
void node_rxFromTransport(wn_host_message* toNode, wn_host_message* fromNode, void* pktSrc, unsigned int eth_dev_num){
	unsigned char cmd_grp;

	unsigned int respSent;

#ifdef _DEBUG_
	xil_printf("In node_rxFromTransport() \n");
#endif

	//Helper struct pointers to interpret the received packet contents
	wn_cmdHdr* cmdHdr;
	void * cmdArgs;

	//Helper struct pointers to form a response packet
	wn_respHdr* respHdr;
	void * respArgs;

	cmdHdr  = (wn_cmdHdr*)(toNode->payload);
	cmdArgs = (toNode->payload) + sizeof(wn_cmdHdr);

	//Endian swap the command header (this is the first place we know what/where it is)
	cmdHdr->cmd     = Xil_Ntohl(cmdHdr->cmd);
	cmdHdr->length  = Xil_Ntohs(cmdHdr->length);
	cmdHdr->numArgs = Xil_Ntohs(cmdHdr->numArgs);

	//Outgoing response header must be endian swapped as it's filled in
	respHdr  = (wn_respHdr*)(fromNode->payload);
	respArgs = (fromNode->payload) + sizeof(wn_cmdHdr);

	cmd_grp = WN_CMD_TO_GRP(cmdHdr->cmd);
	switch(cmd_grp){
		case WARPNET_GRP:
		case NODE_GRP:
			respSent = node_processCmd(cmdHdr,cmdArgs,respHdr,respArgs, pktSrc, eth_dev_num);
		break;
		case TRANS_GRP:
			respSent = transport_processCmd(cmdHdr,cmdArgs,respHdr,respArgs, pktSrc, eth_dev_num);
		break;
		default:
			xil_printf("Unknown command group\n");
		break;
	}

	if(respSent == NO_RESP_SENT)	fromNode->length += (respHdr->length + sizeof(wn_cmdHdr));


	//Endian swap the response header before returning
	// Do it here so the transport sender doesn't have to understand any payload contents
	respHdr->cmd     = Xil_Ntohl(respHdr->cmd);
	respHdr->length  = Xil_Ntohs(respHdr->length);
	respHdr->numArgs = Xil_Ntohs(respHdr->numArgs);

	return;
}



/*****************************************************************************/
/**
* Node Send Early Response
*
* Allows a node to send a response back to the host before the command has
* finished being processed.  This is to minimize the latency between commands
* since the node is able to finish processing the command during the time
* it takes to communicate to the host and receive another command.
*
* @param    Response Header        - WARPNet Response Header
*           Packet Source          - Ethernet Packet Source
*           Ethernet Device Number - Indicates which Ethernet device packet came from
*
* @return	None.
*
* @note		None.
*
******************************************************************************/
void node_sendEarlyResp(wn_respHdr* respHdr, void* pktSrc, unsigned int eth_dev_num){
	/* This function is used to send multiple command responses back to the host
	 * under the broader umbrella of a single command exchange. The best example
	 * of this functionality is a 'readIQ' command where a single packet from
	 * the host results in many response packets returning from the board.
	 *
	 * A key assumption in the use of this function is that the underlying command
	 * from the host does not raise the transport-level ACK flag in the transport
	 * header. Furthermore, this function exploits the fact that wn_node can determine
	 * the beginning of the overall send buffer from the location of the response to
	 * be sent.
	 */

	 wn_host_message nodeResp;

#ifdef _DEBUG_
	 xil_printf("In node_sendEarlyResp() \n");
#endif

	 nodeResp.payload = (void*) respHdr;
	 nodeResp.buffer  = (void*) respHdr - ( PAYLOAD_OFFSET + sizeof(wn_transport_header) );
	 nodeResp.length  = PAYLOAD_PAD_NBYTES + respHdr->length + sizeof(wn_cmdHdr); //Extra 2 bytes is for alignment

	//Endian swap the response header before before transport sends it
	// Do it here so the transport sender doesn't have to understand any payload contents
	respHdr->cmd     = Xil_Ntohl(respHdr->cmd);
	respHdr->length  = Xil_Ntohs(respHdr->length);
	respHdr->numArgs = Xil_Ntohs(respHdr->numArgs);

#ifdef _DEBUG_
	xil_printf("sendEarlyResp\n");
	xil_printf("payloadAddr = 0x%x, bufferAddr = 0x%x, len = %d\n",nodeResp.payload,nodeResp.buffer,nodeResp.length);
#endif

	 transport_send(&nodeResp, pktSrc, eth_dev_num);

}



/*****************************************************************************/
/**
* Node Commands
*
* This function is part of the callback system for the Ethernet transport
* and will be executed when a valid node commands is recevied.
*
* @param    Command Header         - WARPNet Command Header
*           Command Arguments      - WARPNet Command Arguments
*           Response Header        - WARPNet Response Header
*           Response Arguments     - WARPNet Response Arguments
*           Packet Source          - Ethernet Packet Source
*           Ethernet Device Number - Indicates which Ethernet device packet came from
*
* @return	None.
*
* @note		See on-line documentation for more information about the ethernet
*           packet structure for WARPNet:  www.warpproject.org
*
******************************************************************************/
int node_processCmd(const wn_cmdHdr* cmdHdr,const void* cmdArgs, wn_respHdr* respHdr,void* respArgs, void* pktSrc, unsigned int eth_dev_num){
	//IMPORTANT ENDIAN NOTES:
	// -cmdHdr is safe to access directly (pre-swapped if needed)
	// -cmdArgs is *not* pre-swapped, since the framework doesn't know what it is
	// -respHdr will be swapped by the framework; user code should fill it normally
	// -respArgs will *not* be swapped by the framework, since only user code knows what it is
	//    Any data added to respArgs by the code below must be endian-safe (swapped on AXI hardware)

	int           status     = 0;
	const u32   * cmdArgs32  = cmdArgs;
	u32         * respArgs32 = respArgs;

	unsigned int  respIndex  = 0;
	unsigned int  respSent   = NO_RESP_SENT;
    unsigned int  max_words  = 320;                // Max number of u32 words that can be sent in the packet (~1400 bytes)
                                                   //   If we need more, then we will need to rework this to send multiple response packets

    unsigned int  temp, i;

    // Variables for functions
    u32           id;
    u32           flags;
	u32           start_address;
	u32           curr_address;
	u32           next_address;
	u32           size;
	u32           evt_log_size;
	u32           transfer_size;
	u32           bytes_per_pkt;
	u32           num_bytes;
	u32           num_pkts;

	u32           interval;


	unsigned int  cmdID;
    
	cmdID = WN_CMD_TO_CMDID(cmdHdr->cmd);
    
	respHdr->cmd     = cmdHdr->cmd;
	respHdr->length  = 0;
	respHdr->numArgs = 0;

#ifdef _DEBUG_
	xil_printf("In node_processCmd():  ID = %d \n", cmdID);
#endif

	switch(cmdID){

	    //---------------------------------------------------------------------
        case WARPNET_TYPE:
        	// Return the WARPNet Type
            respArgs32[respIndex++] = Xil_Htonl( node_info.type );    
        
			respHdr->length += (respIndex * sizeof(respArgs32));
			respHdr->numArgs = respIndex;
        break;
        
    
	    //---------------------------------------------------------------------
		case NODE_INFO:
			// Return the info about the WLAN_EXP_NODE
            
            // Send node parameters
            temp = node_get_parameters( &respArgs32[respIndex], max_words, TRANSMIT_OVER_NETWORK);
            respIndex += temp;
            max_words -= temp;
            if ( max_words <= 0 ) { xil_printf("No more space left in NODE_INFO packet \n"); };
            
            // Send transport parameters
            temp = transport_get_parameters( eth_dev_num, &respArgs32[respIndex], max_words, TRANSMIT_OVER_NETWORK);
            respIndex += temp;
            max_words -= temp;
            if ( max_words <= 0 ) { xil_printf("No more space left in NODE_INFO packet \n"); };

#ifdef _DEBUG_
            xil_printf("NODE INFO: \n");
            for ( i = 0; i < respIndex; i++ ) {
            	xil_printf("   [%2d] = 0x%8x \n", i, respArgs32[i]);
            }
            xil_printf("END NODE INFO \n");
#endif

            // --------------------------------
            // Future parameters go here
            // --------------------------------
                        
            // Finalize response
			respHdr->length += (respIndex * sizeof(respArgs32));
			respHdr->numArgs = respIndex;
		break;
        

	    //---------------------------------------------------------------------
		case NODE_IDENTIFY:
			// Return Null Response
			//   The WLAN_EXP_NODE currently does not have access to LEDs

            xil_printf("  Node: %d    IP Address: %d.%d.%d.%d \n", node_info.node, node_info.ip_addr[0], node_info.ip_addr[1],node_info.ip_addr[2],node_info.ip_addr[3]);

            // --------------------------------
            // TODO:  Add in visual identifiers for the node
            // --------------------------------
        break;


	    //---------------------------------------------------------------------
		case NODE_CONFIG_SETUP:
            // NODE_CONFIG_SETUP Packet Format:
            //   - Note:  All u32 parameters in cmdArgs32 are byte swapped so use Xil_Ntohl()
            //
            //   - cmdArgs32[0] - Serial Number
            //   - cmdArgs32[1] - Node ID
            //   - cmdArgs32[2] - IP Address
            //   - cmdArgs32[3] - Unicast Port
            //   - cmdArgs32[4] - Broadcast Port
            // 
            if ( node_info.node == 0xFFFF ) {
                // Only update the parameters if the serial numbers match
                if ( node_info.serial_number ==  Xil_Ntohl(cmdArgs32[0]) ) {

                    xil_printf("  Reconfiguring ETH %c \n", wn_conv_eth_dev_num(eth_dev_num) );

                	node_info.node = Xil_Ntohl(cmdArgs32[1]) & 0xFFFF;

                    xil_printf("  New Node ID       : %d \n", node_info.node);
                    
                    // Grab New IP Address
                    node_info.ip_addr[0]     = (Xil_Ntohl(cmdArgs32[2]) >> 24) & 0xFF;
                    node_info.ip_addr[1]     = (Xil_Ntohl(cmdArgs32[2]) >> 16) & 0xFF;
                    node_info.ip_addr[2]     = (Xil_Ntohl(cmdArgs32[2]) >>  8) & 0xFF;
                    node_info.ip_addr[3]     = (Xil_Ntohl(cmdArgs32[2])      ) & 0xFF;
                    
                    // Grab new ports
                    node_info.unicast_port   = Xil_Ntohl(cmdArgs32[3]);
                    node_info.broadcast_port = Xil_Ntohl(cmdArgs32[4]);

                    xil_printf("  New IP Address    : %d.%d.%d.%d \n", node_info.ip_addr[0], node_info.ip_addr[1],node_info.ip_addr[2],node_info.ip_addr[3]);
                    xil_printf("  New Unicast Port  : %d \n", node_info.unicast_port);
                    xil_printf("  New Broadcast Port: %d \n", node_info.broadcast_port);

                    transport_set_hw_info( eth_dev_num, node_info.ip_addr, node_info.hw_addr);

                    status = transport_config_sockets(eth_dev_num, node_info.unicast_port, node_info.broadcast_port);

                    if(status != 0) {
        				xil_printf("Error binding transport...\n");
        			}
                } else {
                    xil_printf("NODE_IP_SETUP Packet with Serial Number %d ignored.  My serial number is %d \n", Xil_Ntohl(cmdArgs32[0]), node_info.serial_number);
                }
            }
		break;

        
	    //---------------------------------------------------------------------
		case NODE_CONFIG_RESET:
            // NODE_CONFIG_RESET Packet Format:
            //   - Note:  All u32 parameters in cmdArgs32 are byte swapped so use Xil_Ntohl()
            //
            //   - cmdArgs32[0] - Serial Number
            // 
            
            // Send the response early so that M-Code does not hang when IP address changes
			node_sendEarlyResp(respHdr, pktSrc, eth_dev_num);
			respSent = RESP_SENT;
            
            // Only update the parameters if the serial numbers match
            if ( node_info.serial_number ==  Xil_Ntohl(cmdArgs32[0]) ) {

                // Reset node to 0xFFFF
                node_info.node = 0xFFFF;

                xil_printf("\n!!! Reseting Network Configuration !!! \n\n");        
                
                // Reset transport;  This will update the IP Address back to default and rebind the sockets
                //   - See below for default IP address:  NODE_IP_ADDR_BASE + node
                node_info.ip_addr[0]      = (NODE_IP_ADDR_BASE >> 24) & 0xFF;
                node_info.ip_addr[1]      = (NODE_IP_ADDR_BASE >> 16) & 0xFF;
                node_info.ip_addr[2]      = (NODE_IP_ADDR_BASE >>  8) & 0xFF;
                node_info.ip_addr[3]      = (NODE_IP_ADDR_BASE      ) & 0xFF;  // IP ADDR = w.x.y.z

                node_info.unicast_port    = NODE_UDP_UNICAST_PORT_BASE;
                node_info.broadcast_port  = NODE_UDP_MCAST_BASE;

                transport_set_hw_info(eth_dev_num, node_info.ip_addr, node_info.hw_addr);
                transport_config_sockets(eth_dev_num, node_info.unicast_port, node_info.broadcast_port);

                // Update User IO
                xil_printf("\n!!! Waiting for Network Configuration via Matlab !!! \n\n");        
            
            } else {
                xil_printf("NODE_IP_RESET Packet with Serial Number %d ignored.  My serial number is %d \n", Xil_Ntohl(cmdArgs32[0]), node_info.serial_number);
            }
		break;


		// Case NODE_ASSN_GET_STATUS  is implemented in the child classes

		// Case NODE_ASSN_SET_TABLE   is implemented in the child classes

		// Case NODE_ASSN_RESET_STATS is implemented in the child classes

		// Case NODE_DISASSOCIATE     is implemented in the child classes


	    //---------------------------------------------------------------------
		// TODO:  THIS FUNCTION IS NOT COMPLETE
		case NODE_TX_POWER:
			// Get node TX power
			temp = Xil_Ntohl(cmdArgs32[0]);

			// If parameter is not the magic number, then set the TX power
			if ( temp != 0xFFFF ) {

				// TODO: Set the TX power
			    xil_printf("Setting TX power = %d\n", temp);
			}

			// Send response of current power
            respArgs32[respIndex++] = Xil_Htonl( temp );

			respHdr->length += (respIndex * sizeof(respArgs32));
			respHdr->numArgs = respIndex;
		break;


		// Case NODE_TX_RATE is implemented in the child classes

		// Case NODE_CHANNEL is implemented in the child classes


	    //---------------------------------------------------------------------
		case NODE_LTG_CONFIG_CBR:
            // NODE_LTG_START Packet Format:
			//   - cmdArgs32[0]  - LTG ID
			//   - cmdArgs32[1]  - traffic interval (us)
			//   - cmdArgs32[2]  - traffic length   (bytes)
			//
            //   - respArgs32[0] - 0           - Success
			//                     0xFFFF_FFFF - Failure

			// Get arguments
			id       = Xil_Ntohl(cmdArgs32[0]);
			interval = Xil_Ntohl(cmdArgs32[1]);
            size     = Xil_Ntohl(cmdArgs32[2]);

            // Check arguments
            if ( size > 1500 ) { size = 1500; }       // TODO: This should be LTG_PAYLOAD_MAX and not a magic number

            // Local variables
			void*                       ltg_callback_arg;
        	ltg_sched_periodic_params   periodic_params;

            // Check to see if LTG ID already exists
			if( ltg_sched_get_callback_arg( id, &ltg_callback_arg ) == 0 ) {
				// This LTG has already been configured. We need to free the old callback argument so we can create a new one.
				ltg_sched_stop( id );
				wlan_free( ltg_callback_arg );
			}

			// Set up CBR traffic flow
			periodic_params.interval_usec = interval;

			ltg_callback_arg = wlan_malloc(sizeof(ltg_pyld_fixed));

			if( ltg_callback_arg != NULL ) {
				((ltg_pyld_fixed*)ltg_callback_arg)->hdr.type = LTG_PYLD_TYPE_FIXED;
				((ltg_pyld_fixed*)ltg_callback_arg)->length   = size;

				// Configure the LTG
				status = ltg_sched_configure( id, LTG_SCHED_TYPE_PERIODIC, &periodic_params, ltg_callback_arg, &node_ltg_cleanup );

				xil_printf("CBR LTG %d configured:  interval of %d (us) with size of %d bytes\n", id, interval, size);

			} else {
				xil_printf("ERROR:  LTG - Error allocating memory for ltg_callback_arg\n");
				status = 0xFFFFFFFF;
			}

			// Send response of current channel
            respArgs32[respIndex++] = Xil_Htonl( status );

			respHdr->length += (respIndex * sizeof(respArgs32));
			respHdr->numArgs = respIndex;
		break;


	    //---------------------------------------------------------------------
		case NODE_LTG_START:
            // NODE_LTG_START Packet Format:
			//   - cmdArgs32[0]  - ltg id
			//                       0xFFFF_FFFF  -> Start all IDs
			//
            //   - respArgs32[0] - 0           - Success
			//                     0xFFFF_FFFF - Failure

			// Get ID
			temp = Xil_Ntohl(cmdArgs32[0]);

			// If parameter is not the magic number, then start the LTG
			if ( temp != 0xFFFFFFFF ) {
                // Try to start the ID
		        status = ltg_sched_start( temp );

		        if ( status != 0 ) {
					xil_printf("WARNING:  LTG - LTG %d failed to start.\n", temp);
		        	status = 0xFFFFFFFF;
		        } else {
					xil_printf("Starting LTG %d.\n", temp);
			    }
			} else {
				// Start all LTGs

				// TODO: Need ltg_sched_start_all()
				xil_printf("WARNING:  LTG - LTG 0x%8x failed to start.\n", temp);
				status = 0xFFFFFFFF;
			}

			// Send response of current rate
            respArgs32[respIndex++] = Xil_Htonl( status );

			respHdr->length += (respIndex * sizeof(respArgs32));
			respHdr->numArgs = respIndex;
		break;


	    //---------------------------------------------------------------------
		case NODE_LTG_STOP:
            // NODE_LTG_STOP Packet Format:
			//   - cmdArgs32[0]  - ltg id
			//                       0xFFFF_FFFF  -> Stop all IDs
			//
            //   - respArgs32[0] - 0           - Success
			//                     0xFFFF_FFFF - Failure

			// Get ID
			temp = Xil_Ntohl(cmdArgs32[0]);

			// If parameter is not the magic number, then stop the LTG
			if ( temp != 0xFFFFFFFF ) {
                // Try to stop the ID
		        status = ltg_sched_stop( temp );

		        if ( status != 0 ) {
					xil_printf("WARNING:  LTG - LTG %d failed to stop.\n", temp);
		        	status = 0xFFFFFFFF;
		        } else {
					xil_printf("Stopping LTG %d.\n", temp);
			    }

//TODO DISABLE INTERRUPTS
		        purge_queue(temp);
		        check_queue_callback();
//TODO ENABLE INTERRUPTS

			} else {
				// Stop all LTGs

				//TODO: need a purge_queue(ALL)

				// TODO: Need ltg_sched_stop_all()
				xil_printf("WARNING:  LTG - LTG 0x%8x failed to stop.\n", temp);
				status = 0xFFFFFFFF;
			}

			// Send response of current rate
            respArgs32[respIndex++] = Xil_Htonl( status );

			respHdr->length += (respIndex * sizeof(respArgs32));
			respHdr->numArgs = respIndex;
		break;


	    //---------------------------------------------------------------------
		case NODE_LTG_REMOVE:
            // NODE_LTG_REMOVE Packet Format:
			//   - cmdArgs32[0]  - ltg id
			//                       0xFFFF_FFFF  -> Remove all IDs
			//
            //   - respArgs32[0] - 0           - Success
			//                     0xFFFF_FFFF - Failure

			// Get ID
			temp = Xil_Ntohl(cmdArgs32[0]);

			// If parameter is not the magic number, then remove the LTG
			if ( temp != 0xFFFFFFFF ) {
                // Try to remove the ID
		        status = ltg_sched_remove( temp );

		        if ( status != 0 ) {
					xil_printf("WARNING:  LTG - LTG %d failed to remove.\n", temp);
		        	status = 0xFFFFFFFF;
		        } else {
					xil_printf("Removing LTG %d.\n", temp);
			    }
			} else {
				// Remove all LTGs
		        status = ltg_sched_remove( LTG_REMOVE_ALL );

		        if ( status != 0 ) {
					xil_printf("WARNING:  LTG - Failed to remove all LTGs.\n");
		        	status = 0xFFFFFFFF;
		        } else {
					xil_printf("Removing All LTGs.\n");
			    }
			}

			// Send response of status
            respArgs32[respIndex++] = Xil_Htonl( status );

			respHdr->length += (respIndex * sizeof(respArgs32));
			respHdr->numArgs = respIndex;
		break;


	    //---------------------------------------------------------------------
		case NODE_LOG_RESET:
			xil_printf("EVENT LOG:  Reset log\n");

			event_log_reset();
	    break;


	    //---------------------------------------------------------------------
		case NODE_LOG_CONFIG:
            // NODE_LOG_CONFIG Packet Format:
			//   - cmdArgs32[0]  - flags
			//                       - [ 0] - Wrap = 1; No Wrap = 0;
			//
            //   - respArgs32[0] - 0           - Success
			//                     0xFFFF_FFFF - Failure

			// Set the return value
			status = 0;

			// Get flags
			temp = Xil_Ntohl(cmdArgs32[0]);

            // Local Defines for flag bits
            #define NODE_LTG_FLAG_WRAP      0x00000001

			// Configure the LTG based on the flag bits
			if ( ( temp & NODE_LTG_FLAG_WRAP ) == NODE_LTG_FLAG_WRAP ) {
				event_log_config_wrap( EVENT_LOG_WRAP_ENABLE );
			} else {
				event_log_config_wrap( EVENT_LOG_WRAP_DISABLE );
			}

			// Send response of status
            respArgs32[respIndex++] = Xil_Htonl( status );

			respHdr->length += (respIndex * sizeof(respArgs32));
			respHdr->numArgs = respIndex;
	    break;


	    //---------------------------------------------------------------------
		case NODE_LOG_GET_CURR_IDX:
			// Get the current index of the log
			temp = event_log_get_current_index();

			xil_printf("EVENT LOG:  Current index = %d\n", temp);

			// Send response of current index
            respArgs32[respIndex++] = Xil_Htonl( temp );

			respHdr->length += (respIndex * sizeof(respArgs32));
			respHdr->numArgs = respIndex;
	    break;


	    //---------------------------------------------------------------------
		case NODE_LOG_GET_OLDEST_IDX:
			// Get the current index of the log
			temp = event_log_get_oldest_event_index();

			xil_printf("EVENT LOG:  Oldest index  = %d\n", temp);

			// Send response of oldest index
            respArgs32[respIndex++] = Xil_Htonl( temp );

			respHdr->length += (respIndex * sizeof(respArgs32));
			respHdr->numArgs = respIndex;
	    break;


	    //---------------------------------------------------------------------
		case NODE_LOG_GET_EVENTS:
            // NODE_GET_EVENTS Packet Format:
            //   - Note:  All u32 parameters in cmdArgs32 are byte swapped so use Xil_Ntohl()
            //
			//   - cmdArgs32[0] - buffer id
			//   - cmdArgs32[1] - flags
            //   - cmdArgs32[2] - start_address of transfer
			//   - cmdArgs32[3] - size of transfer (in bytes)
			//                      0xFFFF_FFFF  -> Get everything in the event log
			//
			//   Return Value:
			//     - wn_buffer
            //       - buffer_id  - uint32  - ID of the buffer
			//       - flags      - uint32  - Flags
			//       - start_byte - uint32  - Byte index of the first byte in this packet
			//       - size       - uint32  - Number of payload bytes in this packet
			//       - byte[]     - uint8[] - Array of payload bytes
			//
			// NOTE:  The address passed via the command is the address relative to the current
			//   start of the event log.  It is not an absolute address and should not be treated
			//   as such.
			//
			//     When you transferring "everything" in the event log, the command will take a
			//   snapshot of the size of the log at the time the command is received.  It will then
			//   only transfer those events and not any new events that are added to the log while
			//   we are transferring the current log.
            //

			id                = Xil_Ntohl(cmdArgs32[0]);
			flags             = Xil_Ntohl(cmdArgs32[1]);
			start_address     = Xil_Ntohl(cmdArgs32[2]);
            size              = Xil_Ntohl(cmdArgs32[3]);

            // Get the current size of the event log
            evt_log_size      = event_log_get_size();

            // Check if we should transfer everything or if the request was larger than the current log
            if ( ( size == 0xFFFFFFFF ) || ( size > evt_log_size ) ) {
                size = evt_log_size;
            }

            bytes_per_pkt     = max_words * 4;
            num_pkts          = size / bytes_per_pkt + 1;
            curr_address      = start_address;

#ifdef _DEBUG_
			xil_printf("WLAN EXP NODE_GET_EVENTS \n");
			xil_printf("    start_address    = 0x%8x\n    size             = %10d\n    num_pkts         = %10d\n", start_address, size, num_pkts);
#endif

            // Initialize constant parameters
            respArgs32[0] = Xil_Htonl( id );
            respArgs32[1] = Xil_Htonl( flags );

            // Iterate through all the packets
			for( i = 0; i < num_pkts; i++ ) {

				// Get the next address
				next_address  = curr_address + bytes_per_pkt;

				// Compute the transfer size (use the full buffer unless you run out of space)
				if( next_address > ( start_address + size ) ) {
                    transfer_size = (start_address + size) - curr_address;

				} else {
					transfer_size = bytes_per_pkt;
				}

				// Set response args that change per packet
	            respArgs32[2]   = Xil_Htonl( curr_address );
                respArgs32[3]   = Xil_Htonl( transfer_size );

                // Unfortunately, due to the byte swapping that occurs in node_sendEarlyResp, we need to set all 
                //   three command parameters for each packet that is sent.
	            respHdr->cmd     = cmdHdr->cmd;
	            respHdr->length  = 16 + transfer_size;
				respHdr->numArgs = 4;

				// Transfer data
				num_bytes = event_log_get_data( curr_address, transfer_size, (char *) &respArgs32[4] );

#ifdef _DEBUG_
				xil_printf("Packet %8d: \n", i);
				xil_printf("    transfer_address = 0x%8x\n    transfer_size    = %10d\n    num_bytes        = %10d\n", curr_address, transfer_size, num_bytes);
#endif

				// Check that we copied everything
				if ( num_bytes == transfer_size ) {
					// Send the packet
					node_sendEarlyResp(respHdr, pktSrc, eth_dev_num);
				} else {
					xil_printf("ERROR:  NODE_GET_EVENTS tried to get %d bytes, but only received %d @ 0x%x \n", transfer_size, num_bytes, curr_address );
				}

				// Update our current address
				curr_address = next_address;
			}

			respSent = RESP_SENT;
		break;


		//---------------------------------------------------------------------
		// TODO:  THIS FUNCTION IS NOT COMPLETE
		case NODE_LOG_ADD_EVENT:
			xil_printf("EVENT LOG:  Add Event not supported\n");
	    break;


		//---------------------------------------------------------------------
		// TODO:  THIS FUNCTION IS NOT COMPLETE
		case NODE_LOG_ENABLE_EVENT:
			xil_printf("EVENT LOG:  Enable Event not supported\n");
	    break;


		//---------------------------------------------------------------------
		default:
			// Call standard function in child class to parse parameters implmented there
			respSent = node_process_callback( cmdID, cmdHdr, cmdArgs, respHdr, respArgs, pktSrc, eth_dev_num);
		break;
	}

	return respSent;
}



/*****************************************************************************/
/**
* This will initialize the WARPNet WLAN_EXP node with the appropriate information
* and set up the node to communicate with WARPNet on the given ethernet device. 
*
* @param    None.
*
* @return	 0 - Success
*           -1 - Failure
*
* @note		This function will print to the terminal but is not able to control any of the LEDs
*
******************************************************************************/
int wlan_exp_node_init( unsigned int type, unsigned int serial_number, unsigned int *fpga_dna, unsigned int eth_dev_num, unsigned char *hw_addr ) {

    int i;
	int status = SUCCESS;

	xil_printf("WARPNet WLAN EXP v%d.%d.%d (compiled %s %s)\n", WARPNET_VER_MAJOR, WARPNET_VER_MINOR, WARPNET_VER_REV, __DATE__, __TIME__);

	// Initialize Global variables
	//   Node must be configured using the WARPNet nodesConfig
	//   HW must be WARP v3
	//   IP Address should be NODE_IP_ADDR_BASE
    node_info.type            = type;
    node_info.node            = 0xFFFF;
    node_info.hw_generation   = WARP_HW_VERSION;
    node_info.design_ver      = (WARPNET_VER_MAJOR<<16)|(WARPNET_VER_MINOR<<8)|(WARPNET_VER_REV);

    node_info.serial_number   = serial_number;
    
    for( i = 0; i < FPGA_DNA_LEN; i++ ) {
        node_info.fpga_dna[i] = fpga_dna[i];
    }
    
    // WLAN Exp Parameters are assumed to be initialize already
    //    node_info.wlan_max_assn
    //    node_info.wlan_event_log_size

    node_info.eth_device      = eth_dev_num;
    
	node_info.ip_addr[0]      = (NODE_IP_ADDR_BASE >> 24) & 0xFF;
	node_info.ip_addr[1]      = (NODE_IP_ADDR_BASE >> 16) & 0xFF;
	node_info.ip_addr[2]      = (NODE_IP_ADDR_BASE >>  8) & 0xFF;
	node_info.ip_addr[3]      = (NODE_IP_ADDR_BASE      ) & 0xFF;  // IP ADDR = w.x.y.z
    
    for ( i = 0; i < ETH_ADDR_LEN; i++ ) {
        node_info.hw_addr[i]  = hw_addr[i];
    }
    
    node_info.unicast_port    = NODE_UDP_UNICAST_PORT_BASE;
    node_info.broadcast_port  = NODE_UDP_MCAST_BASE;


    // Set up callback for process function
    node_process_callback     = (wn_function_ptr_t)wlan_exp_null_process_callback;

    
    // Initialize Tag parameters
    node_init_parameters( (u32*)&node_info );
    

#ifdef _DEBUG_
    print_wn_node_info( &node_info );
    print_wn_parameters( (wn_tag_parameter *)&node_parameters, NODE_MAX_PARAMETER );
#endif

    
    // Transport initialization
	//   NOTE:  These errors are fatal and status error will be displayed
	//       on the hex display.  Also, please attach a USB cable for
	//       terminal debug messages.
	status = transport_init( node_info.node, node_info.eth_device, node_info.ip_addr, node_info.hw_addr, node_info.unicast_port, node_info.broadcast_port );
	if(status != 0) {
        xil_printf("  Error in transport_init()! Exiting...\n");
        return FAILURE;
	}

#ifdef 	WLAN_EXP_WAIT_FOR_ETH

	xil_printf("  Waiting for Ethernet link ... ");
	while( transport_linkStatus( eth_dev_num ) != 0 );
	xil_printf("  Initialization Successful\n");

#else

	xil_printf("  Not waiting for Ethernet link.  Current status is: ");

	if ( transport_linkStatus( eth_dev_num ) == LINK_READY ) {
		xil_printf("ready.\n");
	} else {
		xil_printf("not ready.\n");
		xil_printf("    Make sure link is ready before using WARPNet.\n");
	}

#endif

	//Assign the new packet callback
	// IMPORTANT: must be called after transport_init()
	transport_setReceiveCallback( (void *)node_rxFromTransport );

	// If you are in configure over network mode, then indicate that to the user
	if ( node_info.node == 0xFFFF ) {
		xil_printf("  !!! Waiting for Network Configuration !!! \n");
	}

	xil_printf("End WARPNet WLAN Exp initialization\n");
	return status;
}



/*****************************************************************************/
/**
* Set the node process callback
*
* @param    Pointer to the callback
*
* @return	None.
*
* @note     None.
*
******************************************************************************/
void node_set_process_callback(void(*callback)()){
	node_process_callback = (wn_function_ptr_t)callback;
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
int node_init_parameters( u32 *info ) {

	int              i;
	int              length;
	int              size;
	wn_tag_parameter temp_param;

    
    unsigned int       num_params = NODE_MAX_PARAMETER;
    wn_tag_parameter * parameters = (wn_tag_parameter *)&node_parameters;

    
	// Initialize variables
	length = 0;
	size   = sizeof(wn_tag_parameter);

    for( i = 0; i < num_params; i++ ) {

    	// Set reserved space to 0xFF
    	temp_param.reserved = 0xFF;

    	// Common parameter settings
    	temp_param.group    = NODE_GRP;
    	temp_param.command  = i;

    	// Any parameter specific code
    	switch ( i ) {
            case NODE_FPGA_DNA:
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
int node_get_parameters(u32 * buffer, unsigned int max_words, unsigned char network) {

    int i, j;
    int num_total_words;
    int num_param_words;

    u32 length;
    u32 temp_word;

    // NOTE:  This code is mostly portable between WARPNet components.
    //        Please modify  if you are copying this function for other WARPNet extensions    
    unsigned int       num_params = NODE_MAX_PARAMETER;
    wn_tag_parameter * parameters = (wn_tag_parameter *) &node_parameters;
    
    
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



/*****************************************************************************/
/**
* These are helper functions to set some node_info fields
*
* @param    field value
*
* @return	None.
*
* @note		None.
*
******************************************************************************/
void node_info_set_max_assn      ( u32 max_assn ) { node_info.wlan_max_assn       = max_assn; }
void node_info_set_event_log_size( u32 log_size ) { node_info.wlan_event_log_size = log_size; }




/*****************************************************************************/
/**
* This is a helper function to clean up the LTGs owned by WLAN Exp
*
* @param    id            - LTG id
*           callback_arg  - Callback argument for LTG
*
* @return	None.
*
* @note		None.
*
******************************************************************************/
void node_ltg_cleanup(u32 id, void* callback_arg){
	wlan_free( callback_arg );
}




#ifdef _DEBUG_

/*****************************************************************************/
/**
* Print Tag Parameters
*
* This function will print a list of wn_tag_parameter structures
*
* @param    param      - pointer to the wn_tag_parameter list
*           num_params - number of wn_tag_parameter structures in the list
*
* @return	None.
*
* @note		None.
*
******************************************************************************/
void print_wn_parameters( wn_tag_parameter *param, int num_params ) {

	int i, j;

	xil_printf("Node Parameters: \n");

    for( i = 0; i < num_params; i++ ){
    	xil_printf("  Parameter %d:\n", i);
    	xil_printf("    Group:            %d \n",   param[i].group);
    	xil_printf("    Length:           %d \n",   param[i].length);
    	xil_printf("    Command:          %d \n",   param[i].command);

    	for( j = 0; j < param[i].length; j++ ) {
    		xil_printf("    Value[%2d]:        0x%8x \n",   j, param[i].value[j]);
    	}
    }

    xil_printf("\n");
}



/*****************************************************************************/
/**
* Print Node Info
*
* This function will print a wn_node_info structure
*
* @param    info    - pointer to wn_node_info structure to print
*
* @return	None.
*
* @note		None.
*
******************************************************************************/
void print_wn_node_info( wn_node_info * info ) {
    int i;

	xil_printf("WARPNet Node Information: \n");
    xil_printf("  WARPNet Type:       0x%8x \n",   info->type);    
    xil_printf("  Node ID:            %d \n",      info->node);
    xil_printf("  HW Generation:      %d \n",      info->hw_generation);
    xil_printf("  HW Design Version:  0x%x \n",    info->design_ver);
    
    xil_printf("  Serial Number:      0x%x \n",    info->serial_number);
    xil_printf("  FPGA DNA:           ");
    
    for( i = 0; i < FPGA_DNA_LEN; i++ ) {
        xil_printf("0x%8x  ", info->fpga_dna[i]);
    }
	xil_printf("\n");
        
    xil_printf("  HW Address:         %02x",       info->hw_addr[0]);
                                              
    for( i = 1; i < ETH_ADDR_LEN; i++ ) {
        xil_printf(":%02x", info->hw_addr[i]);
    }
	xil_printf("\n");
                                                                                            
    xil_printf("  IP Address 0:       %d",         info->ip_addr[0]);
    
    for( i = 1; i < IP_VERSION; i++ ) {
        xil_printf(".%d", info->ip_addr[i]);
    }
	xil_printf("\n");

    xil_printf("  Unicast Port:       %d \n",      info->unicast_port);
    xil_printf("  Broadcast Port:     %d \n",      info->broadcast_port);
	xil_printf("\n");
    
}

#endif


// End USE_WARPNET_WLAN_EXP
#endif
