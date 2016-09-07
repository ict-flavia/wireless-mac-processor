////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2004 Xilinx, Inc.  All rights reserved. 
// 
// Xilinx, Inc. 
// XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS" AS A 
// COURTESY TO YOU.  BY PROVIDING THIS DESIGN, CODE, OR INFORMATION AS 
// ONE POSSIBLE   IMPLEMENTATION OF THIS FEATURE, APPLICATION OR 
// STANDARD, XILINX IS MAKING NO REPRESENTATION THAT THIS IMPLEMENTATION 
// IS FREE FROM ANY CLAIMS OF INFRINGEMENT, AND YOU ARE RESPONSIBLE 
// FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE FOR YOUR IMPLEMENTATION. 
// XILINX EXPRESSLY DISCLAIMS ANY WARRANTY WHATSOEVER WITH RESPECT TO 
// THE ADEQUACY OF THE IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO 
// ANY WARRANTIES OR REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE 
// FROM CLAIMS OF INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY 
// AND FITNESS FOR A PARTICULAR PURPOSE. 
// 
// File   : eth.c
// Date   : 2002, March 20.
// Author : Sathya Thammanur
// Company: Xilinx
// Group  : Emerging Software Technologies
//
// Summary:
// Ethernet layer specific functions
//
// $Id: eth.c,v 1.2.8.6 2005/11/15 23:41:10 salindac Exp $
//
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// see copyright.txt for Rice University/Mango Communications modifications
////////////////////////////////////////////////////////////////////////////////


/***************************** Include Files *********************************/

#include <string.h>
#include <xilnet_config.h>
#include <xilnet_xilsock.h>

#include "xio.h"
#include "stdio.h"


/*************************** Constant Definitions ****************************/

// Defines for consolidated error message function
#define XILNET_ETH_ERR_NUM_DEV                             1
#define XILNET_ETH_ERR_USES_DRIVER                         2
#define XILNET_ETH_ERR_INF_DNE                             3
#define XILNET_ETH_ERR_INF_NOT_CONFIG                      4

// #define _DEBUG_XILNET_HW_TABLE_

/*********************** Global Variable Definitions *************************/



/*************************** Variable Definitions ****************************/


// Xilnet HW Address Table
//   Note:  There is only one address table to be shared among all the
//       Ethernet devices.  This can be updated in the future.
struct xilnet_hw_addr_table xilnet_hw_tbl[HW_ADDR_TBL_ENTRIES];


// Flags
unsigned char             ishwaddrinit = 0;
static unsigned long long curr_age     = 0;


/*************************** Function Prototypes *****************************/

#ifdef _DEBUG_
void print_pkt(unsigned char *buf, int size);

#if 0
void print_hw_tbl();
#endif

#ifdef 	XILNET_AXI_DMA_INF_USED
void print_XAxiDma_Bd( XAxiDma_Bd *BD_ptr );
void print_XAxiDma_BdRing( XAxiDma_BdRing *BD_RING_ptr );
void print_XAxiDma_Config( XAxiDma_Config * DMA_CFG_ptr );
#endif

#ifdef XILNET_AXI_FIFO_INF_USED
void print_XLlFifo( XLlFifo * FIFO_ptr );
#endif

#endif


/******************************** Functions **********************************/

void xilnet_eth_print_err_msg( unsigned int msg_num, unsigned int eth_dev_num ) {

    switch( msg_num ) {

    case XILNET_ETH_ERR_NUM_DEV:
		xil_printf("  **** ERROR:  Trying to use Ethernet device %c.  Only %d configured in the HW. \n", wn_conv_eth_dev_num(eth_dev_num), XILNET_NUM_ETH_DEVICES);    
    break;
    
    case XILNET_ETH_ERR_USES_DRIVER:
		xil_printf("  **** ERROR:  Ethernet device %c is not supported by the WARPxilnet library.  \n", wn_conv_eth_dev_num(eth_dev_num) );
		xil_printf("               Please check library configuration in the BSP.   \n" );
    break;

    case XILNET_ETH_ERR_INF_DNE:
        xil_printf("  **** ERROR:  Trying to use Ethernet device %c.  Interface %d does not exist. \n", wn_conv_eth_dev_num(eth_dev_num), eth_device[eth_dev_num].inf_type);
    break;

    case XILNET_ETH_ERR_INF_NOT_CONFIG:
		xil_printf("  **** ERROR:  Trying to use Ethernet device %c.  Driver not configured to use ", wn_conv_eth_dev_num(eth_dev_num));    
    break;
    }
}



