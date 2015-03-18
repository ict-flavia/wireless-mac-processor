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

#ifndef __XL_WLAN_PHY_RX_PMD_AXIW_H__
#define __XL_WLAN_PHY_RX_PMD_AXIW_H__

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
    uint32_t RX_PKT_AGC_GAINS;
    uint32_t RX_PKT_AGC_GAINS_n_bits;
    uint32_t RX_PKT_AGC_GAINS_bin_pt;
    // uint32_t RX_PKT_AGC_GAINS_attr;
    uint32_t RX_PKT_RSSI_AB;
    uint32_t RX_PKT_RSSI_AB_n_bits;
    uint32_t RX_PKT_RSSI_AB_bin_pt;
    // uint32_t RX_PKT_RSSI_AB_attr;
    uint32_t SIGNAL_FIELD;
    uint32_t SIGNAL_FIELD_n_bits;
    uint32_t SIGNAL_FIELD_bin_pt;
    // uint32_t SIGNAL_FIELD_attr;
    uint32_t Status;
    uint32_t Status_n_bits;
    uint32_t Status_bin_pt;
    // uint32_t Status_attr;
    uint32_t DEBUG_GPIO;
    uint32_t DEBUG_GPIO_n_bits;
    uint32_t DEBUG_GPIO_bin_pt;
    // uint32_t DEBUG_GPIO_attr;
    uint32_t RSSI_THRESH;
    uint32_t RSSI_THRESH_n_bits;
    uint32_t RSSI_THRESH_bin_pt;
    // uint32_t RSSI_THRESH_attr;
    uint32_t CONFIG;
    uint32_t CONFIG_n_bits;
    uint32_t CONFIG_bin_pt;
    // uint32_t CONFIG_attr;
    uint32_t DSSS_RX_CONFIG;
    uint32_t DSSS_RX_CONFIG_n_bits;
    uint32_t DSSS_RX_CONFIG_bin_pt;
    // uint32_t DSSS_RX_CONFIG_attr;
    uint32_t PKT_BUF_SEL;
    uint32_t PKT_BUF_SEL_n_bits;
    uint32_t PKT_BUF_SEL_bin_pt;
    // uint32_t PKT_BUF_SEL_attr;
    uint32_t PKTDET_AUTOCORR_CONFIG;
    uint32_t PKTDET_AUTOCORR_CONFIG_n_bits;
    uint32_t PKTDET_AUTOCORR_CONFIG_bin_pt;
    // uint32_t PKTDET_AUTOCORR_CONFIG_attr;
    uint32_t FEC_CONFIG;
    uint32_t FEC_CONFIG_n_bits;
    uint32_t FEC_CONFIG_bin_pt;
    // uint32_t FEC_CONFIG_attr;
    uint32_t Control;
    uint32_t Control_n_bits;
    uint32_t Control_bin_pt;
    // uint32_t Control_attr;
    uint32_t LTS_Corr_Thresh;
    uint32_t LTS_Corr_Thresh_n_bits;
    uint32_t LTS_Corr_Thresh_bin_pt;
    // uint32_t LTS_Corr_Thresh_attr;
    uint32_t LTS_Corr_Config;
    uint32_t LTS_Corr_Config_n_bits;
    uint32_t LTS_Corr_Config_bin_pt;
    // uint32_t LTS_Corr_Config_attr;
    uint32_t PHY_CCA_CONFIG;
    uint32_t PHY_CCA_CONFIG_n_bits;
    uint32_t PHY_CCA_CONFIG_bin_pt;
    // uint32_t PHY_CCA_CONFIG_attr;
    uint32_t PKTDET_RSSI_CONFIG;
    uint32_t PKTDET_RSSI_CONFIG_n_bits;
    uint32_t PKTDET_RSSI_CONFIG_bin_pt;
    // uint32_t PKTDET_RSSI_CONFIG_attr;
    uint32_t FFT_Config;
    uint32_t FFT_Config_n_bits;
    uint32_t FFT_Config_bin_pt;
    // uint32_t FFT_Config_attr;
    // XPS parameters
    Xuint16  DeviceId;
    uint32_t  BaseAddr;
} WLAN_PHY_RX_PMD_AXIW_Config;

extern WLAN_PHY_RX_PMD_AXIW_Config WLAN_PHY_RX_PMD_AXIW_ConfigTable[];

// forward declaration of low-level functions
xc_status_t xc_wlan_phy_rx_pmd_axiw_create(xc_iface_t **iface, void *config_table);
xc_status_t xc_wlan_phy_rx_pmd_axiw_release(xc_iface_t **iface) ;
xc_status_t xc_wlan_phy_rx_pmd_axiw_open(xc_iface_t *iface);
xc_status_t xc_wlan_phy_rx_pmd_axiw_close(xc_iface_t *iface);
xc_status_t xc_wlan_phy_rx_pmd_axiw_read(xc_iface_t *iface, xc_r_addr_t addr, uint32_t *value);
xc_status_t xc_wlan_phy_rx_pmd_axiw_write(xc_iface_t *iface, xc_w_addr_t addr, const uint32_t value);
xc_status_t xc_wlan_phy_rx_pmd_axiw_getshmem(xc_iface_t *iface, const char *name, void **shmem);

#endif

