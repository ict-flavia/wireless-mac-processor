/*
 * wmp_high_util.h
 *
 *  Created on: Nov 8, 2013
 *      Author: Nicolo' Facchi
 */

#ifndef WMP_HIGH_UTIL_H_
#define WMP_HIGH_UTIL_H_

#include "wlan_mac_util.h"
#include "wlan_mac_packet_types.h"
#include "string.h"
#include "wmp_high.h"

#define WMP4WARP_ETHER_TYPE			0x108 /* big endian */

#define MODEOFOPERATION_STA			0x00
#define MODEOFOPERATION_AP			0x01

#define WMP_HIGH_TEST_FAKE_ASSOC		1
#define WMP_HIGH_TEST_FAKE_ASSOC_ADDR	\
	{0x00, 0x14, 0xA4, 0x62, 0xC7, 0x9E}
#define WMP_HIGH_UTIL_FAKE_ASSOC_RATE	WLAN_MAC_RATE_24M


#define WMP_HIGH_UTIL_TX_BUF_FREE			0x00000001
#define WMP_HIGH_UTIL_TX_BUF_NEXT			0x00000002
#define WMP_HIGH_UTIL_TX_BUF_TO_CPU_LOW		0x00000004
#define WMP_HIGH_UTIL_TX_BUF_ACCEPTED		0x00000008

struct wmp_high_util_tx_buf_info {
	u32 flags;
	u64 timestamp;
};

#define WMP_HIGH_PL_LEVEL WMP_HIGH_PL_INFO

#define WMP_HIGH_PL_NONE				0
#define WMP_HIGH_PL_INFO				1
#define WMP_HIGH_PL_ERROR 			2
#define WMP_HIGH_PL_WARNING  		3
#define WMP_HIGH_PL_DEBUG 			4
#define WMP_HIGH_PL_VERBOSE  		5
#define WMP_HIGH_PL_VERYVERBOSE  	6
#define WMP_HIGH_PL_VERYVERYVERBOSE  7

