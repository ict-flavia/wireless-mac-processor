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
// File   : udp.h
// Date   : 2002, March 20.
// Author : Sathya Thammanur
// Company: Xilinx
// Group  : Emerging Software Technologies
//
// Summary:
// Header file for UDP
//
// $Id: udp.h,v 1.2.8.6 2005/11/15 23:41:10 salindac Exp $
//
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// see copyright.txt for Rice University/Mango Communications modifications
////////////////////////////////////////////////////////////////////////////////

#ifndef _UDP_H
#define _UDP_H

#ifdef __cplusplus
extern "C" {
#endif

#include <xilnet_ip.h>
#include <xilnet_config.h>
#include <xil_types.h>

#define UDP_HDR_LEN         0x0008      /* 8-byte header */
#define NO_UDP_CHECKSUM     0x0000      /* No udp checksum is calculated */
#define IP_PROTO_UDP        17          /* protocol field in IP header */ 
#define UDP_STRIP_HDR       0x01        /* remove header for udp handler type */
#define UDP_ADD_HDR         0x02        /* add header for udp handler type */
#define UDP_PORT            69          /* tftp port no. */
#define UDP_DATA            1460        /* max possible udp data for ethernet */

// udp header structure
struct xilnet_udp_hdr {
  unsigned short src_port;
  unsigned short dst_port;
  unsigned short udp_len;
  unsigned short check_sum;
};

// udp packet
struct xilnet_udp_pkt {
  struct xilnet_udp_hdr udp_hdr;
  unsigned char data[UDP_DATA];
};

typedef struct {
	u32 srcIPAddr;
	u16 srcPort;
	u16 destPort;
} pktSrcInfo;


// udp connection management


#define UDP_CONN_OPEN         0      // waiting for client connection (only src port is known)
#define UDP_CONN_CLOSED       1      // connection can be used 
#define UDP_CONN_ESTABLISHED  2      // full conn established (both src and dst ports are known)


struct xilnet_udp_conn {
   unsigned short src_port;
   unsigned short dst_port;
   unsigned char src_ip[IP_VERSION];
   unsigned char dst_ip[IP_VERSION];
   unsigned char state;
   unsigned char reserved;
   int fd; // socket descriptor into xsock_sockets table
   void (*rxCallback)();
} ;


#ifdef __cplusplus
}
#endif

#endif	/* _UDP_H */
