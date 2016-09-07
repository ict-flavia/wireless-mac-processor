/*
 * wmp_high.h
 *
 *  Created on: Nov 4, 2013
 *      Author: Nicolo' Facchi
 */

#ifndef WMP_HIGH_H_
#define WMP_HIGH_H_

/***************************** Include Files *********************************/


/*************************** Constant Definitions ****************************/


// **********************************************************************
// Enable the WLAN UART Menu
//    NOTE:  To enable the WLAN Exp framework, please modify wlan_exp_common.h
#define WLAN_USE_UART_MENU



// **********************************************************************
// Common Defines
//
#define SSID_LEN_MAX                   32
#define NUM_BASIC_RATES_MAX            10

#define MAX_RETRY                       7



// **********************************************************************
// UART Menu Modes
//
#define UART_MODE_MAIN                 0
#define UART_MODE_INTERACTIVE          1
#define UART_MODE_AP_LIST              2
#define UART_MODE_LTG_SIZE_CHANGE	   3
#define UART_MODE_LTG_INTERVAL_CHANGE  4
/* WMP_START */
#define UART_MODE_MODECHOICE 	         5
#define UART_MODE_CHAN_CHANGE 	         6
#define UART_MODE_BEACON_TU_CHANGE		 7
#define UART_MODE_SSID_CHANGE			8
/* WMP_END */



// **********************************************************************
// Timing Parameters
//
#define ASSOCIATION_TIMEOUT_US         100000
#define ASSOCIATION_NUM_TRYS           5

#define AUTHENTICATION_TIMEOUT_US      100000
#define AUTHENTICATION_NUM_TRYS        5

#define NUM_PROBE_REQ                  5




/*********************** Global Structure Definitions ************************/
//
// Information about APs
//
typedef struct{
	u8   bssid[6];
	u8   chan;
	u8   private;
	char ssid[SSID_LEN_MAX];
	u8   num_basic_rates;
	u8   basic_rates[NUM_BASIC_RATES_MAX];
	char rx_power;
} ap_info;



/*************************** Function Prototypes *****************************/
/* WMP_START */
extern u8 eeprom_mac_addr[6];
extern u8 bcast_addr[6];
extern u32 mac_param_chan;
extern u8 allow_assoc;
extern u16 beacon_interval;
extern u8  default_unicast_rate;
extern mac_header_80211_common tx_header_common;
extern u32          next_free_assoc_index;
extern u32			 max_queue_size;
extern char*  access_point_ssid;
extern char*  last_access_point_ssid;
extern char  apmode_default_ssid[];
extern char default_AP_SSID[];
#define		 MAX_PER_FLOW_QUEUE	150
#define MAX_ASSOCIATIONS               8
extern station_info associations[MAX_ASSOCIATIONS+1];

#define ASSOCIATION_ALLOW_NONE          0x0
#define ASSOCIATION_ALLOW_TEMPORARY     0x1
#define ASSOCIATION_ALLOW_PERMANENT     0x3

void enable_associations();
/* WMP_END */

int main();

void ltg_event(u32 id, void* callback_arg);

int ethernet_receive(packet_bd_list* tx_queue_list, u8* eth_dest, u8* eth_src, u16 tx_length);

void mpdu_rx_process(void* pkt_buf_addr, u8 rate, u16 length);
void mpdu_transmit_done(tx_frame_info* tx_mpdu);
void check_tx_queue();

void probe_req_transmit();

void attempt_authentication();

void reset_station_statistics();

int  get_ap_list( ap_info * ap_list, u32 num_ap, u32 * buffer, u32 max_words );

void print_menu();
/* WMP_START */
void print_modechoice_menu();
void print_chan_menu();
void print_beacon_tu_menu();
void print_ssid_menu();
/* WMP_END */
void print_ap_list();
void print_station_status(u8 manual_call);
void ltg_cleanup(u32 id, void* callback_arg);
void bad_fcs_rx_process(void* pkt_buf_addr, u8 rate, u16 length);
void uart_rx(u8 rxByte);


void uart_rx(u8 rxByte);

#endif /* WMP_HIGH_H_ */
