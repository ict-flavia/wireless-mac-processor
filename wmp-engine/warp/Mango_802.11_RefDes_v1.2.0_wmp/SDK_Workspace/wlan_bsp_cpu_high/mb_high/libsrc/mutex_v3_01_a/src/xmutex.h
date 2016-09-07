/* $Id: xmutex.h,v 1.1.2.2 2010/06/11 06:49:49 sadanan Exp $ */
/******************************************************************************
*
* (c) Copyright 2007-2010 Xilinx, Inc. All rights reserved.
*
* This file contains confidential and proprietary information of Xilinx, Inc.
* and is protected under U.S. and international copyright and other
* intellectual property laws.
*
* DISCLAIMER
* This disclaimer is not a license and does not grant any rights to the
* materials distributed herewith. Except as otherwise provided in a valid
* license issued to you by Xilinx, and to the maximum extent permitted by
* applicable law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND WITH ALL
* FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES AND CONDITIONS, EXPRESS,
* IMPLIED, OR STATUTORY, INCLUDING BUT NOT LIMITED TO WARRANTIES OF
* MERCHANTABILITY, NON-INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE;
* and (2) Xilinx shall not be liable (whether in contract or tort, including
* negligence, or under any other theory of liability) for any loss or damage
* of any kind or nature related to, arising under or in connection with these
* materials, including for any direct, or any indirect, special, incidental,
* or consequential loss or damage (including loss of data, profits, goodwill,
* or any type of loss or damage suffered as a result of any action brought by
* a third party) even if such damage or loss was reasonably foreseeable or
* Xilinx had been advised of the possibility of the same.
*
* CRITICAL APPLICATIONS
* Xilinx products are not designed or intended to be fail-safe, or for use in
* any application requiring fail-safe performance, such as life-support or
* safety devices or systems, Class III medical devices, nuclear facilities,
* applications related to the deployment of airbags, or any other applications
* that could lead to death, personal injury, or severe property or
* environmental damage (individually and collectively, "Critical
* Applications"). Customer assumes the sole risk and liability of any use of
* Xilinx products in Critical Applications, subject only to applicable laws
* and regulations governing limitations on product liability.
*
* THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS PART OF THIS FILE
* AT ALL TIMES.
*
******************************************************************************/
/*****************************************************************************/
/**
*
* @file xmutex.h
*
* The Xilinx Mutex driver. This driver supports the Xilinx Mutex Core. More
* detailed description of the driver operation can be found in the xmutex.c
* file.
*
* <b>Features</b>
*
* The Xilinx Mutex supports the following features:
*   - Provide for synchronization between multiple processors in the
*     system.
*   - Write to lock scheme with CPU ID encoded.
*   - Multiple Mutex locks within a single instance of the device.
*   - An optional user field within each Mutex that can be read or
*     written to by software.
*
* This driver is intended to be RTOS and processor independent. Any needs for
* dynamic memory management, threads or thread mutual exclusion, virtual memory,
* or cache control must be satisfied by the layer above this driver.
* The effective address provided to the XMutex_CfgInitialize() function can be
* either the real, physical address or the remapped virtual address. The
* remapping of this address occurs above this driver, no remapping occurs within
* the driver itself.
*
* <b>Initialization & Configuration</b>
*
* The XMutex_Config structure is used by the driver to configure itself. This
* configuration structure is typically created by the tool-chain based on HW
* build properties.
*
* To support multiple runtime loading and initialization strategies employed by
* various operating systems, the driver instance can be initialized in the
* following way:
*
*   - XMutex_LookupConfig (DeviceId) - Use the device identifier to find the
*     static configuration structure defined in XMutex_g.c. This is setup by
*     the tools. For some operating systems the config structure will be
*     initialized by the software and this call is not needed. This function
*     returns the CfgPtr argument used by the CfgInitialize function described
*     below.
*
*   - XMutex_CfgInitialize (InstancePtr, ConfigPtr, EffectiveAddress) - Uses a
*     configuration structure provided by the caller. If running in a system
*     with address translation, the provided virtual memory base address
*     replaces the physical address present in the configuration structure.
*     The EffectiveAddress argument is required regardless of operating system
*     environment, i.e. in standalone, ConfigPtr->BaseAddress is recommended and
*     not the xparameters definition..
*
* <pre>
* MODIFICATION HISTORY:
*
* Ver   Who  Date     Changes
* ----- ---- -------- -----------------------------------------------
* 1.00a va            First release
* 1.00a ecm  06/01/07 Cleanup, new coding standard, check into XCS
* 1.00b ecm  06/01/07 fixed tcl error for number of mutex's, CR502416
* 2.00a hm   04/14/09 Fixed CR 466322, removed extra definitions
*			Also fixed canonical definitions treating an interface
*			as an device instance.
* 3.00a hbm  10/15/09 Migrated to HAL phase 1 to use xil_io, xil_types,
*			and xil_assert.
* 3.01a sdm  05/06/10 New driver to support AXI version of the core and
*		      cleaned up for coding guidelines.
* </pre>
*
******************************************************************************/

#ifndef XMUTEX_H		/* prevent circular inclusions */
#define XMUTEX_H		/* by using protection macros */

#ifdef __cplusplus
extern "C" {
#endif

/***************************** Include Files *********************************/

#include "xstatus.h"
#include "xmutex_hw.h"
#include "xil_types.h"

/************************** Constant Definitions *****************************/

/**************************** Type Definitions *******************************/

/**
 * This typedef contains configuration information for the device.
 */
typedef struct {
	u16 DeviceId;	/**< Unique ID of device */
	u32 BaseAddress;/**< Register base address */
	u32 NumMutex;	/**< Number of Mutexes in this device */
	 u8 UserReg;	/**< User Register, access not controlled by Mutex */
} XMutex_Config;


/**
 * The XMutex driver instance data. The user is required to allocate a
 * variable of this type for every Mutex device in the system. A
 * pointer to a variable of this type is then passed to the driver API
 * functions.
 */
typedef struct {
	XMutex_Config Config; /**< Configuration data, includes base address */
	u32 IsReady;	      /**< Device is initialized and ready */
} XMutex;


/***************** Macros (Inline Functions) Definitions *********************/


/************************** Function Prototypes ******************************/

/*
 * Required functions, in file xmutex.c
 */
int XMutex_CfgInitialize(XMutex *InstancePtr, XMutex_Config *ConfigPtr,
			 u32 EffectiveAddress);
void XMutex_Lock(XMutex *InstancePtr, u8 MutexNumber);
int XMutex_Trylock(XMutex *InstancePtr, u8 MutexNumber);
int XMutex_Unlock(XMutex *InstancePtr, u8 MutexNumber);
int XMutex_IsLocked(XMutex *InstancePtr, u8 MutexNumber);
void XMutex_GetStatus(XMutex *InstancePtr, u8 MutexNumber, u32 *Locked,
			u32 *Owner);
int XMutex_GetUser(XMutex *InstancePtr, u8 MutexNumber, u32 *User);
int XMutex_SetUser(XMutex *InstancePtr, u8 MutexNumber, u32 User);

/*
 * Static Initialization function, in file xmutex_sinit.c
 */
XMutex_Config *XMutex_LookupConfig(u16 DeviceId);

/*
 * Functions for self-test, in file xmutex_selftest.c
 */
int XMutex_SelfTest(XMutex *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif /* end of protection macro */