int xilnet_eth_device_init( unsigned int    eth_dev_num,
		                    unsigned int    base_addr,
                            unsigned char * node_ip_addr,
                            unsigned char * node_hw_addr
                          ) {

	int          status;

#ifdef 	XILNET_AXI_DMA_INF_USED
	XAxiDma_Bd   BD_template;
#endif

	// Check to see if we are initializing a valid interface
	if ( eth_dev_num >= XILNET_NUM_ETH_DEVICES ) {
        xilnet_eth_print_err_msg( XILNET_ETH_ERR_NUM_DEV, eth_dev_num );
		return -1;
	}
    
#ifdef _DEBUG_
	xil_printf("xilnet_eth_device_init: Device %c \n", wn_conv_eth_dev_num(eth_dev_num) );
#endif

	// Initialize the Ethernet device structure
	xilnet_init_eth_device_struct(eth_dev_num);

	// Check to see if the xilnet driver uses the Ethernet instance
	if ( !eth_device[eth_dev_num].uses_driver ) {
        xilnet_eth_print_err_msg( XILNET_ETH_ERR_USES_DRIVER, eth_dev_num );
		return -1;
	}
    
	// Set up HW info
	xilnet_eth_set_inf_hw_info(eth_dev_num, node_ip_addr, node_hw_addr);

	// Depending on the interface type, set up the device
    switch( eth_device[eth_dev_num].inf_type ) {

    case XILNET_AXI_FIFO_INF:

#ifdef XILNET_AXI_FIFO_INF_USED

    	xil_printf("  Configuring ETH %c for AXI FIFO mode with %d byte buffers (%d receive, 1 send)\n", wn_conv_eth_dev_num(eth_dev_num), eth_device[eth_dev_num].buf_size, eth_device[eth_dev_num].num_recvbuf );

    	XLlFifo_Initialize( eth_device[eth_dev_num].inf_ref, base_addr);

#ifdef _DEBUG_
	    print_XLlFifo( eth_device[eth_dev_num].inf_ref );
#endif

#else
        xilnet_eth_print_err_msg( XILNET_ETH_ERR_INF_NOT_CONFIG, eth_dev_num );
		xil_printf("AXI FIFO. \n");
		return -1;
#endif
	    break;


    case XILNET_AXI_DMA_INF:

#ifdef XILNET_AXI_DMA_INF_USED
    	xil_printf("  Configuring ETH %c for AXI DMA mode with %d byte buffers (%d receive, 1 send)\n", wn_conv_eth_dev_num(eth_dev_num), eth_device[eth_dev_num].buf_size, eth_device[eth_dev_num].num_recvbuf );

    	// Initialize DMA pointers
    	eth_device[eth_dev_num].inf_cfg_ref      = (void *) XAxiDma_LookupConfig( eth_device[eth_dev_num].inf_id );
    	eth_device[eth_dev_num].dma_rx_ring_ref  = (void *) XAxiDma_GetRxRing( (XAxiDma *)eth_device[eth_dev_num].inf_ref );
    	eth_device[eth_dev_num].dma_tx_ring_ref  = (void *) XAxiDma_GetTxRing( (XAxiDma *)eth_device[eth_dev_num].inf_ref );

#ifdef _DEBUG_
	    print_XAxiDma_Config( eth_device[eth_dev_num].inf_cfg_ref );
#endif

		// Initialize AXIDMA engine. AXIDMA engine must be initialized before AxiEthernet.
		// During AXIDMA engine initialization, AXIDMA hardware is reset, and since AXIDMA
		// reset line is connected to AxiEthernet, this would ensure a reset of AxiEthernet.

		status = XAxiDma_CfgInitialize( (XAxiDma *)eth_device[eth_dev_num].inf_ref, eth_device[eth_dev_num].inf_cfg_ref);
		if(status != XST_SUCCESS) {
			xil_printf("*** Error initializing DMA\n");
		}

		// Setup RX BD space:
		//   - RX_BD_space is a properly aligned area of memory
		//   - No MMU is being used so the physical and virtual addresses are the same.
		//   - Setup a BD template for the channel. This template will be copied to every BD.

#ifdef _DEBUG_
		xil_printf("RX BD Space    = 0x%x\n", eth_device[eth_dev_num].dma_rx_bd_ref);
#endif

		// Create the RX BD ring
		status = XAxiDma_BdRingCreate( eth_device[eth_dev_num].dma_rx_ring_ref,
				                 (u32) eth_device[eth_dev_num].dma_rx_bd_ref,
				                 (u32) eth_device[eth_dev_num].dma_rx_bd_ref,
				                       XILNET_BD_ALIGNMENT,
				                       eth_device[eth_dev_num].dma_rx_bd_cnt);
		if (status != XST_SUCCESS) {
			xil_printf("*** Error setting up RX BD space\n");
		}

		XAxiDma_BdClear(&BD_template);

		status = XAxiDma_BdRingClone(eth_device[eth_dev_num].dma_rx_ring_ref, &BD_template);
		if (status != XST_SUCCESS) {
			xil_printf("*** Error initializing RX BD space\n");
		}

		// Setup TX BD space:
		//   - TX_BD_space is a properly aligned area of memory
		//   - No MMU is being used so the physical and virtual addresses are the same.
		//   - Setup a BD template for the channel. This template will be copied to every BD.

#ifdef _DEBUG_
		xil_printf("TX BD Space    = 0x%x\n", eth_device[eth_dev_num].dma_tx_bd_ref);
#endif

		// Create the TX BD ring
		status = XAxiDma_BdRingCreate( eth_device[eth_dev_num].dma_tx_ring_ref,
				                 (u32) eth_device[eth_dev_num].dma_tx_bd_ref,
				                 (u32) eth_device[eth_dev_num].dma_tx_bd_ref,
				                       XILNET_BD_ALIGNMENT,
				                       eth_device[eth_dev_num].dma_tx_bd_cnt);
		if (status != XST_SUCCESS) {
			xil_printf("*** Error setting up TX BD space\n");
		}

		// We can re-use the BD_template from above
		status = XAxiDma_BdRingClone(eth_device[eth_dev_num].dma_tx_ring_ref, &BD_template);
		if (status != XST_SUCCESS) {
			xil_printf("*** Error initializing TX BD space\n");
		}

#else
        xilnet_eth_print_err_msg( XILNET_ETH_ERR_INF_NOT_CONFIG, eth_dev_num );
		xil_printf("AXI DMA. \n");
		return -1;
#endif
		break;

    case XILNET_TEMAC_INF:

#ifdef XILNET_TEMAC_INF_USED

    	xil_printf("  Configuring ETH %c for TEMAC mode with %d byte buffers (%d receive, 1 send)\n", wn_conv_eth_dev_num(eth_dev_num), eth_device[eth_dev_num].buf_size, eth_device[eth_dev_num].num_recvbuf );

    	// Initialize DMA pointers
    	eth_device[eth_dev_num].inf_dma_cfg_ref      = (void *) XDmaCentral_LookupConfig( eth_device[eth_dev_num].inf_dma_id );

    	//Initialize the config struct
		status = XDmaCentral_CfgInitialize((XDmaCentral *)       eth_device[eth_dev_num].inf_dma_ref,
                                           (XDmaCentral_Config *)eth_device[eth_dev_num].inf_dma_cfg_ref,
				                          ((XDmaCentral_Config *)eth_device[eth_dev_num].inf_dma_cfg_ref)->BaseAddress );
		if(status != XST_SUCCESS) {
			xil_printf("*** Error initializing DMA\n");
		}

    	//Disable Interrupts
    	XDmaCentral_InterruptEnableSet(eth_device[eth_dev_num].inf_dma_ref, 0);

#ifdef _DEBUG_
    	xil_printf("Initializing FIFO: %x     %x    \n", eth_device[eth_dev_num].inf_ref, base_addr);
#endif        

    	// Initialize the FIFO
    	XLlFifo_Initialize( eth_device[eth_dev_num].inf_ref, base_addr);


#else
        xilnet_eth_print_err_msg( XILNET_ETH_ERR_INF_NOT_CONFIG, eth_dev_num );
		xil_printf("TEMAC. \n");
		return -1;
#endif
        break;

    default:
        xilnet_eth_print_err_msg( XILNET_ETH_ERR_INF_DNE, eth_dev_num );
		return -1;
    	break;
    }

#ifdef _DEBUG_
    	xil_printf("xilnet_eth_device_init done\n");
#endif        
        
    return 0;
}



int xilnet_eth_set_inf_hw_info( unsigned int eth_dev_num, unsigned char * node_ip_addr, unsigned char * node_hw_addr ) {

	int i;

	// Check to see if we are initializing a valid interface
	if ( eth_dev_num >= XILNET_NUM_ETH_DEVICES ) {
        xilnet_eth_print_err_msg( XILNET_ETH_ERR_NUM_DEV, eth_dev_num );
		return -1;
	}

	// Check to see if the xilnet driver uses the Ethernet instance
	if ( !eth_device[eth_dev_num].uses_driver ) {
        xilnet_eth_print_err_msg( XILNET_ETH_ERR_USES_DRIVER, eth_dev_num );
		return -1;
	}
    
#ifdef _DEBUG_
	xil_printf("Setting IP Address:  %d.%d.%d.%d \n", node_ip_addr[0], node_ip_addr[1], node_ip_addr[2], node_ip_addr[3]);
	xil_printf("Setting HW Address:  %2x-%2x-%2x-%2x-%2x-%2x \n", node_hw_addr[0], node_hw_addr[1], node_hw_addr[2], node_hw_addr[3], node_hw_addr[4], node_hw_addr[5]);
#endif

    // Update the IP Address
	for ( i = 0; i < IP_VERSION; i++) {
		eth_device[eth_dev_num].node_ip_addr[i] = node_ip_addr[i];
	}

	// Update the MAC Address
	for ( i = 0; i < ETH_ADDR_LEN; i++ ) {
		eth_device[eth_dev_num].node_hw_addr[i] = node_hw_addr[i];
	}

	return 0;
}



int xilnet_eth_get_inf_ip_addr( unsigned int eth_dev_num, unsigned char * node_ip_addr ) {

	int i;

	// Check to see if we are initializing a valid interface
	if ( eth_dev_num >= XILNET_NUM_ETH_DEVICES ) {
        xilnet_eth_print_err_msg( XILNET_ETH_ERR_NUM_DEV, eth_dev_num );
		return -1;
	}

	// Check to see if the xilnet driver uses the Ethernet instance
	if ( !eth_device[eth_dev_num].uses_driver ) {
        xilnet_eth_print_err_msg( XILNET_ETH_ERR_USES_DRIVER, eth_dev_num );
		return -1;
	}
    
    // Update the IP Address
	for ( i = 0; i < IP_VERSION; i++) {
		node_ip_addr[i] = eth_device[eth_dev_num].node_ip_addr[i];
	}

#ifdef _DEBUG_
	xil_printf("Getting IP Address:  %d.%d.%d.%d \n", node_ip_addr[0], node_ip_addr[1], node_ip_addr[2], node_ip_addr[3]);
#endif

	return 0;
}



