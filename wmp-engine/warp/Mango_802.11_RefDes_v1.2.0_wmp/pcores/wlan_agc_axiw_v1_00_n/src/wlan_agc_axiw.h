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

#ifndef __XL_WLAN_AGC_AXIW_H__
#define __XL_WLAN_AGC_AXIW_H__

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
    uint32_t TIMING_RESET;
    uint32_t TIMING_RESET_n_bits;
    uint32_t TIMING_RESET_bin_pt;
    // uint32_t TIMING_RESET_attr;
    uint32_t RSSI_PWR_CALIB;
    uint32_t RSSI_PWR_CALIB_n_bits;
    uint32_t RSSI_PWR_CALIB_bin_pt;
    // uint32_t RSSI_PWR_CALIB_attr;
    uint32_t IIR_COEF_B0;
    uint32_t IIR_COEF_B0_n_bits;
    uint32_t IIR_COEF_B0_bin_pt;
    // uint32_t IIR_COEF_B0_attr;
    uint32_t IIR_COEF_A1;
    uint32_t IIR_COEF_A1_n_bits;
    uint32_t IIR_COEF_A1_bin_pt;
    // uint32_t IIR_COEF_A1_attr;
    uint32_t RESET;
    uint32_t RESET_n_bits;
    uint32_t RESET_bin_pt;
    // uint32_t RESET_attr;
    uint32_t TIMING_AGC;
    uint32_t TIMING_AGC_n_bits;
    uint32_t TIMING_AGC_bin_pt;
    // uint32_t TIMING_AGC_attr;
    uint32_t TARGET;
    uint32_t TARGET_n_bits;
    uint32_t TARGET_bin_pt;
    // uint32_t TARGET_attr;
    uint32_t CONFIG;
    uint32_t CONFIG_n_bits;
    uint32_t CONFIG_bin_pt;
    // uint32_t CONFIG_attr;
    uint32_t TIMING_DCO;
    uint32_t TIMING_DCO_n_bits;
    uint32_t TIMING_DCO_bin_pt;
    // uint32_t TIMING_DCO_attr;
    // XPS parameters
    Xuint16  DeviceId;
    uint32_t  BaseAddr;
} WLAN_AGC_AXIW_Config;

extern WLAN_AGC_AXIW_Config WLAN_AGC_AXIW_ConfigTable[];

// forward declaration of low-level functions
xc_status_t xc_wlan_agc_axiw_create(xc_iface_t **iface, void *config_table);
xc_status_t xc_wlan_agc_axiw_release(xc_iface_t **iface) ;
xc_status_t xc_wlan_agc_axiw_open(xc_iface_t *iface);
xc_status_t xc_wlan_agc_axiw_close(xc_iface_t *iface);
xc_status_t xc_wlan_agc_axiw_read(xc_iface_t *iface, xc_r_addr_t addr, uint32_t *value);
xc_status_t xc_wlan_agc_axiw_write(xc_iface_t *iface, xc_w_addr_t addr, const uint32_t value);
xc_status_t xc_wlan_agc_axiw_getshmem(xc_iface_t *iface, const char *name, void **shmem);

#endif

