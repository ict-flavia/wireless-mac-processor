////////////////////////////////////////////////////////////////////////////////
// File   : wlan_mac_util.h
// Authors: Patrick Murphy (murphpo [at] mangocomm.com)
//			Chris Hunter (chunter [at] mangocomm.com)
// License: Copyright 2013, Mango Communications. All rights reserved.
//          Distributed under the Mango Communications Reference Design License
//				See LICENSE.txt included in the design archive or
//				at http://mangocomm.com/802.11/license
////////////////////////////////////////////////////////////////////////////////

/***************************** Include Files *********************************/



/*************************** Constant Definitions ****************************/
#ifndef WLAN_MAC_EVENT_LOG_H_
#define WLAN_MAC_EVENT_LOG_H_



// ****************************************************************************
// Define Event Log Constants
//

// Define to enable event logging at compile time
//   - If '1' then events will be logged
//   - If '0' then no events will be logged
//
#define ENABLE_EVENT_LOGGING           1


// Define event wrapping enable / disable
#define EVENT_LOG_WRAP_ENABLE          1
#define EVENT_LOG_WRAP_DISABLE         2


// Define magic number that will indicate the start of an event
//   - Magic number was chose so that:
//       - It would not be in DDR address space
//       - It is human readable
//
#define EVENT_LOG_MAGIC_NUMBER         0xACED000000000000



/*********************** Global Structure Definitions ************************/

//-----------------------------------------------
// Event Header
//   - This is used by the event log but is not exposed to the user
//
typedef struct{
	u64 timestamp;
	u16 event_type;
	u16 event_length;
	u32 event_id;
} event_header;



/*************************** Function Prototypes *****************************/

void      event_log_init( char * start_address, u32 size );

void      event_log_reset();

int       event_log_config_wrap( u32 enable );

u32       event_log_get_data( u32 start_address, u32 size, char * buffer );
u32       event_log_get_size( void );
u32       event_log_get_current_index( void );
u32       event_log_get_oldest_event_index( void );
void *    event_log_get_next_empty_event( u16 event_type, u16 event_size );

int       event_log_update_type( void * event_ptr, u16 event_type );
int       event_log_update_timestamp( void * event_ptr );

void      print_event_log( u32 num_events );
void      print_event_log_size();

#endif /* WLAN_MAC_EVENT_LOG_H_ */
