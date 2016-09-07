////////////////////////////////////////////////////////////////////////////////
// File   :	wlan_exp_node_ap.c
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
#include "wlan_exp_node_sta.h"

#ifdef USE_WARPNET_WLAN_EXP

// Xilinx includes
#include <xparameters.h>
#include <xil_io.h>
#include <Xio.h>
#include "xintc.h"


// Library includes
#include "string.h"
#include "stdlib.h"

//WARP includes
#include "wlan_mac_ipc_util.h"
#include "wlan_mac_ipc.h"
#include "wlan_mac_misc_util.h"
#include "wlan_mac_802_11_defs.h"
#include "wlan_mac_queue.h"
#include "wlan_mac_event_log.h"
#include "wlan_mac_ltg.h"
#include "wlan_mac_util.h"
#include "wlan_mac_packet_types.h"
#include "wlan_mac_eth_util.h"
#include "wlan_mac_sta.h"



/*************************** Constant Definitions ****************************/


/*********************** Global Variable Definitions *************************/

extern station_info   access_point;
extern char*          access_point_ssid;

extern ap_info      * ap_list;
extern u8             num_ap_list;
extern u8             active_scan;
extern u8             pause_queue;

extern int            association_state;

extern u32            mac_param_chan;
extern u32            mac_param_chan_save;

extern u8             access_point_num_basic_rates;
extern u8             access_point_basic_rates[NUM_BASIC_RATES_MAX];

extern u8             default_unicast_rate;


/*************************** Variable Definitions ****************************/


/*************************** Functions Prototypes ****************************/


