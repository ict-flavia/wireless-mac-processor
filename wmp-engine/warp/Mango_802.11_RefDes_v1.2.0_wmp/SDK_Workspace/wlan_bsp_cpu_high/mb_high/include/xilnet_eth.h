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
// File   : eth.h
// Date   : 2002, March 20.
// Author : Sathya Thammanur
// Company: Xilinx
// Group  : Emerging Software Technologies
//
// Summary:
// Header file for Ethernet layer
//
// $Id: eth.h,v 1.2.8.6 2005/11/15 23:41:10 salindac Exp $
//
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// see copyright.txt for Rice University/Mango Communications modifications
////////////////////////////////////////////////////////////////////////////////


#ifndef _ETH_H
#define _ETH_H

#ifdef __cplusplus
extern "C" {
#endif

#include <xilnet_ip.h>

#define ETH_ADDR_LEN	       6   /* len of eth addr */	
#define ETH_HDR_LEN	          14   /* eth hdr len */
#define ETH_MIN_FRAME_LEN	  60   /* Min Eth Frame Payload */	

//#define ETH_MAX_FRAME_LEN	  1500 /* Max Eth Frame Payload */	
//#define ETH_FRAME_LEN	      1514 /* Max Eth Frame Size */	

#define ETH_MAX_FRAME_LEN	  9000 /* Max Eth Frame Payload */	// TODO:  MAY NEED TO FIX
#define ETH_FRAME_LEN	      9014 /* Max Eth Frame Size */	    // TODO:  MAY NEED TO FIX

/*
 * Protocol vals in eth hdr 
 */
#define ETH_PROTO_IP	0x0800		/* IP  packet	*/
#define ETH_PROTO_ARP	0x0806		/* ARP packet	*/


/*
 * Convert Ethernet device number to WARPNet convention (ie ETH A or ETH B)
 */
#define wn_conv_eth_dev_num(x)      (char)(((int)'A') + x)


/*
 * Ethernet Header
 */
 struct xilnet_eth_hdr {
  unsigned char	dest_addr[ETH_ADDR_LEN];  /* destination eth addr	*/
  unsigned char	src_addr[ETH_ADDR_LEN];	  /* source eth addr	*/
  unsigned short type;		          /* protocol type */
};


/*
 * HW Address Table
 */
#define HW_ADDR_TBL_ENTRIES     5 * XILNET_NUM_ETH_DEVICES
#define HW_ADDR_ENTRY_IS_TRUE   1
#define HW_ADDR_ENTRY_IS_FALSE  0
#define HW_ADDR_TBL_MAXAGE      2

struct xilnet_hw_addr_table 
{
   unsigned char ip_addr[IP_VERSION];
   unsigned char hw_addr[ETH_ADDR_LEN];
   unsigned char flag;
   unsigned int  age;
};



// Ethernet device structure
typedef struct  {
    unsigned char uses_driver;              // Determine if the Ethernet device is uses the Xilnet driver

	// Ethernet interface type: FIFO, DMA
	unsigned char inf_type;                 // XILNET_AXI_DMA_INF, XILNET_AXI_FIFO_INF

	unsigned int  inf_id;                   // XPAR ID for interface
	void *        inf_ref;                  // Pointer to interface instance
	void *        inf_cfg_ref;              // Pointer to interface config instance -- ONLY USED BY DMA

	unsigned int  inf_dma_id;               // XPAR ID for interface dma (for case where both FIFO and Central DMA are used)                 -- ONLY USED BY WARP V2
	void *        inf_dma_ref;              // Pointer to interface dma instance (for case where both FIFO and Central DMA are used)         -- ONLY USED BY WARP V2
    void *        inf_dma_cfg_ref;          // Pointer to interface dma config instance (for case where both FIFO and Central DMA are used)  -- ONLY USED BY WARP V2

    void *        dma_rx_ring_ref;          // Pointer to RX ring                   -- ONLY USED BY DMA
    void *        dma_tx_ring_ref;          // Pointer to TX ring                   -- ONLY USED BY DMA
    void *        dma_rx_bd_ref;            // Pointer to RX buffer descriptor      -- ONLY USED BY DMA
    void *        dma_tx_bd_ref;            // Pointer to TX buffer descriptor      -- ONLY USED BY DMA
    int           dma_rx_bd_cnt;            // Number of RX buffer descriptors      -- ONLY USED BY DMA
    int           dma_tx_bd_cnt;            // Number of TX buffer descriptors      -- ONLY USED BY DMA


	// Flags / Control Variables
	int xilsock_status_flag;
	unsigned char sync_IP_octet;

	// Ethernet device information
	unsigned char node_ip_addr[IP_VERSION];
	unsigned char node_hw_addr[ETH_ADDR_LEN];

    // Socket information
	unsigned char is_xilsock_init;
	void *        xilsock_sockets;
    unsigned char is_udp_init;
    void *        xilnet_udp_conns;

	// HW Address Table
	void * xilnet_hw_tbl;                   // TODO: Unused.  Currently using single global table; placed here for future work

	// Buffers for sending / recieving data
	//   NOTE:  Buffers are allocated based on the configuration in the BSP.  The following options will be used to
    //     determine the buffer size:
	//       recvbuf[XILNET_ETH_*_BUF_SIZE * XILNET_ETH_*_NUM_RECV_BUF]
	//       sendbuf[XILNET_ETH_*_BUF_SIZE]
	//     For DMA interfaces, it is recommended to set XILNET_ETH_*_NUM_RECV_BUF = 2 so that the AXI DMA can use a
	//     ping pong buffer scheme.
	//
    unsigned int   buf_size;
	unsigned int   num_recvbuf;
	unsigned int * recvbuf;
	unsigned int * sendbuf;
} xilnet_eth_device;



#ifdef __cplusplus
}
#endif

#endif	/* _ETH_H */