int xilnet_eth_get_inf_hw_addr( unsigned int eth_dev_num, unsigned char * node_hw_addr ) {

	int i;

	// Check to see if we are initializing a valid interface
	if ( eth_dev_num >= XILNET_NUM_ETH_DEVICES ) {
        xilnet_eth_print_err_msg( XILNET_ETH_ERR_NUM_DEV, eth_dev_num );
		return -1;
	}

	// Check to see if the xilnet driver uses the Ethernet instance
	if ( !eth_device[eth_dev_num].uses_driver ) {
        xilnet_eth_print_err_msg( XILNET_ETH_ERR_USES_DRIVER, eth_dev_num );
		return -1;
	}
    
	// Update the MAC Address
	for ( i = 0; i < ETH_ADDR_LEN; i++ ) {
		node_hw_addr[i] = eth_device[eth_dev_num].node_hw_addr[i];
	}

#ifdef _DEBUG_
	xil_printf("Getting HW Address:  %2x-%2x-%2x-%2x-%2x-%2x \n", node_hw_addr[0], node_hw_addr[1], node_hw_addr[2], node_hw_addr[3], node_hw_addr[4], node_hw_addr[5]);
#endif

	return 0;
}



int xilnet_eth_device_start( unsigned int eth_dev_num ) {

    int              status;
	int              i;
	int              free_BD_count;

#ifdef 	XILNET_AXI_DMA_INF_USED
	XAxiDma_BdRing  *RX_RING_ptr;
	XAxiDma_Bd      *BD_ptr;
	XAxiDma_Bd      *BD_cur_ptr;
#endif

	// Check to see if we are initializing a valid interface
	if ( eth_dev_num >= XILNET_NUM_ETH_DEVICES ) {
        xilnet_eth_print_err_msg( XILNET_ETH_ERR_NUM_DEV, eth_dev_num );
		return -1;
	}
    
    // Check to see if the xilnet driver uses the Ethernet instance
	if ( !eth_device[eth_dev_num].uses_driver ) {
        xilnet_eth_print_err_msg( XILNET_ETH_ERR_USES_DRIVER, eth_dev_num );
		return -1;
	}

	// Depending on the interface type, set up the device
    switch( eth_device[eth_dev_num].inf_type ) {

    case XILNET_AXI_FIFO_INF:

#ifdef XILNET_AXI_FIFO_INF_USED
    	// Do nothing, interface is already ready to go

#ifdef _DEBUG_
    	xil_printf("Starting Ethernet Device %c with AXI FIFO\n", wn_conv_eth_dev_num(eth_dev_num) );
#endif        
        
#else
        xilnet_eth_print_err_msg( XILNET_ETH_ERR_INF_NOT_CONFIG, eth_dev_num );
		xil_printf("AXI FIFO. \n");
		return -1;
#endif

    	break;


    case XILNET_AXI_DMA_INF:

#ifdef XILNET_AXI_DMA_INF_USED

    	// Get the TX Buffer Descriptor Ring pointer
        RX_RING_ptr = (XAxiDma_BdRing *)eth_device[eth_dev_num].dma_rx_ring_ref;

    	// Initialize RX BD space:
        //   - Configure buffer descriptors
    	free_BD_count = XAxiDma_BdRingGetFreeCnt(RX_RING_ptr);

    	// Allocate receive buffers
    	status = XAxiDma_BdRingAlloc(RX_RING_ptr, free_BD_count, &BD_ptr);
    	if (status != XST_SUCCESS) {
    		xil_printf("*** Error allocating RxBD\n");
    		return -1;
    	}

#ifdef _DEBUG_
    	xil_printf("Recieve Buffer = 0x%x    size= %d \n", eth_device[eth_dev_num].recvbuf, sizeof(eth_device[eth_dev_num].recvbuf));
    	print_XAxiDma_Bd( BD_ptr );
#endif

    	if ( eth_device[eth_dev_num].num_recvbuf != free_BD_count ) {
    		xil_printf("*** Error number of receive buffers %d not equal to number of buffer descriptors %d \n", eth_device[eth_dev_num].num_recvbuf, free_BD_count);
    		return -1;
    	}

    	// Setup the Buffer descriptors
    	BD_cur_ptr = BD_ptr;
    	for ( i=0; i<free_BD_count; i++ ){

    		XAxiDma_BdSetBufAddr(BD_cur_ptr, (u32) (eth_device[eth_dev_num].recvbuf + (i * eth_device[eth_dev_num].buf_size)));
    		XAxiDma_BdSetLength(BD_cur_ptr, eth_device[eth_dev_num].buf_size, RX_RING_ptr->MaxTransferLen);
    	    XAxiDma_BdSetCtrl(BD_cur_ptr, 0);
    	    XAxiDma_BdSetId(BD_cur_ptr, (u32) (eth_device[eth_dev_num].recvbuf + (i * eth_device[eth_dev_num].buf_size)));

    		BD_cur_ptr = XAxiDma_BdRingNext(RX_RING_ptr, BD_cur_ptr);
    	}


    	// Enqueue to HW
    	status = XAxiDma_BdRingToHw(RX_RING_ptr, free_BD_count, BD_ptr);
    	if (status != XST_SUCCESS) {
    		xil_printf("*** Error committing RxBD to HW\n");
    		return -1;
    	}

#ifdef _DEBUG_
    	xil_printf("ETH_B_DMA_RX_RING_ptr: \n");
    	print_XAxiDma_BdRing( RX_RING_ptr );
    	print_XAxiDma_Bd( BD_ptr );
#endif

    	// Start DMA RX channel. Now it's ready to receive data.
    	status = XAxiDma_BdRingStart( RX_RING_ptr );
    	if (status != XST_SUCCESS) {
    		xil_printf("*** Error starting RX channel\n");
    		return -1;
    	}

#else
        xilnet_eth_print_err_msg( XILNET_ETH_ERR_INF_NOT_CONFIG, eth_dev_num );
		xil_printf("AXI DMA. \n");
		return -1;
#endif
    	break;


    case XILNET_TEMAC_INF:

#ifdef XILNET_TEMAC_INF_USED
    	// Do nothing, interface is already ready to go

#ifdef _DEBUG_
    	xil_printf("Starting Ethernet Device %d with TEMAC\n", eth_dev_num);
#endif        

#else
        xilnet_eth_print_err_msg( XILNET_ETH_ERR_INF_NOT_CONFIG, eth_dev_num );
		xil_printf("TEMAC. \n");
		return -1;
#endif
    	break;

    default:
        xilnet_eth_print_err_msg( XILNET_ETH_ERR_INF_DNE, eth_dev_num );
		return -1;
    	break;
    }

    return 0;
}



/* 
 * initialize xilnet hardware address
 */
void xilnet_eth_init_hw_addr(int eth_dev_num, unsigned char* addr) {
   int k = 0;
   int j;
   int sum = 0;
   int val = 0;
   
   for (j = 0; j < 5; j++) {
   
      // parse input for colon separated hw address 
      while(addr[k] != ':') {
         if (addr[k] >= 'a' && addr[k] <= 'f') 
            val = addr[k] - 'a' + 10;
         else if (addr[k] >= 'A' && addr[k] <= 'F')
            val = addr[k] - 'A' + 10;
         else
            val = addr[k] - '0';
         sum = sum * 16 + val;
         k++;
      }
    
      k++; // move over the colon
      eth_device[eth_dev_num].node_hw_addr[j] = (unsigned char) sum;
      sum = 0;    
   }
   
   // read last byte of hw address
   while (addr[k] != '\0') {
      if (addr[k] >= 'a' && addr[k] <= 'f') 
         val = addr[k] - 'a' + 10;
      else if (addr[k] >= 'A' && addr[k] <= 'F')
         val = addr[k] - 'A' + 10;
      else
         val = addr[k] - '0';
      sum = sum * 16 + val;
      k++;
   }  
   eth_device[eth_dev_num].node_hw_addr[5] = (unsigned char) sum;
}


#ifdef XILNET_TEMAC_INF_USED
inline void waitForDMA( unsigned int eth_dev_num )
{
	int RegValue;

	// Wait until the DMA transfer is done by checking the Status register
	do {RegValue = XDmaCentral_GetStatus((XDmaCentral *)eth_device[eth_dev_num].inf_dma_ref);}
	while ((RegValue & XDMC_DMASR_BUSY_MASK) == XDMC_DMASR_BUSY_MASK);

	return;
}
#endif


/*
 * Receive frame 
 *
 * Returns either -1 or a pointer to the buffer of the received frame
 *
 */
