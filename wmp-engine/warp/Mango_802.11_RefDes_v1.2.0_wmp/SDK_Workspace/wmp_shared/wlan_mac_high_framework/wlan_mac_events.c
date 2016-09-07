////////////////////////////////////////////////////////////////////////////////
// File   : wlan_mac_events.c
// Authors: Patrick Murphy (murphpo [at] mangocomm.com)
//			Chris Hunter (chunter [at] mangocomm.com)
//          Erik Welsh (welsh [at] mangocomm.com)
// License: Copyright 2013, Mango Communications. All rights reserved.
//          Distributed under the Mango Communications Reference Design License
//				See LICENSE.txt included in the design archive or
//				at http://mangocomm.com/802.11/license
////////////////////////////////////////////////////////////////////////////////
//
// Notes:
//   This is the only code that the user should modify in order to add events
// to the event log.  To add a new event, please follow the template provided
// and create:
//   1) A new event type in wlan_mac_events.h
//   2) Wrapper function:  get_next_empty_*_event()
//   3) Update the print function so that it is easy to print the log to the
//        terminal
//
////////////////////////////////////////////////////////////////////////////////

/***************************** Include Files *********************************/

// SDK includes
#include "stdio.h"
#include "stdlib.h"
#include "string.h"
#include "xil_types.h"

// WLAN includes
#include "wlan_mac_event_log.h"
#include "wlan_mac_events.h"


/*************************** Constant Definitions ****************************/



/*********************** Global Variable Definitions *************************/



/*************************** Variable Definitions ****************************/



/*************************** Functions Prototypes ****************************/



/******************************** Functions **********************************/



/*****************************************************************************/
/**
* Get the next empty RX OFDM event
*
* @param    None.
*
* @return	rx_event *   - Pointer to the next "empty" RX event or NULL
*
* @note		None.
*
******************************************************************************/
rx_ofdm_event* get_next_empty_rx_ofdm_event(){

	// Get the next empty event
	return (rx_ofdm_event *)event_log_get_next_empty_event( EVENT_TYPE_RX_OFDM, sizeof(rx_ofdm_event) );
}

/*****************************************************************************/
/**
* Get the next empty RX DSSS event
*
* @param    None.
*
* @return	rx_event *   - Pointer to the next "empty" RX event or NULL
*
* @note		None.
*
******************************************************************************/
rx_dsss_event* get_next_empty_rx_dsss_event(){

	// Get the next empty event
	return (rx_dsss_event *)event_log_get_next_empty_event( EVENT_TYPE_RX_DSSS, sizeof(rx_dsss_event) );
}

/*****************************************************************************/
/**
* Get the next empty TX event
*
* @param    None.
*
* @return	tx_event *   - Pointer to the next "empty" TX event or NULL
*
* @note		None.
*
******************************************************************************/
tx_event* get_next_empty_tx_event(){

	// Get the next empty event
	return (tx_event *)event_log_get_next_empty_event( EVENT_TYPE_TX, sizeof(tx_event) );

}

/*****************************************************************************/
/**
* Get the next empty bad FCS event
*
* @param    None.
*
* @return	bad_fcs_event *   - Pointer to the next "empty" TX event or NULL
*
* @note		None.
*
******************************************************************************/
bad_fcs_event* get_next_empty_bad_fcs_event(){

	// Get the next empty event
	return (bad_fcs_event *)event_log_get_next_empty_event( EVENT_TYPE_BAD_FCS_RX, sizeof(bad_fcs_event) );
}


