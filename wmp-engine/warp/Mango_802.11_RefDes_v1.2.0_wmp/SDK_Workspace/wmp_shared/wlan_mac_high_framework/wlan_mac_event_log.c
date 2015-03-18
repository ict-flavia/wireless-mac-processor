////////////////////////////////////////////////////////////////////////////////
// File   : wlan_mac_event_log.c
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
//   The event log implements a circular buffer that will record various
// events that occur within a WLAN node.  If the buffer is full, then events
// will be dropped with only a single warning printed to the screen.
//
//   There are configuration options to enable / disable wrapping (ie if
// wrapping is enabled, then the buffer is never "full" and the oldest
// events will be overwritten when there is no more free space).  Wrapping
// is disabled by default.
//
//   Internally, the event log is just an array of bytes which can be externally
// viewed as indexed from 0 to log_size (address translation is done internally).
// When a new event is requested, the size of the event is allocated from the
// buffer and a pointer to the allocated event is provided so that the caller
// can fill in the event information.  By default, the event log will set up all
// header information (defined in wlan_mac_event_log.h) and that information
// will not be exposed to user code.
//
//   The event log will always provide a contiguous piece of memory for events.
// Therefore, some space could be wasted at the wrap boundary since a single event
// will never wrap.
//
//   Also, if an event cannot be allocated due to it overflowing the array, then
// the event log will check to see if wrapping is enabled.  If wrapping is disabled,
// the event log will set the full flag and not allow any more events to be
// allocated.  Otherwise, the event log will wrap and begin to overwrite the
// oldest events.
//
//   Finally, the log does not keep track of event entries and it is up to
// calling functions to interpret the bytes within the log correctly.
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
#include "wlan_mac_util.h"


/*************************** Constant Definitions ****************************/



/*********************** Global Variable Definitions *************************/



/*************************** Variable Definitions ****************************/

// Log definition variables
static u32   log_start_address;        // Absolute start address of the log
static u32   log_soft_end_address;     // Soft end address of the log
static u32   log_max_address;          // Absolute end address of the log

static u32   log_size;                 // Size of the log in bytes

// Log index variables
static u32   log_head_address;         // Pointer to the oldest event
static u32   log_curr_address;

// Log config variables
static u8    log_wrap_enabled;         // Will the log wrap or stop; By default wrapping is DISABLED

// Log status variables
static u8    log_empty;                // log_empty = (log_head_address == log_curr_address);
static u8    log_full;                 // log_full  = (log_tail_address == log_curr_address);
static u32   log_count;

// Variable to control if events are recorded in to the log
u8           enable_event_logging;

// Mutex for critical allocation loop
static u8    allocation_mutex;



/*************************** Functions Prototypes ****************************/

// Internal functions;  Should not be called externally
//
void            event_log_increment_head_address( u32 size );
int             event_log_get_next_empty_address( u32 size, u32 * address );


/******************************** Functions **********************************/




/*****************************************************************************/
/**
* Initialize the event log
*
* @param    start_address  - Starting address of the event log
*           size           - Size in bytes of the event log
*
* @return	None.
*
* @note		The event log will only use a integer number of event entries so
*           any bytes over an integer number will be unused.
*
******************************************************************************/
void event_log_init( char * start_address, u32 size ) {

	xil_printf("Initializing Event log (%d bytes) at 0x%x \n", size, start_address );

	// If defined, enable event logging
	if(ENABLE_EVENT_LOGGING) enable_event_logging = 1;

	// Set the global variables that describe the log
    log_size          = size;
	log_start_address = (u32) start_address;
	log_max_address   = log_start_address + log_size - 1;

	// Set wrapping to be disabled
	log_wrap_enabled  = 0;

	// Reset all the event log variables
	event_log_reset();

#ifdef _DEBUG_
	xil_printf("    log_size             = 0x%x;\n", log_size );
	xil_printf("    log_start_address    = 0x%x;\n", log_start_address );
	xil_printf("    log_max_address      = 0x%x;\n", log_max_address );
	xil_printf("    log_soft_end_address = 0x%x;\n", log_soft_end_address );
	xil_printf("    log_head_address     = 0x%x;\n", log_head_address );
	xil_printf("    log_curr_address     = 0x%x;\n", log_curr_address );
	xil_printf("    log_empty            = 0x%x;\n", log_empty );
	xil_printf("    log_full             = 0x%x;\n", log_full );
	xil_printf("    allocation_mutex     = 0x%x;\n", allocation_mutex );
#endif
}



