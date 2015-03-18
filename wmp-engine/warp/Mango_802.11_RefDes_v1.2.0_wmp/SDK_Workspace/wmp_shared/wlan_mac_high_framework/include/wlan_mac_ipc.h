////////////////////////////////////////////////////////////////////////////////
// File   : wlan_mac_util.h
// Authors: Patrick Murphy (murphpo [at] mangocomm.com)
//			Chris Hunter (chunter [at] mangocomm.com)
// License: Copyright 2013, Mango Communications. All rights reserved.
//          Distributed under the Mango Communications Reference Design License
//				See LICENSE.txt included in the design archive or
//				at http://mangocomm.com/802.11/license
////////////////////////////////////////////////////////////////////////////////

#ifndef WLAN_MAC_IPC_H_
#define WLAN_MAC_IPC_H_

void wlan_mac_ipc_init(void);

void ipc_rx();

void process_ipc_msg_from_low(wlan_ipc_msg* msg);

void set_mac_channel( unsigned int mac_channel );
void set_dsss_value( unsigned int dsss_value );
void set_backoff_slot_value( u32 num_slots );

void set_cpu_low_not_ready();
void set_cpu_low_ready();

int  is_cpu_low_initialized();
int  is_cpu_low_ready();

u8*  get_eeprom_mac_addr();

#endif /* WLAN_MAC_UTIL_H_ */