unsigned int xilnet_eth_recv_frame( unsigned int eth_dev_num ) {

	// TODO: FIX - NEEDS TO RETURN THE POINTER TO THE BUFFER

    int status             = -1;
	int processed_BD_count = 0;
	int free_BD_count      = 0;
    int size               = -1;
    struct xilnet_eth_hdr *eth;
    void                  *pktBufPtr;
    
#ifdef XILNET_AXI_DMA_INF_USED
    int dma_error           = 0;

	XAxiDma_BdRing        *RX_RING_ptr;
	XAxiDma_BdRing        *TX_RING_ptr;
    XAxiDma_Bd            *BD_ptr;
#endif

#ifdef _DEBUG_
    unsigned char         *tmp_ptr;
#endif

	// Check to see if we are receiving on a valid interface
	if ( eth_dev_num >= XILNET_NUM_ETH_DEVICES ) {
        xilnet_eth_print_err_msg( XILNET_ETH_ERR_NUM_DEV, eth_dev_num );
		return -1;
	}

	// Check to see if the xilnet driver uses the Ethernet instance
	if ( !eth_device[eth_dev_num].uses_driver ) {
        xilnet_eth_print_err_msg( XILNET_ETH_ERR_USES_DRIVER, eth_dev_num );
		return -1;
	}
    
	// Device specific routine for getting a frame
    switch( eth_device[eth_dev_num].inf_type ) {

    case XILNET_AXI_FIFO_INF:

#ifdef XILNET_AXI_FIFO_INF_USED

#if 0
        xil_printf("AXI ETHERNET FIFO:  \n");
        xil_printf("FIFO_INST:  0x%x \n", eth_device[eth_dev_num].inf_ref);
        xil_printf("Ethernet FIFO is empty: %d \n", XLlFifo_IsRxEmpty((XLlFifo *)eth_device[eth_dev_num].inf_ref));
        xil_printf("Base Addr             : 0x%x \n", ((XLlFifo *)eth_device[eth_dev_num].inf_ref)->BaseAddress );
        xil_printf("RX Occupancy value    : 0x%x \n", ((*(volatile u32 *)((((XLlFifo *)eth_device[eth_dev_num].inf_ref)->BaseAddress) + (0x0000001c)))) );
#endif

        pktBufPtr = eth_device[eth_dev_num].recvbuf;

        if(XLlFifo_IsRxEmpty((XLlFifo *)eth_device[eth_dev_num].inf_ref)) {

        	size=-1;

        } else {

#ifdef _PERFORMANCE_MONITOR_
   	        wl_setDebugGPIO(0x1);
#endif

   	        if(XLlFifo_RxOccupancy((XLlFifo *)eth_device[eth_dev_num].inf_ref)) {
   	            size = XLlFifo_RxGetLen((XLlFifo *)eth_device[eth_dev_num].inf_ref);
   	            XLlFifo_Read((XLlFifo *)eth_device[eth_dev_num].inf_ref, pktBufPtr, size);
   	        }
        }
#else
        xilnet_eth_print_err_msg( XILNET_ETH_ERR_INF_NOT_CONFIG, eth_dev_num );
		xil_printf("AXI FIFO. \n");
		return -1;
#endif
        break;


    case XILNET_AXI_DMA_INF:

#ifdef XILNET_AXI_DMA_INF_USED

#if 0
        xil_printf("AXI ETHERNET DMA:  \n");
#endif

    	// Get the RX Buffer Descriptor Ring pointer
        RX_RING_ptr = (XAxiDma_BdRing *)eth_device[eth_dev_num].dma_rx_ring_ref;

        // Check to see that the HW is started (if it is not started, we must have gotten an error somewhere
        if ( !XAxiDma_BdRingHwIsStarted( RX_RING_ptr ) ) {

    	    // Get the TX Buffer Descriptor Ring pointer
            TX_RING_ptr = (XAxiDma_BdRing *)eth_device[eth_dev_num].dma_tx_ring_ref;
        
            // Check to see if we have a RX error
            if ( XAxiDma_BdRingGetError( RX_RING_ptr ) ) {
#ifdef _DEBUG_
                print_XAxiDma_BdRing( RX_RING_ptr );
#endif
                xil_printf("*** ERROR in RX DMA transfer: 0x%8x \n", XAxiDma_BdRingGetError( RX_RING_ptr ));
                dma_error = 1;
            }
        
            // Check to see if we have a TX error
            if ( XAxiDma_BdRingGetError( TX_RING_ptr ) ) {
#ifdef _DEBUG_
                print_XAxiDma_BdRing( TX_RING_ptr );
#endif
                xil_printf("*** ERROR in TX DMA transfer: 0x%8x \n", XAxiDma_BdRingGetError( TX_RING_ptr ));
                dma_error = 1;
            }
            
            // If there is an error, reset the DMA
            if ( dma_error ) {
                xil_printf("*** Resetting DMA \n");
                XAxiDma_Reset( (XAxiDma *)eth_device[eth_dev_num].inf_ref );
            }

            // If not, then start DMA RX channel
            status = XAxiDma_BdRingStart( RX_RING_ptr );
            if (status != XST_SUCCESS) {
                xil_printf("*** Error starting RX channel\n");
                return -1;
            }
        }
        
        // See if we have any data to process
        // NOTE:  We will only process one buffer descriptor at a time in this function call
        processed_BD_count = XAxiDma_BdRingFromHw(RX_RING_ptr, 0x1, &BD_ptr);

  	    // If we have data, then we need process the buffer
        if ( processed_BD_count > 0 ) {

#ifdef _PERFORMANCE_MONITOR_
            wl_setDebugGPIO(0x1);
#endif

  		    status = XAxiDma_BdGetSts(BD_ptr);

  		    if ((status & XAXIDMA_BD_STS_ALL_ERR_MASK) || (!(status & XAXIDMA_BD_STS_COMPLETE_MASK))) {
  	   		    xil_printf("*** Rx Error: 0x%8x\n", status);
  	   		    return -1;
  		    } else {
  			    size = (XAxiDma_BdRead(BD_ptr, XAXIDMA_BD_USR4_OFFSET)) & 0x0000FFFF;
  		    }

  	        pktBufPtr = (void *)XAxiDma_BdGetId(BD_ptr);       // BD ID was set to the base address of the buffer
  	    }
#else
        xilnet_eth_print_err_msg( XILNET_ETH_ERR_INF_NOT_CONFIG, eth_dev_num );
		xil_printf("AXI DMA. \n");
		return -1;
#endif
        break;


    case XILNET_TEMAC_INF:

#ifdef XILNET_TEMAC_INF_USED

#if 0
        xil_printf("TEMAC FIFO:  \n");
        xil_printf("FIFO_INST:  0x%x \n", eth_device[eth_dev_num].inf_ref);
        xil_printf("Ethernet FIFO is empty: %d \n", XLlFifo_IsRxEmpty((XLlFifo *)eth_device[eth_dev_num].inf_ref));
        xil_printf("Base Addr             : 0x%x \n", ((XLlFifo *)eth_device[eth_dev_num].inf_ref)->BaseAddress );
        xil_printf("RX Occupancy value    : 0x%x \n", ((*(volatile u32 *)((((XLlFifo *)eth_device[eth_dev_num].inf_ref)->BaseAddress) + (0x0000001c)))) );
#endif

        pktBufPtr = eth_device[eth_dev_num].recvbuf;

        if( XLlFifo_IsRxEmpty( (XLlFifo *)eth_device[eth_dev_num].inf_ref ) ) {
   	        size=-1;
   	    } else {

#ifdef _PERFORMANCE_MONITOR_
   	        wl_setDebugGPIO(0x1);
#endif

   	        if( XLlFifo_RxOccupancy( (XLlFifo *)eth_device[eth_dev_num].inf_ref ) ) {

   	            waitForDMA(eth_dev_num);

                // Set DMA to non-increment source, increment dest addresses
                XDmaCentral_SetControl( (XDmaCentral *)eth_device[eth_dev_num].inf_dma_ref, XDMC_DMACR_DEST_INCR_MASK );
                size = XLlFifo_RxGetLen( (XLlFifo *)eth_device[eth_dev_num].inf_ref );
                XDmaCentral_Transfer((XDmaCentral *)eth_device[eth_dev_num].inf_dma_ref,
                                     (u8 *)(((XLlFifo *)eth_device[eth_dev_num].inf_ref)->BaseAddress+XLLF_RDFD_OFFSET),
                                     (u8 *)pktBufPtr, size);
            }
        }
#else
        xilnet_eth_print_err_msg( XILNET_ETH_ERR_INF_NOT_CONFIG, eth_dev_num );
		xil_printf("TEMAC. \n");
        return -1;
#endif
        break;

    default:
        xilnet_eth_print_err_msg( XILNET_ETH_ERR_INF_DNE, eth_dev_num );
		return -1;
    	break;
    }

#if 0
	xil_printf("Ethernet Recvd Frame of size %d...\n", size);
	tmp_ptr = (unsigned char *)pktBufPtr;
	xil_printf("src : %d%d%d%d%d%d...\n", tmp_ptr[0], tmp_ptr[1], tmp_ptr[2], tmp_ptr[3], tmp_ptr[4], tmp_ptr[5]);
	xil_printf("dst : %d%d%d%d%d%d...\n", tmp_ptr[6], tmp_ptr[7], tmp_ptr[8], tmp_ptr[9], tmp_ptr[10], tmp_ptr[11]);
	xil_printf("type : %d%d...\n", tmp_ptr[12], tmp_ptr[13]);
#endif
  
    // Strip off the FCS (or CRC) from the received frame
    size -= 4;
  
    // Process the packet
    if ( size > 0 ) {

#ifdef _DEBUG_
    	xil_printf("BEGIN xilnet_eth_recv_frame() \n" );
    	xil_printf("  Received %d bytes\n", size);
    	tmp_ptr = (unsigned char *)pktBufPtr;
    	xil_printf("  src  : %2x %2x %2x %2x %2x %2x \n", tmp_ptr[0], tmp_ptr[1], tmp_ptr[2], tmp_ptr[3], tmp_ptr[4], tmp_ptr[5]);
    	xil_printf("  dst  : %2x %2x %2x %2x %2x %2x \n", tmp_ptr[6], tmp_ptr[7], tmp_ptr[8], tmp_ptr[9], tmp_ptr[10], tmp_ptr[11]);
    	xil_printf("  type : %2x %2x \n\n", tmp_ptr[12], tmp_ptr[13]);
        print_pkt((unsigned char *)pktBufPtr, size);
#endif

        eth = (struct xilnet_eth_hdr*) pktBufPtr;
    
        switch (Xil_Ntohs(eth->type)) {
            case ETH_PROTO_IP:
            	status = (xilnet_ip(pktBufPtr, size, eth_dev_num));
            	break;
            case ETH_PROTO_ARP:
            	status = (xilnet_arp(pktBufPtr, size, eth_dev_num));
            	break;
            default:
#ifdef _DEBUG_
                xil_printf("Unknown protocol %x...\r\n", eth->type);
#endif
            break;
        }


#ifdef XILNET_AXI_DMA_INF_USED
        // Post process the DMA buffer descriptors now that we are done with them
        if (eth_device[eth_dev_num].inf_type == XILNET_AXI_DMA_INF) {

            // Free all processed RX BDs for future transmission
		    status = XAxiDma_BdRingFree(RX_RING_ptr, processed_BD_count, BD_ptr);
		    if (status != XST_SUCCESS) {
	   		    xil_printf("*** Error freeing up %d RxBDs:  0x%8x\n", processed_BD_count, status);
		    }

		    // Return processed BDs to RX channel so we are ready to receive new packets:
		    //    - Allocate all free RX BDs
		    //    - Pass the BDs to RX channel
		    free_BD_count = XAxiDma_BdRingGetFreeCnt(RX_RING_ptr);

		    status = XAxiDma_BdRingAlloc(RX_RING_ptr, free_BD_count, &BD_ptr);
		    if (status != XST_SUCCESS) {
	   		    xil_printf("*** Error allocating %d RxBDs:  0x%8x\n", free_BD_count, status);
		    }

		    status = XAxiDma_BdRingToHw(RX_RING_ptr, free_BD_count, BD_ptr);
		    if (status != XST_SUCCESS) {
			    xil_printf("*** Error submiting %d rx BDs failed: 0x%8x\r\n", free_BD_count, status);
		    }
        }
#endif

#ifdef _DEBUG_
    	xil_printf("END xilnet_eth_recv_frame() \n" );
#endif

#ifdef _PERFORMANCE_MONITOR_
  		wl_clearDebugGPIO(0x1);
#endif
    }

    return status;
}


