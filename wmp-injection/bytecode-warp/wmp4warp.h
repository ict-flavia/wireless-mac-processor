#ifndef _WMP4WARP_H_
#define _WMP4WARP_H_

#include <inttypes.h>

#define WARP_LIST_FILE_NAME     "warplist"

#define WMP4WARP_ETHER_TYPE     2049

#define WMP4WARP_ETHER_TYPE_STR     "2049"

#define MAX_FRAME_LENGTH        1500

#define WMP4WARP_ECHO_REQ_CMD           0x0001
#define WMP4WARP_ECHO_REP_CMD           0x0002
#define WMP4WARP_FSM_LOAD               0x0003
#define WMP4WARP_FSM_LOAD_CONF          0x0004
#define WMP4WARP_FSM_DEL                0x0005
#define WMP4WARP_FSM_DEL_CONF           0x0006
#define WMP4WARP_TS_REQ                 0x0007
#define WMP4WARP_TS_REP                 0x0008
#define WMP4WARP_RUN                 0x0009
#define WMP4WARP_RUN_CONF            0x000a
#define WMP4WARP_RUN_ABS             0x000b
#define WMP4WARP_RUN_ABS_CONF        0x000c
#define WMP4WARP_READ_VAR                0x000d
#define WMP4WARP_READ_VAR_REP            0x000e

struct __attribute__((__packed__)) packet_header {
     uint8_t mac_dst[6];
     uint8_t mac_src[6];
     uint16_t ether_type;
};

struct __attribute__((__packed__)) wmp4warp_header_common {
     uint16_t   cmd_id;
     uint8_t mac_addr[6];
};

struct __attribute__((__packed__)) wmp4warp_header_fsm_load {
     uint16_t   fsm_id;
     uint16_t   fsm_l;
};

struct __attribute__((__packed__)) wmp4warp_header_fsm_load_conf {
     uint16_t   fsm_id;
};

struct __attribute__((__packed__)) wmp4warp_header_fsm_del {
     uint16_t   fsm_id;
};

struct __attribute__((__packed__)) wmp4warp_header_fsm_del_conf {
     uint16_t   fsm_id;
};

struct __attribute__((__packed__)) wmp4warp_header_ts_rep {
     uint64_t   ts;
};

struct __attribute__((__packed__)) wmp4warp_header_read_var {
     uint32_t   var_id;
};

struct __attribute__((__packed__)) wmp4warp_header_read_var_rep {
     uint32_t   var_id;
     uint16_t   var_value;
};

struct __attribute__((__packed__)) wmp4warp_header_run {
        uint16_t   fsm_id;
        uint64_t   ts;
};

struct __attribute__((__packed__)) wmp4warp_header_run_conf {
        uint16_t   fsm_id;
        uint64_t   ts;
};

struct __attribute__((__packed__)) wmp4warp_header_run_abs {
        uint16_t   fsm_id;
        uint64_t   ts;
};

struct __attribute__((__packed__)) wmp4warp_header_run_abs_conf {
        uint16_t   fsm_id;
        uint64_t   ts;
};

struct warpinfo {
        char *name;
        uint8_t mac_addr[6];
};

struct wmp4warp {
        char *out_interface_name;
        uint8_t local_mac_addr[6];
        uint8_t broadcast_mac_addr[6];
        uint8_t warp_mac_addr[6];
        char *warp_name;
        uint16_t cmd;
        uint16_t cmd_wait;

        char *fsm_file_name;
        uint8_t fsm[MAX_FRAME_LENGTH];
        uint16_t fsm_size;
        uint16_t fsm_id;

        uint32_t warp_counter;

        uint64_t run_ts;

        uint32_t var_id;

        struct warpinfo *warplist;
};


#define MAC_HEADER_L                    sizeof(struct packet_header)
#define WMP4WARP_ECHO_REQ_L             (MAC_HEADER_L + (sizeof(struct wmp4warp_header_common)))
#define WMP4WARP_ECHO_REP_L             (MAC_HEADER_L + (sizeof(struct wmp4warp_header_common)))
#define WMP4WARP_FSM_LOAD_L             (MAC_HEADER_L + (sizeof(struct wmp4warp_header_common)) + (sizeof(struct wmp4warp_header_fsm_load)))
#define WMP4WARP_FSM_LOAD_CONF_L        (MAC_HEADER_L + (sizeof(struct wmp4warp_header_common)) + (sizeof(struct wmp4warp_header_fsm_load_conf)))
#define WMP4WARP_FSM_DEL_L              (MAC_HEADER_L + (sizeof(struct wmp4warp_header_common)) + (sizeof(struct wmp4warp_header_fsm_del)))
#define WMP4WARP_FSM_DEL_CONF_L         (MAC_HEADER_L + (sizeof(struct wmp4warp_header_common)) + (sizeof(struct wmp4warp_header_fsm_del_conf)))
#define WMP4WARP_TS_REQ_L               (MAC_HEADER_L + (sizeof(struct wmp4warp_header_common)))
#define WMP4WARP_TS_REP_L               (MAC_HEADER_L + (sizeof(struct wmp4warp_header_common)) + (sizeof(struct wmp4warp_header_ts_rep)))
#define WMP4WARP_RUN_L                  (MAC_HEADER_L + (sizeof(struct wmp4warp_header_common)) + (sizeof(struct wmp4warp_header_run)))
#define WMP4WARP_RUN_CONF_L             (MAC_HEADER_L + (sizeof(struct wmp4warp_header_common)) + (sizeof(struct wmp4warp_header_run_conf)))
#define WMP4WARP_RUN_ABS_L              (MAC_HEADER_L + (sizeof(struct wmp4warp_header_common)) + (sizeof(struct wmp4warp_header_run_abs)))
#define WMP4WARP_RUN_ABS_CONF_L         (MAC_HEADER_L + (sizeof(struct wmp4warp_header_common)) + (sizeof(struct wmp4warp_header_run_abs_conf)))
#define WMP4WARP_READ_VAR_L             (MAC_HEADER_L + (sizeof(struct wmp4warp_header_common)) + (sizeof(struct wmp4warp_header_read_var)))
#define WMP4WARP_READ_VAR_REP_L         (MAC_HEADER_L + (sizeof(struct wmp4warp_header_common)) + (sizeof(struct wmp4warp_header_read_var_rep)))


#endif /* _WMP4WARP_H_ */
