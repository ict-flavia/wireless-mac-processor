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

#include "wlan_agc_axiw.h"
#include "xparameters.h"
#include "xil_io.h"
#include "xcope.h"

inline xc_status_t xc_wlan_agc_axiw_create(xc_iface_t **iface, void *config_table)
{
    // set up iface
    *iface = (xc_iface_t *) config_table;

#ifdef XC_DEBUG
    WLAN_AGC_AXIW_Config *_config_table = config_table;

    if (_config_table->xc_create == NULL) {
        print("config_table.xc_create == NULL\r\n");
        exit(1);
    }
#endif

    // does nothing
    return XC_SUCCESS;
}

inline xc_status_t xc_wlan_agc_axiw_release(xc_iface_t **iface) 
{
    // does nothing
    return XC_SUCCESS;
}

inline xc_status_t xc_wlan_agc_axiw_open(xc_iface_t *iface)
{
    // does nothing
    return XC_SUCCESS;
}

inline xc_status_t xc_wlan_agc_axiw_close(xc_iface_t *iface)
{
    // does nothing
    return XC_SUCCESS;
}

inline xc_status_t xc_wlan_agc_axiw_read(xc_iface_t *iface, xc_r_addr_t addr, uint32_t *value)
{
    *value = Xil_In32((uint32_t *) addr);
    return XC_SUCCESS;
}

inline xc_status_t xc_wlan_agc_axiw_write(xc_iface_t *iface, xc_w_addr_t addr, const uint32_t value)
{
    Xil_Out32((uint32_t *) addr, value);
    return XC_SUCCESS;
}

xc_status_t xc_wlan_agc_axiw_getshmem(xc_iface_t *iface, const char *name, void **shmem)
{
    WLAN_AGC_AXIW_Config *_config_table = (WLAN_AGC_AXIW_Config *) iface;

    if (strcmp("TIMING_RESET", name) == 0) {
        *shmem = (void *) & _config_table->TIMING_RESET;
    } else if (strcmp("RSSI_PWR_CALIB", name) == 0) {
        *shmem = (void *) & _config_table->RSSI_PWR_CALIB;
    } else if (strcmp("IIR_COEF_B0", name) == 0) {
        *shmem = (void *) & _config_table->IIR_COEF_B0;
    } else if (strcmp("IIR_COEF_A1", name) == 0) {
        *shmem = (void *) & _config_table->IIR_COEF_A1;
    } else if (strcmp("RESET", name) == 0) {
        *shmem = (void *) & _config_table->RESET;
    } else if (strcmp("TIMING_AGC", name) == 0) {
        *shmem = (void *) & _config_table->TIMING_AGC;
    } else if (strcmp("TARGET", name) == 0) {
        *shmem = (void *) & _config_table->TARGET;
    } else if (strcmp("CONFIG", name) == 0) {
        *shmem = (void *) & _config_table->CONFIG;
    } else if (strcmp("TIMING_DCO", name) == 0) {
        *shmem = (void *) & _config_table->TIMING_DCO;
    }
    else { *shmem = NULL; return XC_FAILURE; }

    return XC_SUCCESS;
}