/*
 * Send frame to peer ip addr, peer hw addr
 */
int xilnet_eth_send_frame(unsigned char *pkt, int len, unsigned char *dip_addr,
                          void *dhw_addr, unsigned short type, unsigned int eth_dev_num)
{
    int i;
    int hw_tbl_index = 0;

   	int status;
   	int size                = 0;
	int transmit_flag       = 0;
	unsigned char  *hw_addr = (unsigned char *)dhw_addr;

#ifdef XILNET_AXI_DMA_INF_USED
	int processed_BD_count  = 0;
    int dma_status          = 0;
    int dma_error           = 0;
    int dma_hang_count      = 1000;

	XAxiDma_BdRing *RX_RING_ptr;
	XAxiDma_BdRing *TX_RING_ptr;
	XAxiDma_Bd     *BD_ptr;
#endif

	// Check to see if we are sending on a valid interface
	if ( eth_dev_num >= XILNET_NUM_ETH_DEVICES ) {
        xilnet_eth_print_err_msg( XILNET_ETH_ERR_NUM_DEV, eth_dev_num );
		return -1;
	}
    
	// Check to see if the xilnet driver uses the Ethernet instance
	if ( !eth_device[eth_dev_num].uses_driver ) {
        xilnet_eth_print_err_msg( XILNET_ETH_ERR_USES_DRIVER, eth_dev_num );
		return -1;
	}
    
#ifdef _DEBUG_
    xil_printf("BEGIN xilnet_eth_send_frame(): \n");
    xil_printf("  pkt      = %x \n", pkt);
    xil_printf("  len      = %d \n", len);
    xil_printf("  dip_addr = %d.%d.%d.%d \n", dip_addr[0], dip_addr[1], dip_addr[2], dip_addr[3]);
    xil_printf("  dhw_addr = %02x-%02x-%02x-%02x-%02x-%02x \n", hw_addr[0], hw_addr[1], hw_addr[2], hw_addr[3], hw_addr[4], hw_addr[5]);
    xil_printf("  type     = %x \n", type);
    xil_printf("  eth_dev  = %c \n", wn_conv_eth_dev_num(eth_dev_num) );
#endif

#ifdef _PERFORMANCE_MONITOR_
   	wl_setDebugGPIO(0x2);
#endif

    // Set the source MAC address
    for (i = 0; i < ETH_ADDR_LEN; i++) {
        ((struct xilnet_eth_hdr*)pkt)->src_addr[i] = eth_device[eth_dev_num].node_hw_addr[i];
    }

    // Set the destination MAC address
    if (dhw_addr)
        memcpy(((struct xilnet_eth_hdr*)pkt)->dest_addr, dhw_addr, ETH_ADDR_LEN);
    else {
        // find the hw tbl entry index corr to dip_addr
        hw_tbl_index = xilnet_eth_get_hw_addr(dip_addr, eth_dev_num);
      
        for (i = 0; i < ETH_ADDR_LEN; i++) {
            ((struct xilnet_eth_hdr*)pkt)->dest_addr[i] = xilnet_hw_tbl[hw_tbl_index].hw_addr[i];
        }
    }

    // Convert Endianess of type
    ((struct xilnet_eth_hdr*)pkt)->type = Xil_Htons(type);
   
    // pad the ethernet frame if < 60 bytes
    if (len < 60) {
        for(i = len; i < ETH_MIN_FRAME_LEN; i++) {
            pkt[i] = 0;
        }
        len = ETH_MIN_FRAME_LEN;
    }

    // Device specific routine for sending a frame
    switch( eth_device[eth_dev_num].inf_type ) {

    case XILNET_AXI_FIFO_INF:

#ifdef XILNET_AXI_FIFO_INF_USED
    	XLlFifo_Write((XLlFifo *) eth_device[eth_dev_num].inf_ref, pkt, len);

        // Write the length to the LL_FIFO; this write initiates the TEMAC transmission
        XLlFifo_TxSetLen((XLlFifo *) eth_device[eth_dev_num].inf_ref, len);
#else
        xilnet_eth_print_err_msg( XILNET_ETH_ERR_INF_NOT_CONFIG, eth_dev_num );
		xil_printf("AXI FIFO. \n");
    	return -1;
#endif
    	break;


    case XILNET_AXI_DMA_INF:

#ifdef XILNET_AXI_DMA_INF_USED

    	// Get the TX Buffer Descriptor Ring pointer
        TX_RING_ptr = (XAxiDma_BdRing *)eth_device[eth_dev_num].dma_tx_ring_ref;
        
    	// Get the RX Buffer Descriptor Ring pointer
        RX_RING_ptr = (XAxiDma_BdRing *)eth_device[eth_dev_num].dma_rx_ring_ref;
        
        // Check to see if we have a RX error
        if ( XAxiDma_BdRingGetError( RX_RING_ptr ) ) {
#ifdef _DEBUG_
            print_XAxiDma_BdRing( RX_RING_ptr );
#endif
            xil_printf("*** ERROR in RX DMA transfer: 0x%8x \n", XAxiDma_BdRingGetError( RX_RING_ptr ));
            dma_error = 1;
        }
    
        // Check to see if we have a TX error
        if ( XAxiDma_BdRingGetError( TX_RING_ptr ) ) {
#ifdef _DEBUG_
            print_XAxiDma_BdRing( TX_RING_ptr );
#endif
            xil_printf("*** ERROR in TX DMA transfer: 0x%8x \n", XAxiDma_BdRingGetError( TX_RING_ptr ));
            dma_error = 1;
        }
        
        // If there is an error, reset the DMA
        if ( dma_error ) {
            xil_printf("*** Resetting DMA \n");
            XAxiDma_Reset( (XAxiDma *)eth_device[eth_dev_num].inf_ref );
        }

        // Allocate, setup and enqueue a TX BD for the Frame
       	status = XAxiDma_BdRingAlloc(TX_RING_ptr, 1, &BD_ptr);
    	if (status != XST_SUCCESS) {
    	   	xil_printf("*** Error allocating TX BDs:  0x%8x\n", status);
    	}

    	// Set the BD address to the start of the packet
    	status = XAxiDma_BdSetBufAddr(BD_ptr, (u32) pkt);
    	if (status != XST_SUCCESS) {
    	   	xil_printf("*** Error setting TX Address:  status = 0x%8x;  BD = 0x%x;  addr = 0x%x\n", status, BD_ptr, (u32) pkt);
    	}

    	// Set the BD length to the length field
    	status = XAxiDma_BdSetLength(BD_ptr, len, TX_RING_ptr->MaxTransferLen);
    	if (status != XST_SUCCESS) {
    	   	xil_printf("*** Error setting TX Length:  status = 0x%8x;  BD = 0x%x;  len = %d;  max_len = %d\n", status, BD_ptr, len, TX_RING_ptr->MaxTransferLen);
    	}

        // Since this is a single descriptor, set both SOF and EOF
    	XAxiDma_BdSetCtrl(BD_ptr, XAXIDMA_BD_CTRL_TXSOF_MASK | XAXIDMA_BD_CTRL_TXEOF_MASK);

        // Set the Application specific words
        XAxiDma_BdSetAppWord( BD_ptr, 0, 0x00000000 );
        XAxiDma_BdSetAppWord( BD_ptr, 1, 0x00000000 );
        XAxiDma_BdSetAppWord( BD_ptr, 2, 0x00000000 );
        XAxiDma_BdSetAppWord( BD_ptr, 3, 0x00000000 );
        XAxiDma_BdSetAppWord( BD_ptr, 4, 0x00000000 );        

#ifdef _DEBUG_
        print_XAxiDma_BdRing( TX_RING_ptr );
    	print_XAxiDma_Bd( BD_ptr );
#endif

    	// Enqueue to the HW
    	status = XAxiDma_BdRingToHw(TX_RING_ptr, 1, BD_ptr);
    	if (status != XST_SUCCESS) {
    		 // Undo BD allocation and exit
    		XAxiDma_BdRingUnAlloc(TX_RING_ptr, 1, BD_ptr);
    	   	xil_printf("*** Error committing TX BD to HW:  0x%8x\n", status);
    	}

    	// Start DMA TX channel. Transmission starts at once.  
        //   If the channel is already started, then the XAxiDma_BdRingToHw() call will start the transmission
        if (TX_RING_ptr->RunState == AXIDMA_CHANNEL_HALTED) {
            status = XAxiDma_BdRingStart(TX_RING_ptr);
            if (status != XST_SUCCESS) {
                xil_printf("*** Error starting TX BD:  0x%8x\n", status);
            }
        }

    	// Poll to find when we are done transmitting the packet
    	// TODO:  We can change this to non-blocking by moving these checks above the allocate calls
    	transmit_flag = 0;

      	while ( transmit_flag == 0 ) {
        
            processed_BD_count = XAxiDma_BdRingFromHw(TX_RING_ptr, 1, &BD_ptr);

    	  	if ( processed_BD_count > 0 ) {

#ifdef _DEBUG_
                print_XAxiDma_BdRing( TX_RING_ptr );
    	  		print_XAxiDma_Bd( BD_ptr );
#endif
    	  		status = XAxiDma_BdGetSts(BD_ptr);

    	  		if ((status & XAXIDMA_BD_STS_ALL_ERR_MASK) || (!(status & XAXIDMA_BD_STS_COMPLETE_MASK))) {
    		   	    xil_printf("*** TX Error: 0x%x\n", status);
    			} else {
    			    size = (XAxiDma_BdRead(BD_ptr, XAXIDMA_BD_STS_OFFSET)) & 0x0000FFFF;
    			}

    			if ( size != len ) {
    		   	    xil_printf("*** Size of transmission (0x%x) does not match length of packet (0x%x)\n", size, len);
    			}

                // Clear out all the control / status information before freeing the buffer descriptor
                XAxiDma_BdClear(BD_ptr);

    		    // Free all processed RX BDs for future transmission
    		    status = XAxiDma_BdRingFree(TX_RING_ptr, processed_BD_count, BD_ptr);
    		    if (status != XST_SUCCESS) {
    	   		    xil_printf("*** Error freeing up %d RxBDs:  0x%8x\n", processed_BD_count, status);
    		    }

#ifdef _DEBUG_
                print_XAxiDma_BdRing( TX_RING_ptr );
    	  		print_XAxiDma_Bd( BD_ptr );
#endif

    		    transmit_flag = 1;
    	  	}
            else {

                if ( XAxiDma_BdRingBusy( TX_RING_ptr ) ) {
                
                    // HW is still busy with the transfer                    
                    if ( dma_hang_count == 0 ) {
                        xil_printf("  **** ERROR:  Trying to send on Ethernet device %c.  Driver timed out while device was busy.  Unknown ERROR. \n", wn_conv_eth_dev_num(eth_dev_num) );
                        return -1;
                    } else {
                        dma_hang_count--;
                    }
                } else {

                    // Check to see if we have an error
                    dma_status = XAxiDma_BdRingGetError( TX_RING_ptr );
                    
                    if ( dma_status != 0 ) {
    	   		        xil_printf("*** ERROR in DMA transfer: 0x%8x \n", dma_status);
#ifdef _DEBUG_
                        print_XAxiDma_BdRing( TX_RING_ptr );
                        print_XAxiDma_Bd( TX_RING_ptr->HwHead );
#endif
                        // Restart DMA TX channel. 
                        xil_printf("*** Restarting transfer \n");
                        XAxiDma_Reset( (XAxiDma *)eth_device[eth_dev_num].inf_ref );
                        
                        status = XAxiDma_BdRingStart(TX_RING_ptr);
                        if (status != XST_SUCCESS) {
                            xil_printf("*** Error starting TX BD:  0x%8x\n", status);
                        }
                    } else {
                        // In the case of large packets, we can encounter a situation where we finish the processing of the 
                        // packet between the XAxiDma_BdRingFromHw() function call and the XAxiDma_BdRingBusy() function call.
                        // In this case, we now have a situation where the DMA is not busy and does not have an error, but we 
                        // just need to run through the loop one more time in order to finish the transaction.  However,
                        // to make sure we don't get stuck in this case (ie there is a packet to process, we are going to 
                        // enforce a timeout.
                        
                        if ( dma_hang_count == 0 ) {
                            xil_printf("  **** ERROR:  Trying to send on Ethernet device %c.  Driver timed out while device was idle.  Unknown ERROR. \n", wn_conv_eth_dev_num(eth_dev_num) );
                            return -1;
                        } else {
                            dma_hang_count--;
                        }
                    }
                }
            }
        }

#else
        xilnet_eth_print_err_msg( XILNET_ETH_ERR_INF_NOT_CONFIG, eth_dev_num );
		xil_printf("AXI DMA. \n");
    	return -1;
#endif
    	break;

    case XILNET_TEMAC_INF:

#ifdef XILNET_TEMAC_INF_USED
        waitForDMA(eth_dev_num);

        // Set DMA to increment src, non-increment dest addresses
        XDmaCentral_SetControl((XDmaCentral *)eth_device[eth_dev_num].inf_dma_ref, XDMC_DMACR_SOURCE_INCR_MASK);

        // Transfer the packet into the LLFIFO
        XDmaCentral_Transfer((XDmaCentral *)eth_device[eth_dev_num].inf_dma_ref, (u8 *)(pkt),
                             (u8 *)(((XLlFifo *)eth_device[eth_dev_num].inf_ref)->BaseAddress + XLLF_TDFD_OFFSET), len);

        waitForDMA(eth_dev_num);

        // Write the length to the LL_FIFO; this write initiates the TEMAC transmission
        XLlFifo_TxSetLen((XLlFifo *)eth_device[eth_dev_num].inf_ref, len);

#else
        xilnet_eth_print_err_msg( XILNET_ETH_ERR_INF_NOT_CONFIG, eth_dev_num );
		xil_printf("TEMAC. \n");
    	return -1;
#endif
        break;

    default:
        xilnet_eth_print_err_msg( XILNET_ETH_ERR_INF_DNE, eth_dev_num );
		return -1;
    	break;
    }

#ifdef _PERFORMANCE_MONITOR_
  	wl_clearDebugGPIO(0x2);
#endif
    
#ifdef _DEBUG_
   	xil_printf("  Sent %d bytes\n",len);
    xil_printf("END xilnet_eth_send_frame() \n\n");
#endif

   return len;
}