/*****************************************************************************/
/**
* Reset the event log
*
* @param    None.
*
* @return	None.
*
* @note		This will not change the state of the wrapping configuration
*
******************************************************************************/
void event_log_reset(){
	log_soft_end_address = log_max_address;

	log_head_address     = log_start_address;
	log_curr_address     = log_start_address;

	log_empty            = 1;
	log_full             = 0;
	log_count            = 0;

	allocation_mutex     = 0;
}



/*****************************************************************************/
/**
* Set the wrap configuration parameter
*
* @param    enable    - Is wrapping enabled?
*                           EVENT_LOG_WRAP_ENABLE
*                           EVENT_LOG_WRAP_DISABLE
*
* @return	status    - SUCCESS = 0
*                       FAILURE = -1
*
* @note		None.
*
******************************************************************************/
int       event_log_config_wrap( u32 enable ) {
	int ret_val = 0;

	switch ( enable ) {
	    case EVENT_LOG_WRAP_ENABLE:
	    	log_wrap_enabled  = 1;
	        break;

	    case EVENT_LOG_WRAP_DISABLE:
	    	log_wrap_enabled  = 0;
	        break;

        default:
        	ret_val = -1;
            break;
	}

	return ret_val;
}



/*****************************************************************************/
/**
* Get event log data
*   Based on the start address and the size, the function will fill in the
* appropriate number of bytes in to the buffer.  It is up to the caller
* to determine if the bytes are "valid".
*
* @param    start_address    - Address in the event log to start the transfer
*                                (ie byte index from 0 to log_size)
*           size             - Size in bytes of the buffer
*           buffer           - Pointer to the buffer to be filled in with event data
*                                (buffer must be pre-allocated and be at least size bytes)
*
* @return	num_bytes        - The number of bytes filled in to the buffer
*
* @note		Any requests for data that is out of bounds will print a warning and
*           return 0 bytes.  If a request exceeds the size of the array, then
*           the request will be truncated.
*
******************************************************************************/
u32  event_log_get_data( u32 start_address, u32 size, char * buffer ) {

	u64 end_address;
	u32 num_bytes     = 0;

	// If the log is empty, then return 0
    if ( log_empty == 1 ) { return num_bytes; }

    // Check that the start_address is less than the log_size
    if ( start_address > log_size ) {
    	xil_printf("WARNING:  EVENT LOG - Index out of bounds\n");
    	xil_printf("          Data request from %d when the log only has %d bytes\n", start_address, log_size);
    	return num_bytes;
    }

    // Translate the start address from an index to the actual memory location
    start_address = start_address + log_start_address;

    // Compute the end address for validity checks
    end_address = log_start_address + start_address + size;

    // Check that the end address is less than the end of the buffer
    if ( end_address > log_soft_end_address ) {
    	num_bytes = log_soft_end_address - start_address;
    } else {
    	num_bytes = size;
    }

	// Copy the data in to the buffer
	memcpy( (void *) buffer, (void *) start_address, num_bytes );

    return num_bytes;
}



/*****************************************************************************/
/**
* Get the size of the log in bytes
*
* @param    None.
*
* @return	size    - Size of the log in bytes
*
* @note		None.
*
******************************************************************************/
u32  event_log_get_size( void ) {
	u32 size;

	// Implemented this way b/c we are using unsigned integers, so we always need
	//   to have positive integers at each point in the calculation
	if ( log_curr_address >= log_head_address ) {
		size = log_curr_address - log_head_address;
	} else {
		size = log_size - ( log_head_address - log_curr_address );
	}

#ifdef _DEBUG_
	xil_printf("Event Log:  size             = 0x%x\n", size );
	xil_printf("Event Log:  log_curr_address = 0x%x\n", log_curr_address );
	xil_printf("Event Log:  log_head_address = 0x%x\n", log_head_address );
#endif

	return size;
}



/*****************************************************************************/
/**
* Get the address of the current write pointer
*
* @param    None.
*
* @return	u32    - Index of the event log of the current write pointer
*
* @note		None.
*
******************************************************************************/
u32  event_log_get_current_index( void ) {
    return ( log_curr_address - log_start_address );
}



/*****************************************************************************/
/**
* Get the index of the oldest event
*
* @param    None.
*
* @return	u32    - Index of the event log of the oldest event
*
* @note		None.
*
******************************************************************************/
u32  event_log_get_oldest_event_index( void ) {
    return ( log_head_address - log_start_address );
}



