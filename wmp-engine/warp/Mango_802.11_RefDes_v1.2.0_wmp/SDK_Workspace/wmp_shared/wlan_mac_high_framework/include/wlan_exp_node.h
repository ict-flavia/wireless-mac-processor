////////////////////////////////////////////////////////////////////////////////
// File   :	wlan_exp_node.h
// Authors:	Chris Hunter (chunter [at] mangocomm.com)
//			Patrick Murphy (murphpo [at] mangocomm.com)
//          Erik Welsh (welsh [at] mangocomm.com)
// License:	Copyright 2013, Mango Communications. All rights reserved.
//			Distributed under the WARP license  (http://warpproject.org/license)
////////////////////////////////////////////////////////////////////////////////


/***************************** Include Files *********************************/
#include "wlan_exp_common.h"


// WLAN MAC includes for common functions
#include "wlan_mac_util.h"


/*************************** Constant Definitions ****************************/
#ifndef WLAN_EXP_NODE_H_
#define WLAN_EXP_NODE_H_



// ****************************************************************************
// Define WLAN Exp Node Commands
//
#define NODE_INFO                       1
#define NODE_IDENTIFY                   2
#define NODE_CONFIG_SETUP               3
#define NODE_CONFIG_RESET               4

#define NODE_ASSN_GET_STATUS           10
#define NODE_ASSN_SET_TABLE            11
#define NODE_ASSN_RESET_STATS          12

#define NODE_DISASSOCIATE              20

#define NODE_TX_POWER                  30
#define NODE_TX_RATE                   31
#define NODE_CHANNEL                   32

#define NODE_LTG_CONFIG_CBR            40
#define NODE_LTG_START                 41
#define NODE_LTG_STOP                  42
#define NODE_LTG_REMOVE                43

#define NODE_LOG_RESET                 50
#define NODE_LOG_CONFIG                51
#define NODE_LOG_GET_CURR_IDX          52
#define NODE_LOG_GET_OLDEST_IDX        53
#define NODE_LOG_GET_EVENTS            54
#define NODE_LOG_ADD_EVENT             55
#define NODE_LOG_ENABLE_EVENT          56



// ****************************************************************************
// Define Node Parameters
//   - NOTE:  To add another parameter, add the define before "NODE_MAX_PARAMETER"
//     and then change the value of "NODE_MAX_PARAMETER" to be the largest value
//     in the list so it is easy to iterate over all parameters
//
#define NODE_TYPE                      0
#define NODE_ID                        1
#define NODE_HW_GEN                    2
#define NODE_DESIGN_VER                3
#define NODE_SERIAL_NUM                4
#define NODE_FPGA_DNA                  5
#define NODE_WLAN_MAX_ASSN             6
#define NODE_WLAN_EVENT_LOG_SIZE       7
#define NODE_MAX_PARAMETER             8


/*********************** Global Structure Definitions ************************/

// **********************************************************************
// WARPNet Node Info Structure
//
typedef struct {

    u32   type;                        // Type of WARPNet node
    u32   node;                        // Only first 16 bits are valid
    u32   hw_generation;               // Only first  8 bits are valid
	u32   design_ver;                  // Only first 24 bits are valid

	u32   serial_number;
	u32   fpga_dna[FPGA_DNA_LEN];

	u32   wlan_max_assn;               // WLAN Exp - Max Associations
	u32   wlan_event_log_size;         // WLAN Exp - Event Log Size

    u32   eth_device;
    u8    hw_addr[ETH_ADDR_LEN];
    u8    ip_addr[IP_VERSION];
    u32   unicast_port;
    u32   broadcast_port;

} wn_node_info;



/*************************** Function Prototypes *****************************/

// WLAN Exp node commands
//
int  wlan_exp_node_init( unsigned int type, unsigned int serial_number, unsigned int *fpga_dna, unsigned int eth_dev_num, unsigned char *hw_addr );

void node_set_process_callback(void(*callback)());
int  node_get_parameters(u32 * buffer, unsigned int max_words, unsigned char network);

void node_info_set_max_assn      ( u32 max_assn );
void node_info_set_event_log_size( u32 log_size );


#endif /* WLAN_EXP_NODE_H_ */