/*
 * Update Hardware Address Table
 */

void xilnet_eth_update_hw_tbl(unsigned char *buf, int proto, unsigned int eth_dev_num) {
   
   unsigned char ip[IP_VERSION];
   unsigned char hw[ETH_ADDR_LEN];
   int i, j;

   // Update the current age
   curr_age++;
   
   // get hw addr
   for (i = 0; i < ETH_ADDR_LEN; i++) {
      hw[i] = ((struct xilnet_eth_hdr*)buf)->src_addr[i];
   }	 

   // get ip addr
   switch (proto) {
   case ETH_PROTO_ARP:
      for (i = 0; i < IP_VERSION; i++) {
         ip[i] = (buf+ETH_HDR_LEN)[ARP_SIP_OFFSET+i];
      }
      break;
   case ETH_PROTO_IP:
      for (i = 0; i < IP_VERSION; i++) {
         ip[i] = (buf+ETH_HDR_LEN)[IP_SADDR_BASE+i];
      }
      break;
   }

   // update the hw addr table
   for (i = 0; i < HW_ADDR_TBL_ENTRIES; i++) {
      if (xilnet_hw_tbl[i].flag) {
         if ( (hw[0] == xilnet_hw_tbl[i].hw_addr[0]) &&
              (hw[1] == xilnet_hw_tbl[i].hw_addr[1]) &&
              (hw[2] == xilnet_hw_tbl[i].hw_addr[2]) &&
              (hw[3] == xilnet_hw_tbl[i].hw_addr[3]) &&
              (hw[4] == xilnet_hw_tbl[i].hw_addr[4]) &&
              (hw[5] == xilnet_hw_tbl[i].hw_addr[5])
              ) {
            for (j = 0; j < IP_VERSION; j++)
               xilnet_hw_tbl[i].ip_addr[j] = ip[j];;
            xilnet_hw_tbl[i].flag = HW_ADDR_ENTRY_IS_TRUE;
            xilnet_hw_tbl[i].age = curr_age;
            return;
         }
      }
   }
   xilnet_eth_add_hw_tbl_entry(ip, hw, eth_dev_num);
}