/*****************************************************************************/
/**
* Update the event type
*
* @param    event_ptr   - Pointer to event contents
*           event_type  - Value to update event_type field
*
* @return	u32         -  0 - Success
*                         -1 - Failure
*
* @note		None.
*
******************************************************************************/
int       event_log_update_type( void * event_ptr, u16 event_type ) {
    int            return_value = -1;
    event_header * event_hdr;

    // If the event_ptr is within the event log, then update the type field of the event
    if ( ( ((u32) event_ptr) > log_start_address ) && ( ((u32) event_ptr) < log_max_address ) ) {

    	event_hdr = (event_header *) ( ((u32) event_ptr) - sizeof( event_header ) );

    	// Check to see if the event has a valid magic number
    	if ( ( event_hdr->timestamp & 0xFFFF000000000000 ) == EVENT_LOG_MAGIC_NUMBER ) {

        	event_hdr->event_type = event_type;

        	return_value = 0;
    	} else {
    		xil_printf("WARNING:  event_log_update_type() - event_ptr (0x%8x) is not valid \n", event_ptr );
    	}
    } else {
		xil_printf("WARNING:  event_log_update_type() - event_ptr (0x%8x) is not in event log \n", event_ptr );
    }

    return return_value;
}



/*****************************************************************************/
/**
* Update the event timestamp
*
* @param    event_ptr   - Pointer to event contents
*           event_type  - Value to update event_type field
*
* @return	u32         -  0 - Success
*                         -1 - Failure
*
* @note		None.
*
******************************************************************************/
int       event_log_update_timestamp( void * event_ptr ) {
    int            return_value = -1;
    event_header * event_hdr;

    // If the event_ptr is within the event log, then update the type field of the event
    if ( ( ((u32) event_ptr) > log_start_address ) && ( ((u32) event_ptr) < log_max_address ) ) {

    	event_hdr = (event_header *) ( ((u32) event_ptr) - sizeof( event_header ) );

    	// Check to see if the event has a valid magic number
    	if ( ( event_hdr->timestamp & 0xFFFF000000000000 ) == EVENT_LOG_MAGIC_NUMBER ) {

    		event_hdr->timestamp  = EVENT_LOG_MAGIC_NUMBER + ( 0x0000FFFFFFFFFFFF & get_usec_timestamp() );

        	return_value = 0;
    	} else {
    		xil_printf("WARNING:  event_log_update_timestamp() - event_ptr (0x%8x) is not valid \n", event_ptr );
    	}
    } else {
		xil_printf("WARNING:  event_log_update_timestamp() - event_ptr (0x%8x) is not in event log \n", event_ptr );
    }

    return return_value;
}



/*****************************************************************************/
/**
* Increment the head address
*
* @param    size        - Number of bytes to increment the head address
*
* @return	num_bytes   - Number of bytes that the head address moved
*
* @note		This function will blindly increment the head address by 'size'
*           bytes (ie it does not check the log_head_address relative to the
*           log_curr_address).  It is the responsibility of the calling
*           function to make sure this is only called when appropriate.
*
******************************************************************************/
void event_log_increment_head_address( u32 size ) {

    u64            end_address;
    event_header * event;

	// Calculate end address (need to make sure we don't overflow u32)
    end_address = log_head_address + size;

    // Check to see if we will wrap with the current increment
    if ( end_address > log_soft_end_address ) {
        // We will wrap the log

    	// Reset the log_soft_end_address to the end of the array
    	log_soft_end_address = log_max_address;

    	// Move the log_soft_head_address to the beginning of the array and move it
    	//   at least 'size' bytes from the front of the array.  This is done to mirror
    	//   how allocation of the log_curr_address works.  Also, b/c of this allocation
    	//   scheme, we are guaranteed that log_start_address is the beginning of an event.
    	log_head_address = log_start_address;
    	end_address      = log_start_address + size;

		// Move the head address an integer number of events until it points to the
		//   first event after the allocation
		event = (event_header *) log_head_address;

		while ( log_head_address < end_address ) {
			log_head_address += ( event->event_length + sizeof( event_header ) );
			event             = (event_header *) log_head_address;
		}

    } else {
    	// We will not wrap

		// Move the head address an integer number of events until it points to the
		//   first event after the allocation
		event = (event_header *) log_head_address;

		while ( log_head_address < end_address ) {
			log_head_address += ( event->event_length + sizeof( event_header ) );
			event             = (event_header *) log_head_address;
		}
    }
}