/******************************** Functions **********************************/


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
int wlan_exp_node_sta_processCmd( unsigned int cmdID, const wn_cmdHdr* cmdHdr, const void* cmdArgs, wn_respHdr* respHdr, void* respArgs, void* pktSrc, unsigned int eth_dev_num){
	//IMPORTANT ENDIAN NOTES:
	// -cmdHdr is safe to access directly (pre-swapped if needed)
	// -cmdArgs is *not* pre-swapped, since the framework doesn't know what it is
	// -respHdr will be swapped by the framework; user code should fill it normally
	// -respArgs will *not* be swapped by the framework, since only user code knows what it is
	//    Any data added to respArgs by the code below must be endian-safe (swapped on AXI hardware)

	const u32   * cmdArgs32  = cmdArgs;
	u32         * respArgs32 = respArgs;

	unsigned int  respIndex  = 0;                  // This function is called w/ same state as node_processCmd
	unsigned int  respSent   = NO_RESP_SENT;       // Initialize return value to NO_RESP_SENT
    unsigned int  max_words  = 300;                // Max number of u32 words that can be sent in the packet (~1200 bytes)
                                                   //   If we need more, then we will need to rework this to send multiple response packets
    unsigned int  status;
    unsigned int  temp, i;
    unsigned int  num_tables;
    unsigned int  table_freq;


    // Note:    
    //   Response header cmd, length, and numArgs fields have already been initialized.
    
    
#ifdef _DEBUG_
	xil_printf("In wlan_exp_node_ap_processCmd():  ID = %d \n", cmdID);
#endif

	switch(cmdID){

		//---------------------------------------------------------------------
		case NODE_ASSN_GET_STATUS:
            // NODE_GET_ASSN_STATUS Packet Format:
            //   - Note:  All u32 parameters in cmdArgs32 are byte swapped so use Xil_Ntohl()
            //
            //   - cmdArgs32[0] - 31:16 - Number of tables to transmit per minute ( 0 => stop )
			//                  - 15:0  - Number of tables to transmit            ( 0 => infinite )
			//

			temp        = Xil_Ntohl(cmdArgs32[0]);
			table_freq  = ( temp >> 16 );
        	num_tables  = temp & 0xFFFF;


        	// Transmit association tables
        	if ( table_freq != 0 ) {

				// Transmit num_tables association tables at the table_freq rate
				if ( num_tables != 0 ) {

//					for( i = 0; i < num_tables; i++ ) {

						respIndex += get_station_status( &access_point, 1, &respArgs32[respIndex], max_words );
//					}


				// Continuously transmit association tables
				} else {
					// TODO:

				}

			// Stop transmitting association tables
        	} else {

        		// Send stop indicator
                respArgs32[respIndex++] = Xil_Htonl( 0xFFFFFFFF );
        	}

            // NODE_GET_ASSN_TBL Response Packet Format:
            //   - Note:  All u32 parameters in cmdArgs32 are byte swapped so use Xil_Ntohl()
            //
            //   - respArgs32[0] - 31:0  - Number of association table entries
        	//   - respArgs32[1 .. N]    - Association table entries
			//

			respHdr->length += (respIndex * sizeof(respArgs32));
			respHdr->numArgs = respIndex;

		break;


		//---------------------------------------------------------------------
		// TODO:  THIS FUNCTION IS NOT COMPLETE
		case NODE_ASSN_SET_TABLE:
			xil_printf("STA - Set association table not supported\n");
		break;

        
		//---------------------------------------------------------------------
		case NODE_ASSN_RESET_STATS:
			xil_printf("Reseting Statistics - STA\n");

			reset_station_statistics();
		break;


		//---------------------------------------------------------------------
		case NODE_DISASSOCIATE:
            // NODE_DISASSOCIATE Packet Format:
            //   Since a station is only associated to one AP, this command will
			//     disassociate from that AP.
            //
			//   - Returns AID of AP that was disassociated

			xil_printf("Node Disassociate - STA - Not Supported \n");

			// Send response of current channel
            respArgs32[respIndex++] = Xil_Htonl( 0 );

			respHdr->length += (respIndex * sizeof(respArgs32));
			respHdr->numArgs = respIndex;
		break;


	    //---------------------------------------------------------------------
		case NODE_TX_RATE:
			// Get node TX rate
			temp = Xil_Ntohl(cmdArgs32[0]);

			// If parameter is not the magic number, then set the TX rate
			if ( temp != 0xFFFF ) {

				default_unicast_rate = temp;

				if( default_unicast_rate < WLAN_MAC_RATE_6M ){
					default_unicast_rate = WLAN_MAC_RATE_6M;
				}

				if(default_unicast_rate > WLAN_MAC_RATE_54M){
					default_unicast_rate = WLAN_MAC_RATE_54M;
				}

				access_point.tx_rate = default_unicast_rate;

			    xil_printf("Setting TX rate = %d Mbps\n", wlan_lib_mac_rate_to_mbps(default_unicast_rate) );
			}

			// Send response of current rate
            respArgs32[respIndex++] = Xil_Htonl( default_unicast_rate );

			respHdr->length += (respIndex * sizeof(respArgs32));
			respHdr->numArgs = respIndex;
		break;


		//---------------------------------------------------------------------
		case NODE_CHANNEL:
			// Get channel parameter
			temp = Xil_Ntohl(cmdArgs32[0]);

			// If parameter is not the magic number, then set the mac channel
			//   NOTE:  We modulate temp so that we always have a valid channel
			if ( temp != 0xFFFF ) {
				temp = temp % 12;          // Get a channel number between 0 - 11
				if ( temp == 0 ) temp++;   // Change all values of 0 to 1

				// TODO:  Disassociate from the current AP

				mac_param_chan = temp;
				set_mac_channel( mac_param_chan );

			    xil_printf("Setting Channel = %d\n", mac_param_chan);
			}

			// Send response of current channel
            respArgs32[respIndex++] = Xil_Htonl( mac_param_chan );

			respHdr->length += (respIndex * sizeof(respArgs32));
			respHdr->numArgs = respIndex;
		break;


		//---------------------------------------------------------------------
		case NODE_STA_GET_AP_LIST:
            // NODE_STA_GET_AP_LIST Response Packet Format:
			//
            //   - respArgs32[0] - 31:0  - Number of APs
        	//   - respArgs32[1 .. N]    - AP Info List
			//

			//Send broadcast probe requests across all channels
			if(active_scan ==0){

				wlan_free( ap_list );

				// Clean up current state
				ap_list             = NULL;
				num_ap_list         = 0;
				access_point_ssid   = wlan_realloc(access_point_ssid, 1);
				*access_point_ssid  = 0;

				// Start scan
				active_scan         = 1;
				pause_queue         = 1;
				mac_param_chan_save = mac_param_chan;

				probe_req_transmit();

				respIndex += get_ap_list( ap_list, num_ap_list, &respArgs32[respIndex], max_words );
			} else {
				xil_printf("WARNING:  STA - Cannot get AP List.  Currently in active scan.\n");

				respArgs32[respIndex++] = 0;
			}

			// Finalize response
			respHdr->length += (respIndex * sizeof(respArgs32));
			respHdr->numArgs = respIndex;
		break;


		//---------------------------------------------------------------------
		case NODE_STA_ASSOCIATE:
            // NODE_STA_ASSOCIATE Packet Format:
			//
            //   - cmdArgs32[0] - AP list index
            //
            //   - respArgs32[0] - 0           - Success
			//                     0xFFFF_FFFF - Failure
			//

			status      = 0;
			temp        = Xil_Ntohl(cmdArgs32[0]);

			if( ( temp >= 0 ) && ( temp <= (num_ap_list-1) ) ) {

				if( ap_list[temp].private == 0) {

					mac_param_chan = ap_list[temp].chan;
					set_mac_channel( mac_param_chan );

					xil_printf("Attempting to join %s\n", ap_list[temp].ssid);
					memcpy(access_point.addr, ap_list[temp].bssid, 6);

					access_point_ssid = wlan_realloc(access_point_ssid, strlen(ap_list[temp].ssid)+1);
					strcpy(access_point_ssid,ap_list[temp].ssid);

					access_point_num_basic_rates = ap_list[temp].num_basic_rates;
					memcpy(access_point_basic_rates, ap_list[temp].basic_rates, access_point_num_basic_rates);

					association_state = 1;
					attempt_authentication();

				} else {
					xil_printf("WARNING:  STA - Invalid AP selection %d.  Please choose an AP that is not private.\n", temp);
					status = 0xFFFFFFFF;
				}

			} else {
				xil_printf("WARNING:  STA - Invalid AP selection.  Please choose a number between [0,%d].\n", (num_ap_list-1));
				status = 0xFFFFFFFF;
			}

			// Send response of current status
            respArgs32[respIndex++] = Xil_Htonl( status );

			respHdr->length += (respIndex * sizeof(respArgs32));
			respHdr->numArgs = respIndex;
		break;


		//---------------------------------------------------------------------
		default:
			xil_printf("Unknown node command: %d\n", cmdID);
		break;
	}

	return respSent;
}