#define wmp_high_printf(severity,format,args...) \
	do { \
	 if(WMP_HIGH_PL_LEVEL>=severity){xil_printf(format, ##args);} \
	} while(0)

extern wlan_mac_hw_info   	hw_info;

#define WMP_HIGH_UTIL_RX_BUF_RESERVED_WMP_CMD	15

#define WMP4WARP_ECHO_REQ_CMD   		0x0001
#define WMP4WARP_ECHO_REP_CMD   		0x0002
#define WMP4WARP_FSM_LOAD          		0x0003
#define WMP4WARP_FSM_LOAD_CONF     		0x0004
#define WMP4WARP_FSM_DEL          		0x0005
#define WMP4WARP_FSM_DEL_CONF     		0x0006
#define WMP4WARP_TS_REQ             	0x0007
#define WMP4WARP_TS_REP             	0x0008
#define WMP4WARP_RUN                 	0x0009
#define WMP4WARP_RUN_CONF            	0x000a
#define WMP4WARP_RUN_ABS             	0x000b
#define WMP4WARP_RUN_ABS_CONF        	0x000c
#define WMP4WARP_READ_VAR               0x000d
#define WMP4WARP_READ_VAR_REP           0x000e

#define WMP_CMD_FRAME_MAX_SIZE	1500

struct __attribute__((__packed__)) wmp4warp_header_common {
     u16   cmd_id;
     u8	mac_addr[6];
};

struct __attribute__((__packed__)) wmp4warp_header_fsm_load {
     u16   fsm_id;
     u16   fsm_l;
};

struct __attribute__((__packed__)) wmp4warp_header_fsm_load_conf {
     u16   fsm_id;
};

struct __attribute__((__packed__)) wmp4warp_header_fsm_del {
     u16   fsm_id;
};

struct __attribute__((__packed__)) wmp4warp_header_fsm_del_conf {
     u16   fsm_id;
};

struct __attribute__((__packed__)) wmp4warp_header_ts_rep {
     u64   ts;
};

struct __attribute__((__packed__)) wmp4warp_header_read_var {
     u32   var_id;
};

struct __attribute__((__packed__)) wmp4warp_header_read_var_rep {
     u32   var_id;
     u16   var_value;
};

struct __attribute__((__packed__)) wmp4warp_header_run {
        u16   fsm_id;
        u64   ts;
};

struct __attribute__((__packed__)) wmp4warp_header_run_conf {
		u16   fsm_id;
	    u64   ts;
};

struct __attribute__((__packed__)) wmp4warp_header_run_abs {
        u16   fsm_id;
        u64   ts;
};

struct __attribute__((__packed__)) wmp4warp_header_run_abs_conf {
        u16   fsm_id;
        u64   ts;
};

#define MAC_HEADER_L            		sizeof(ethernet_header)
#define WMP4WARP_ECHO_REQ_L     		(MAC_HEADER_L + (sizeof(struct wmp4warp_header_common)))
#define WMP4WARP_ECHO_REP_L     		(MAC_HEADER_L + (sizeof(struct wmp4warp_header_common)))
#define WMP4WARP_FSM_LOAD_L     		(MAC_HEADER_L + (sizeof(struct wmp4warp_header_common)) + (sizeof(struct wmp4warp_header_fsm_load)))
#define WMP4WARP_FSM_LOAD_CONF_L        (MAC_HEADER_L + (sizeof(struct wmp4warp_header_common)) + (sizeof(struct wmp4warp_header_fsm_load_conf)))
#define WMP4WARP_FSM_DEL_L     			(MAC_HEADER_L + (sizeof(struct wmp4warp_header_common)) + (sizeof(struct wmp4warp_header_fsm_del)))
#define WMP4WARP_FSM_DEL_CONF_L        	(MAC_HEADER_L + (sizeof(struct wmp4warp_header_common)) + (sizeof(struct wmp4warp_header_fsm_del_conf)))
#define WMP4WARP_TS_REQ_L               (MAC_HEADER_L + (sizeof(struct wmp4warp_header_common)))
#define WMP4WARP_TS_REP_L               (MAC_HEADER_L + (sizeof(struct wmp4warp_header_common)) + (sizeof(struct wmp4warp_header_ts_rep)))
#define WMP4WARP_RUN_L                  (MAC_HEADER_L + (sizeof(struct wmp4warp_header_common)) + (sizeof(struct wmp4warp_header_run)))
#define WMP4WARP_RUN_CONF_L             (MAC_HEADER_L + (sizeof(struct wmp4warp_header_common)) + (sizeof(struct wmp4warp_header_run_conf)))
#define WMP4WARP_RUN_ABS_L              (MAC_HEADER_L + (sizeof(struct wmp4warp_header_common)) + (sizeof(struct wmp4warp_header_run_abs)))
#define WMP4WARP_RUN_ABS_CONF_L         (MAC_HEADER_L + (sizeof(struct wmp4warp_header_common)) + (sizeof(struct wmp4warp_header_run_abs_conf)))
#define WMP4WARP_READ_VAR_L             (MAC_HEADER_L + (sizeof(struct wmp4warp_header_common)) + (sizeof(struct wmp4warp_header_read_var)))
#define WMP4WARP_READ_VAR_REP_L         (MAC_HEADER_L + (sizeof(struct wmp4warp_header_common)) + (sizeof(struct wmp4warp_header_read_var_rep)))


extern u8 wmp_cmd_resp[WMP_CMD_FRAME_MAX_SIZE];

void wmp_high_fsm_init();
void wmp_high_util_create_fake_assoc(station_info *access_point);
u32 get_wmp_tx_buf_info(int index);
void set_wmp_tx_buf_info(int index, u32 flag_val);
void wmp_high_util_update_beacon_template();
void wmp_high_util_handle_wmp_cmd_from_ethernet(ethernet_header* eth_hdr);


#endif /* WMP_HIGH_UTIL_H_ */