/*****************************************************************************/
/**
* Get the address of the next empty event in the log and allocate size bytes
*   for that event
*
* @param    size        - Size (in bytes) of event to allocate
*           address *   - Pointer to address of empty event of length 'size'
*
* @return	int         - Status - 0 = Success
*                                  1 = Failure
*
* @note		This will handle the circular nature of the buffer.  It will also
*           set the log_full flag if there is no additional space and print
*           a warning message.  If this function is called while the event log
*           is full, then it will always return max_event_index
*
******************************************************************************/
int  event_log_get_next_empty_address( u32 size, u32 * address ) {

	int   status         = 1;            // Initialize status to FAILED
	u32   return_address = 0;

	u64   end_address;

	// If the log is empty, then set the flag to zero to indicate the log is not empty
	if ( log_empty ) { log_empty = 0; }

	// If the log is not full, then find the next address
	if ( !log_full && !allocation_mutex ) {

		// Set the mutex to '1' so that if an interrupt occurs, the event log allocation
		//   will not be ruined
		allocation_mutex = 1;

		// Compute the end address of the newly allocated event
	    end_address = log_curr_address + size;

	    // Check if the log has wrapped
	    if ( log_curr_address >= log_head_address ) {
	    	// The log has not wrapped

		    // Check to see if we will wrap with the current allocation
		    if ( end_address > log_soft_end_address ) {
		    	// Current allocation will wrap the log

		    	// Check to see if wrapping is enabled
		    	if ( log_wrap_enabled ) {

					// Compute new end address
					end_address = log_start_address + size;

					// Check that we are not going to pass the head address
					if ( end_address > log_head_address ) {

						event_log_increment_head_address( size );
					}

					// Set the log_soft_end_address and allocate the new event from the beginning of the buffer
					log_soft_end_address = log_curr_address;
					log_curr_address     = end_address;

					// Return address is the beginning of the buffer
					return_address = log_start_address;
					status         = 0;

		    	} else {
					// Set the full flag and fail
					log_full = 1;

					// Log is now full, print warning
					xil_printf("---------------------------------------- \n");
					xil_printf("EVENT LOG:  WARNING - Event Log FULL !!! \n");
					xil_printf("---------------------------------------- \n");
		    	}
		    } else {
		    	// Current allocation does not wrap

		    	// NOTE: This should be the most common case; since we know the log has not wrapped
		    	//   we do not need to increment the log_head_address.

	    		// Set the return address and then move the log_curr_address
	    		return_address   = log_curr_address;
	    		log_curr_address = end_address;
	    		status           = 0;
		    }
	    } else {
	    	// The log has wrapped
	    	//   NOTE:  Even though the log has wrapped, we cannot assume that the wrap flag
	    	//     continues to allow the log to wrap.

			// Check that we are not going to pass the head address
	    	//   NOTE:  This will set the log_soft_end_address if the head_address passes the end of the array
			if ( end_address > log_head_address ) {

				event_log_increment_head_address( size );
			}

		    // Check to see if we will wrap with the current allocation
		    if ( end_address > log_soft_end_address ) {
		    	// Current allocation will wrap the log

		    	// Check to see if wrapping is enabled
		    	if ( log_wrap_enabled ) {

					// Compute new end address
					end_address = log_start_address + size;

					// NOTE:  We have already incremented the log_head_address by size.  Since the
					//   event_log_increment_head_address() function follows the same allocation scheme
					//   we are guaranteed that at least 'size' bytes are available at the beginning of the
					//   array if we wrapped.  Therefore, we do not need to check the log_head_address again.

					// Set the log_soft_end_address and allocate the new event from the beginning of the buffer
					log_soft_end_address = log_curr_address;
					log_curr_address     = end_address;

					// Return address is the beginning of the buffer
					return_address = log_start_address;
					status         = 0;

		    	} else {
					// Set the full flag and fail
					log_full = 1;

					// Log is now full, print warning
					xil_printf("---------------------------------------- \n");
					xil_printf("EVENT LOG:  WARNING - Event Log FULL !!! \n");
					xil_printf("---------------------------------------- \n");
		    	}
		    } else {
		    	// Current allocation does not wrap

	    		// Set the return address and then move the log_curr_address
	    		return_address   = log_curr_address;
	    		log_curr_address = end_address;
	    		status           = 0;
		    }
	    }

		// Set the mutex to '0' to allow for future allocations
		allocation_mutex = 0;
	}

	// Set return parameter
	*address = return_address;

	return status;
}



