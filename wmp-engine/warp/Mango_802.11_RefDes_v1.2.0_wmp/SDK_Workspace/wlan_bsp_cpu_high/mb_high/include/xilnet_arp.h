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
// File   : arp.h
// Date   : 2002, March 20.
// Author : Sathya Thammanur
// Company: Xilinx
// Group  : Emerging Software Technologies
//
// Summary:
// Header file for ARP
//
// $Id: arp.h,v 1.2.8.6 2005/11/15 23:41:10 salindac Exp $
//
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// see copyright.txt for Rice University/Mango Communications modifications
////////////////////////////////////////////////////////////////////////////////

#ifndef _ARP_H
#define _ARP_H

#ifdef __cplusplus
extern "C" {
#endif

#include <xilnet_eth.h>

/* ARP hardware types */

#define ARP_HARD_TYPE_ETH    0x01  /* ethernet hardware address */
#define ARP_HARD_SIZE        0x06  /* ethernet address size  */
#define ARP_PROTO_IP_SIZE    0x04  /* ip address size */
#define ARP_PAD_SIZE         18    /* no.of bytes to be padded in arp pkt */ 


/* ARP operation codes */
#define	ARP_REQ 	1	 /* ARP request	*/
#define	ARP_REPLY	2	 /* ARP reply	*/

#define ARP_SIP_OFFSET    14
#define ARP_DIP_OFFSET    24

/*
 *	This structure defines an ethernet arp header.
 */

struct xilnet_arp_hdr
{
  unsigned short hard_type;   /* type of hardware address */
  unsigned short prot_type;   /* type of protocol address */	
  unsigned char	hard_size;    /* hardware address size */
  unsigned char	prot_size;    /* protocol address size */	
  unsigned short op;	      /* arp opcode */
};

struct xilnet_arp_pkt
{
  struct xilnet_arp_hdr  hdr;           /* arp header */
  unsigned char	sender_hw[ETH_ADDR_LEN];     /* sender hardware address	*/
  unsigned char	sender_ip[4];	         /* sender IP address		*/
  unsigned char	target_hw[ETH_ADDR_LEN];     /* target hardware address	*/
  unsigned char	target_ip[4];	         /* target IP address		*/
  unsigned char pad[18];                 /* pad with 0 for min eth frame requirement */
};

#ifdef __cplusplus
}
#endif

#endif	/* _ARP_H */
