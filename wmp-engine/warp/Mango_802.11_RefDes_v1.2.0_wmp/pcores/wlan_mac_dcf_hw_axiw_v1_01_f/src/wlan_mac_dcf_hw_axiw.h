///////////////////////////////////////////////////////////////-*-C-*-
//
// Copyright (c) 2011 Xilinx, Inc.  All rights reserved.
//
// Xilinx, Inc.  XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION
// "AS IS" AS  A COURTESY TO YOU.  BY PROVIDING  THIS DESIGN, CODE, OR
// INFORMATION  AS  ONE   POSSIBLE  IMPLEMENTATION  OF  THIS  FEATURE,
// APPLICATION OR  STANDARD, XILINX  IS MAKING NO  REPRESENTATION THAT
// THIS IMPLEMENTATION  IS FREE FROM  ANY CLAIMS OF  INFRINGEMENT, AND
// YOU ARE  RESPONSIBLE FOR OBTAINING  ANY RIGHTS YOU MAY  REQUIRE FOR
// YOUR  IMPLEMENTATION.   XILINX  EXPRESSLY  DISCLAIMS  ANY  WARRANTY
// WHATSOEVER  WITH RESPECT  TO  THE ADEQUACY  OF THE  IMPLEMENTATION,
// INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR REPRESENTATIONS THAT
// THIS IMPLEMENTATION  IS FREE  FROM CLAIMS OF  INFRINGEMENT, IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
// 
//////////////////////////////////////////////////////////////////////

#ifndef __XL_WLAN_MAC_DCF_HW_AXIW_H__
#define __XL_WLAN_MAC_DCF_HW_AXIW_H__

#include "xbasic_types.h"
#include "xstatus.h"
#include "xcope.h"