/*
 * Add an entry into Hw Addr table
 */

void xilnet_eth_add_hw_tbl_entry(unsigned char *ip, unsigned char *hw, unsigned int eth_dev_num)
{
   int i, j;
   
   for (i = 0; i < HW_ADDR_TBL_ENTRIES; i++) {
      if (!xilnet_hw_tbl[i].flag) {
         for (j = 0; j < ETH_ADDR_LEN; j++) {
            xilnet_hw_tbl[i].hw_addr[j] = hw[j];
         }
         for (j = 0; j < IP_VERSION; j++)  {
            xilnet_hw_tbl[i].ip_addr[j] = ip[j];
         }
         xilnet_hw_tbl[i].flag = HW_ADDR_ENTRY_IS_TRUE;
         xilnet_hw_tbl[i].age = curr_age;

#if _DEBUG_XILNET_HW_TABLE_
         xil_printf("xilnet_add_hw_tbl_entry: \n");
         print_hw_tbl();
#endif
         
         return;
      }
   }
   
   // Find an old entry to be eliminated from hw tbl
   i = xilnet_eth_find_old_entry(eth_dev_num);
   for (j = 0; j < ETH_ADDR_LEN; j++) {
      xilnet_hw_tbl[i].hw_addr[j] = hw[j];
   }
   for (j = 0; j < IP_VERSION; j++)  {
      xilnet_hw_tbl[i].ip_addr[j] = ip[j];
   }
   xilnet_hw_tbl[i].flag = HW_ADDR_ENTRY_IS_TRUE;
   xilnet_hw_tbl[i].age = curr_age;

#if _DEBUG_XILNET_HW_TABLE_
   xil_printf("xilnet_add_hw_tbl_entry: \n");
   print_hw_tbl();
#endif

}


/*
 * Get index into hw tbl for ip_addr
 */

int xilnet_eth_get_hw_addr(unsigned char *ip, unsigned int eth_dev_num) {
   
   int i;
   
   for (i = 0; i < HW_ADDR_TBL_ENTRIES; i++) {
      if (xilnet_hw_tbl[i].flag) 
         if ( (ip[0] == xilnet_hw_tbl[i].ip_addr[0]) &&
              (ip[1] == xilnet_hw_tbl[i].ip_addr[1]) &&
              (ip[2] == xilnet_hw_tbl[i].ip_addr[2]) &&
              (ip[3] == xilnet_hw_tbl[i].ip_addr[3]) ) {
            return i;
         }
   }

#if _DEBUG_XILNET_HW_TABLE_
   xil_printf("xilnet_eth_get_hw_addr: \n");
   print_hw_tbl();
#endif
   
   xil_printf("Hw Addr Not found for IP \r\n");
   return -1;
}


/*	
 * Init the hw addr table
 */