/*****************************************************************************/
/**
* Get the next empty event
*
* @param    event_type  - Type of event
*           event_size  - Size of the event payload
*
* @return	void *      - Pointer to the next event payload
*
* @note		None.
*
******************************************************************************/
void * event_log_get_next_empty_event( u16 event_type, u16 event_size ) {

	u32            log_address;
	u32            total_size;
	event_header * header       = NULL;
	u32            header_size  = sizeof( event_header );
	void *         return_event = NULL;


    // If Event Logging is enabled, then allocate event
	if( enable_event_logging ){

		total_size = event_size + header_size;

		// Try to allocate the next event
	    if ( !event_log_get_next_empty_address( total_size, &log_address ) ) {

	    	// Use successfully allocated address for the event entry
			header = (event_header*) log_address;

			// Zero out event
			bzero( (void *) header, total_size );

			// Set header parameters
			//   - Use the upper 16 bits of the timestamp to place a magic number
			header->timestamp    = EVENT_LOG_MAGIC_NUMBER + ( 0x0000FFFFFFFFFFFF & get_usec_timestamp() );
			header->event_type   = event_type;
			header->event_length = event_size;
            header->event_id     = log_count++;

            // Get a pointer to the event payload
            return_event         = (void *) ( log_address + header_size );

#ifdef _DEBUG_
			xil_printf("Event (%6d bytes) = 0x%8x    0x%8x    0x%6x\n", event_size, return_event, header, total_size );
#endif
	    }
	}

	return return_event;
}



/*****************************************************************************/
/**
* Prints everything in the event log from log_start_index to log_curr_index
*
* @param    None.
*
* @return	None.
*
* @note		None.
*
******************************************************************************/
void print_event_log( u32 num_events ) {
	u32            i;
	u32            event_address;
	u32            event_count;
	event_header * event_hdr;
	u32            event_hdr_size;
	void         * event;

	// Initialize count
	event_hdr_size = sizeof( event_header );
	event_count    = 0;
	event_address  = log_head_address;

    // Check if the log has wrapped
    if ( log_curr_address >= log_head_address ) {
    	// The log has not wrapped

    	// Print the log from log_head_address to log_curr_address
    	for( i = event_count; i < num_events; i++ ){

    		// Check that the current event address is less than log_curr_address
    		if ( event_address < log_curr_address ) {

    			event_hdr = (event_header*) event_address;
    			event     = (void *) ( event_address + event_hdr_size );

#ifdef _DEBUG_
                xil_printf(" Event [%d] - addr = 0x%8x;  size = 0x%4x \n", i, event_address, event_hdr->event_length );
#endif

        		// Print event
    		    print_event( event_hdr->event_id, event_hdr->event_type, event_hdr->timestamp, event );

        	    // Get the next event
        		event_address += ( event_hdr->event_length + event_hdr_size );

    		} else {
    			// Exit the loop
    			break;
    		}
    	}

    } else {
    	// The log has wrapped

    	// Print the log from log_head_address to the end of the buffer
    	for( i = event_count; i < num_events; i++ ){

    		// Check that the current event address is less than the end of the log
    		if ( event_address < log_soft_end_address ) {

    			event_hdr = (event_header*) event_address;
    			event     = (void * ) ( event_hdr + event_hdr_size );

        		// Print event
    		    print_event( event_hdr->event_id, event_hdr->event_type, event_hdr->timestamp, event );

        	    // Get the next event
        		event_address += ( event_hdr->event_length + event_hdr_size );

    		} else {
    			// Exit the loop and set the event to the beginning of the buffer
    			event_address  = log_start_address;
    			event_count    = i;
    			break;
    		}
    	}


    	// If we still have events to print, then start at the beginning
    	if ( event_count < num_events ) {

			// Print the log from the beginning to log_curr_address
			for( i = event_count; i < num_events; i++ ){

				// Check that the current event address is less than log_curr_address
				if ( event_address < log_curr_address ) {

	    			event_hdr = (event_header*) event_address;
	    			event     = (void * ) ( event_hdr + event_hdr_size );

	        		// Print event
	    		    print_event( event_hdr->event_id, event_hdr->event_type, event_hdr->timestamp, event );

					// Get the next event
	        		event_address += ( event_hdr->event_length + event_hdr_size );

				} else {
					// Exit the loop
					break;
				}
			}
    	}
    }
}





/*****************************************************************************/
/**
* Prints the size of the event log
*
* @param    None.
*
* @return	None.
*
* @note		None.
*
******************************************************************************/
void print_event_log_size(){
	u32 size;
	u64 timestamp;

	size      = event_log_get_size();
	timestamp = get_usec_timestamp();

	xil_printf("Event Log (%10d us): %10d of %10d bytes used\n", (u32)timestamp, size, log_size );
}