typedef struct {
    uint32_t version;
    // Pointers to low-level functions
    xc_status_t (*xc_create)(xc_iface_t **, void *);
    xc_status_t (*xc_release)(xc_iface_t **);
    xc_status_t (*xc_open)(xc_iface_t *);
    xc_status_t (*xc_close)(xc_iface_t *);
    xc_status_t (*xc_read)(xc_iface_t *, xc_r_addr_t, uint32_t *);
    xc_status_t (*xc_write)(xc_iface_t *, xc_w_addr_t, const uint32_t);
    xc_status_t (*xc_get_shmem)(xc_iface_t *, const char *, void **shmem);
    // Optional parameters
    // (empty)
    // Memory map information
    uint32_t TX_START_TIMESTAMP_MSB;
    uint32_t TX_START_TIMESTAMP_MSB_n_bits;
    uint32_t TX_START_TIMESTAMP_MSB_bin_pt;
    // uint32_t TX_START_TIMESTAMP_MSB_attr;
    uint32_t TX_START_TIMESTAMP_LSB;
    uint32_t TX_START_TIMESTAMP_LSB_n_bits;
    uint32_t TX_START_TIMESTAMP_LSB_bin_pt;
    // uint32_t TX_START_TIMESTAMP_LSB_attr;
    uint32_t NAV_VALUE;
    uint32_t NAV_VALUE_n_bits;
    uint32_t NAV_VALUE_bin_pt;
    // uint32_t NAV_VALUE_attr;
    uint32_t RX_START_TIMESTAMP_MSB;
    uint32_t RX_START_TIMESTAMP_MSB_n_bits;
    uint32_t RX_START_TIMESTAMP_MSB_bin_pt;
    // uint32_t RX_START_TIMESTAMP_MSB_attr;
    uint32_t RX_START_TIMESTAMP_LSB;
    uint32_t RX_START_TIMESTAMP_LSB_n_bits;
    uint32_t RX_START_TIMESTAMP_LSB_bin_pt;
    // uint32_t RX_START_TIMESTAMP_LSB_attr;
    uint32_t RX_RATE_LENGTH;
    uint32_t RX_RATE_LENGTH_n_bits;
    uint32_t RX_RATE_LENGTH_bin_pt;
    // uint32_t RX_RATE_LENGTH_attr;
    uint32_t TIMESTAMP_MSB;
    uint32_t TIMESTAMP_MSB_n_bits;
    uint32_t TIMESTAMP_MSB_bin_pt;
    // uint32_t TIMESTAMP_MSB_attr;
    uint32_t TIMESTAMP_LSB;
    uint32_t TIMESTAMP_LSB_n_bits;
    uint32_t TIMESTAMP_LSB_bin_pt;
    // uint32_t TIMESTAMP_LSB_attr;
    uint32_t LATEST_RX_BYTE;
    uint32_t LATEST_RX_BYTE_n_bits;
    uint32_t LATEST_RX_BYTE_bin_pt;
    // uint32_t LATEST_RX_BYTE_attr;
    uint32_t Status;
    uint32_t Status_n_bits;
    uint32_t Status_bin_pt;
    // uint32_t Status_attr;
    uint32_t AUTO_TX_PARAMS;
    uint32_t AUTO_TX_PARAMS_n_bits;
    uint32_t AUTO_TX_PARAMS_bin_pt;
    // uint32_t AUTO_TX_PARAMS_attr;
    uint32_t CALIB_TIMES;
    uint32_t CALIB_TIMES_n_bits;
    uint32_t CALIB_TIMES_bin_pt;
    // uint32_t CALIB_TIMES_attr;
    uint32_t IFS_INTERVALS2;
    uint32_t IFS_INTERVALS2_n_bits;
    uint32_t IFS_INTERVALS2_bin_pt;
    // uint32_t IFS_INTERVALS2_attr;
    uint32_t IFS_INTERVALS1;
    uint32_t IFS_INTERVALS1_n_bits;
    uint32_t IFS_INTERVALS1_bin_pt;
    // uint32_t IFS_INTERVALS1_attr;
    uint32_t TX_START;
    uint32_t TX_START_n_bits;
    uint32_t TX_START_bin_pt;
    // uint32_t TX_START_attr;
    uint32_t MPDU_TX_PARAMS;
    uint32_t MPDU_TX_PARAMS_n_bits;
    uint32_t MPDU_TX_PARAMS_bin_pt;
    // uint32_t MPDU_TX_PARAMS_attr;
    uint32_t Control;
    uint32_t Control_n_bits;
    uint32_t Control_bin_pt;
    // uint32_t Control_attr;
    uint32_t TIMESTAMP_SET_LSB;
    uint32_t TIMESTAMP_SET_LSB_n_bits;
    uint32_t TIMESTAMP_SET_LSB_bin_pt;
    // uint32_t TIMESTAMP_SET_LSB_attr;
    uint32_t TIMESTAMP_SET_MSB;
    uint32_t TIMESTAMP_SET_MSB_n_bits;
    uint32_t TIMESTAMP_SET_MSB_bin_pt;
    // uint32_t TIMESTAMP_SET_MSB_attr;
    uint32_t BACKOFF_CTRL;
    uint32_t BACKOFF_CTRL_n_bits;
    uint32_t BACKOFF_CTRL_bin_pt;
    // uint32_t BACKOFF_CTRL_attr;
    uint32_t MPDU_TX_GAINS;
    uint32_t MPDU_TX_GAINS_n_bits;
    uint32_t MPDU_TX_GAINS_bin_pt;
    // uint32_t MPDU_TX_GAINS_attr;
    uint32_t AUTO_TX_GAINS;
    uint32_t AUTO_TX_GAINS_n_bits;
    uint32_t AUTO_TX_GAINS_bin_pt;
    // uint32_t AUTO_TX_GAINS_attr;
    uint32_t TIMESTAMP_INSERT_OFFSET;
    uint32_t TIMESTAMP_INSERT_OFFSET_n_bits;
    uint32_t TIMESTAMP_INSERT_OFFSET_bin_pt;
    // uint32_t TIMESTAMP_INSERT_OFFSET_attr;
    // XPS parameters
    Xuint16  DeviceId;
    uint32_t  BaseAddr;
} WLAN_MAC_DCF_HW_AXIW_Config;

extern WLAN_MAC_DCF_HW_AXIW_Config WLAN_MAC_DCF_HW_AXIW_ConfigTable[];

// forward declaration of low-level functions
xc_status_t xc_wlan_mac_dcf_hw_axiw_create(xc_iface_t **iface, void *config_table);
xc_status_t xc_wlan_mac_dcf_hw_axiw_release(xc_iface_t **iface) ;
xc_status_t xc_wlan_mac_dcf_hw_axiw_open(xc_iface_t *iface);
xc_status_t xc_wlan_mac_dcf_hw_axiw_close(xc_iface_t *iface);
xc_status_t xc_wlan_mac_dcf_hw_axiw_read(xc_iface_t *iface, xc_r_addr_t addr, uint32_t *value);
xc_status_t xc_wlan_mac_dcf_hw_axiw_write(xc_iface_t *iface, xc_w_addr_t addr, const uint32_t value);
xc_status_t xc_wlan_mac_dcf_hw_axiw_getshmem(xc_iface_t *iface, const char *name, void **shmem);

#endif