void xilnet_eth_init_hw_addr_tbl(unsigned int eth_dev_num) {
   
  int i;
  
  for (i = 0; i < HW_ADDR_TBL_ENTRIES; i++) {
     xilnet_hw_tbl[i].flag = HW_ADDR_ENTRY_IS_FALSE;
     xilnet_hw_tbl[i].age = 0;
  }
  
  ishwaddrinit = 1;

#if _DEBUG_XILNET_HW_TABLE_
  xil_printf("xilnet_eth_init_hw_addr_tbl: \n");
  print_hw_tbl();
#endif

}


/*
 * Find the oldest entry in the Hw Table and
 * return its index
 */

int xilnet_eth_find_old_entry(unsigned int eth_dev_num)
{
   int i;
   int oldest_age = 0;
   int oldest = 0;
   
   for (i = 0; i < HW_ADDR_TBL_ENTRIES; i++) {
      
      if (curr_age - xilnet_hw_tbl[i].age > HW_ADDR_TBL_MAXAGE) {
         oldest = i;
         break;
      }
      else {
         if (( curr_age - xilnet_hw_tbl[i].age) > oldest_age) {
            oldest_age = curr_age - xilnet_hw_tbl[i].age;
            oldest = i;
         }
      }
   }
   
   return oldest;
}


// Debug printing functions for various structures

#if _DEBUG_XILNET_HW_TABLE_
void print_hw_tbl()
{
	int i, j;

	xil_printf("Ethernet HW Table \n");

	for (i=0; i<HW_ADDR_TBL_ENTRIES; i++) {
		xil_printf("  IP : ");
		for (j=0; j<IP_VERSION; j++) {
            xil_printf("%d.", xilnet_hw_tbl[i].ip_addr[j]);
		}

		xil_printf("    HW : ");
		for (j=0; j<ETH_ADDR_LEN; j++) {
            xil_printf("%x ", xilnet_hw_tbl[i].hw_addr[j]);
		}

		xil_printf("    \n");
	}
	xil_printf("\n");
}
#endif

#ifdef _DEBUG_

void print_pkt(unsigned char *buf, int size)
{
	int i;

	xil_printf("Ethernet Packet: (0x%x bytes)\n", size);

	for (i=0; i<size; i++) {
        xil_printf("%2x ", buf[i]);
        if ( (((i + 1) % 16) == 0) && ((i + 1) != size) ) {
            xil_printf("\n");
        }
	}
	xil_printf("\n\n");
}


#ifdef 	XILNET_AXI_DMA_INF_USED
void print_XAxiDma_Bd( XAxiDma_Bd *BD_ptr ) {

	int i;

	xil_printf("Buffer Descriptor: 0x%x\n", BD_ptr);
	for ( i = 0; i < XAXIDMA_BD_NUM_WORDS; i++ ) {
        xil_printf("  Value[%2d]:        0x%x \n", i, (*BD_ptr)[i]);
	}
	xil_printf("\n");
}


void print_XAxiDma_BdRing( XAxiDma_BdRing *BD_RING_ptr ) {

	xil_printf("Buffer Descriptor Ring Pointer: \n");
	xil_printf("  ChanBase:         0x%x \n", BD_RING_ptr->ChanBase);
	xil_printf("  IsRxChannel:      0x%x \n", BD_RING_ptr->IsRxChannel);
	xil_printf("  RunState:         0x%x \n", BD_RING_ptr->RunState);
    xil_printf("  HasStsCntrlStrm:  0x%x \n", BD_RING_ptr->HasStsCntrlStrm);
    xil_printf("  HasDRE:           0x%x \n", BD_RING_ptr->HasDRE);
    xil_printf("  DataWidth:        0x%x \n", BD_RING_ptr->DataWidth);
    xil_printf("  MaxTransferLen:   0x%x \n", BD_RING_ptr->MaxTransferLen);
    xil_printf("  FirstBdPhysAddr:  0x%x \n", BD_RING_ptr->FirstBdPhysAddr);
    xil_printf("  FirstBdAddr:      0x%x \n", BD_RING_ptr->FirstBdAddr);
    xil_printf("  LastBdAddr:       0x%x \n", BD_RING_ptr->LastBdAddr);
    xil_printf("  Length:           0x%x \n", BD_RING_ptr->Length);
    xil_printf("  Separation:       0x%x \n", BD_RING_ptr->Separation);
    xil_printf("  FreeHead:         0x%x \n", BD_RING_ptr->FreeHead);
    xil_printf("  PreHead:          0x%x \n", BD_RING_ptr->PreHead);
    xil_printf("  HwHead:           0x%x \n", BD_RING_ptr->HwHead);
    xil_printf("  HwTail:           0x%x \n", BD_RING_ptr->HwTail);
    xil_printf("  PostHead:         0x%x \n", BD_RING_ptr->PostHead);
    xil_printf("  BdaRestart:       0x%x \n", BD_RING_ptr->BdaRestart);
    xil_printf("  FreeCnt:          0x%x \n", BD_RING_ptr->FreeCnt);
    xil_printf("  PreCnt:           0x%x \n", BD_RING_ptr->PreCnt);
    xil_printf("  HwCnt:            0x%x \n", BD_RING_ptr->HwCnt);
    xil_printf("  PostCnt:          0x%x \n", BD_RING_ptr->PostCnt);
    xil_printf("  AllCnt:           0x%x \n", BD_RING_ptr->AllCnt);
    xil_printf("  RingIndex:        0x%x \n", BD_RING_ptr->RingIndex);
	xil_printf("\n");
}


void print_XAxiDma_Config( XAxiDma_Config * DMA_CFG_ptr ) {

	xil_printf("DMA Config Pointer: \n");
    xil_printf("  DeviceId:         0x%x \n", DMA_CFG_ptr->DeviceId);
    xil_printf("  BaseAddr:         0x%x \n", DMA_CFG_ptr->BaseAddr);
    xil_printf("  HasStsCntrlStrm:  0x%x \n", DMA_CFG_ptr->HasStsCntrlStrm);
    xil_printf("  HasMm2S:          0x%x \n", DMA_CFG_ptr->HasMm2S);
    xil_printf("  HasMm2SDRE:       0x%x \n", DMA_CFG_ptr->HasMm2SDRE);
    xil_printf("  Mm2SDataWidth:    0x%x \n", DMA_CFG_ptr->Mm2SDataWidth);
    xil_printf("  HasS2Mm:          0x%x \n", DMA_CFG_ptr->HasS2Mm);
    xil_printf("  HasS2MmDRE:       0x%x \n", DMA_CFG_ptr->HasS2MmDRE);
    xil_printf("  S2MmDataWidth:    0x%x \n", DMA_CFG_ptr->S2MmDataWidth);
    xil_printf("  HasSg:            0x%x \n", DMA_CFG_ptr->HasSg);
    xil_printf("  Mm2sNumChannels:  0x%x \n", DMA_CFG_ptr->Mm2sNumChannels);
    xil_printf("  S2MmNumChannels:  0x%x \n", DMA_CFG_ptr->S2MmNumChannels);
	xil_printf("\n");
}
#endif

#ifdef XILNET_AXI_FIFO_INF_USED
void print_XLlFifo( XLlFifo * FIFO_ptr ) {

	xil_printf("FIFO Pointer: \n");
    xil_printf("  BaseAddress:       0x%x \n", FIFO_ptr->BaseAddress);
    xil_printf("  IsReady:           0x%x \n", FIFO_ptr->IsReady);
    xil_printf("  RX instance:       0x%x \n", FIFO_ptr->RxStreamer.FifoInstance);
    xil_printf("  RX width:          0x%x \n", FIFO_ptr->RxStreamer.FifoWidth);
    xil_printf("  RX HeadIndex:      0x%x \n", FIFO_ptr->RxStreamer.HeadIndex);
    xil_printf("  RX FrmByteCnt:     0x%x \n", FIFO_ptr->RxStreamer.FrmByteCnt);
    xil_printf("  TX instance:       0x%x \n", FIFO_ptr->TxStreamer.FifoInstance);
    xil_printf("  TX width:          0x%x \n", FIFO_ptr->TxStreamer.FifoWidth);
    xil_printf("  TX HeadIndex:      0x%x \n", FIFO_ptr->TxStreamer.TailIndex);
	xil_printf("\n");
}
#endif

#endif