/*****************************************************************************/
/**
* Prints an event
*
* @param    event_number     - Index of event in the log
*           event_type       - Type of event
*           timestamp        - Lower 32 bits of the timestamp
*           event            - Pointer to the event
*
* @return	None.
*
* @note		None.
*
******************************************************************************/
void print_event( u32 event_number, u32 event_type, u32 timestamp, void * event ){
	u32 i, j;
	rx_ofdm_event      * rx_ofdm_event_log_item;
	rx_dsss_event      * rx_dsss_event_log_item;
	tx_event      * tx_event_log_item;
	bad_fcs_event * bad_fcs_event_log_item;

	switch( event_type ){
		case EVENT_TYPE_RX_OFDM:
			rx_ofdm_event_log_item = (rx_ofdm_event*) event;
			xil_printf("%d: [%d] - Rx OFDM Event\n", event_number, timestamp );
			xil_printf("   Pow:      %d\n",     rx_ofdm_event_log_item->power);
			xil_printf("   Seq:      %d\n",     rx_ofdm_event_log_item->seq);
			xil_printf("   Rate:     %d\n",     rx_ofdm_event_log_item->rate);
			xil_printf("   Length:   %d\n",     rx_ofdm_event_log_item->length);
			xil_printf("   State:    %d\n",     rx_ofdm_event_log_item->state);
			xil_printf("   MAC Type: 0x%x\n",   rx_ofdm_event_log_item->mac_type);
			xil_printf("   Flags:    0x%x\n",   rx_ofdm_event_log_item->flags);
#ifdef WLAN_MAC_EVENTS_LOG_CHAN_EST
			xil_printf("   Channel Estimates:\n");

			for( i = 0; i < 16; i++) {
				xil_printf("        ");
				for( j = 0; j < 4; j++){
					xil_printf("0x%8x ", (rx_ofdm_event_log_item->channel_est)[4*i + j]);
				}
				xil_printf("\n");
			}
#endif


		break;

		case EVENT_TYPE_RX_DSSS:
			rx_dsss_event_log_item = (rx_dsss_event*) event;
			xil_printf("%d: [%d] - Rx DSSS Event\n", event_number, timestamp );
			xil_printf("   Pow:      %d\n",     rx_dsss_event_log_item->power);
			xil_printf("   Seq:      %d\n",     rx_dsss_event_log_item->seq);
			xil_printf("   Rate:     %d\n",     rx_dsss_event_log_item->rate);
			xil_printf("   Length:   %d\n",     rx_dsss_event_log_item->length);
			xil_printf("   State:    %d\n",     rx_dsss_event_log_item->state);
			xil_printf("   MAC Type: 0x%x\n",   rx_dsss_event_log_item->mac_type);
			xil_printf("   Flags:    0x%x\n",   rx_dsss_event_log_item->flags);
		break;

		case EVENT_TYPE_TX:
			tx_event_log_item = (tx_event*) event;
			xil_printf("%d: [%d] - Tx Event\n", event_number, timestamp);
			xil_printf("   Pow:              %d\n",     tx_event_log_item->power);
			xil_printf("   Seq:              %d\n",     tx_event_log_item->seq);
			xil_printf("   Rate:             %d\n",     tx_event_log_item->rate);
			xil_printf("   Length:           %d\n",     tx_event_log_item->length);
			xil_printf("   State:            %d\n",     tx_event_log_item->state);
			xil_printf("   MAC Type:         0x%x\n",   tx_event_log_item->mac_type);
			xil_printf("   Retry:            %d\n",     tx_event_log_item->retry_count);
			xil_printf("   MPDU Duration:    %d usec\n",     (u32)(tx_event_log_item->tx_mpdu_done_timestamp - tx_event_log_item->tx_mpdu_accept_timestamp));
		break;

		case EVENT_TYPE_BAD_FCS_RX:
			bad_fcs_event_log_item = (bad_fcs_event*) event;
			xil_printf("%d: [%d] - FCS Bad Rx Event\n", event_number, timestamp);
			xil_printf("   Rate:     %d\n",     bad_fcs_event_log_item->rate);
			xil_printf("   Length:   %d\n",     bad_fcs_event_log_item->length);
		break;

		default:
			xil_printf("%d: [%d] - Unknown Event\n", event_number, timestamp);
		break;
	}
}