// #ifdef _DEBUG_

/*****************************************************************************/
/**
* Print Station Status
*
* This function will print a list of station_info structures
*
* @param    stations     - pointer to the station_info list
*           num_stations - number of station_info structures in the list
*
* @return	None.
*
* @note		None.
*
******************************************************************************/
void wlan_exp_print_ap_list( ap_info * ap_list, u32 num_ap ){
	u32  i, j;
	char str[4];

	for( i = 0; i < num_ap; i++ ) {
		xil_printf("---------------------------------------------------\n");
		xil_printf(" AP: %02x -- MAC Addr: %02x:%02x:%02x:%02x:%02x:%02x\n", i,
				ap_list[i].bssid[0],ap_list[i].bssid[1],ap_list[i].bssid[2],ap_list[i].bssid[3],ap_list[i].bssid[4],ap_list[i].bssid[5]);
		xil_printf("     - SSID             : %s  (private = %d)\n", ap_list[i].ssid, ap_list[i].private);
		xil_printf("     - Channel          : %d\n", ap_list[i].chan);
		xil_printf("     - Rx Power         : %d\n", ap_list[i].rx_power);
		xil_printf("     - Rates            : ");

		for( j = 0; j < ap_list[i].num_basic_rates; j++ ) {
			tagged_rate_to_readable_rate(ap_list[i].basic_rates[j], str);
			xil_printf("%s, ",str);
		}
        xil_printf("\n");
	}
}

// #endif


#endif
