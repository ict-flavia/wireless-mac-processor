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
// File   : ip.h
// Date   : 2002, March 20.
// Author : Sathya Thammanur
// Company: Xilinx
// Group  : Emerging Software Technologies
//
// Summary:
// Header file for IP Header File
//
// $Id: ip.h,v 1.2.8.6 2005/11/15 23:41:10 salindac Exp $
//
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// see copyright.txt for Rice University/Mango Communications modifications
////////////////////////////////////////////////////////////////////////////////

#ifndef _IP_H
#define _IP_H

#ifdef __cplusplus
extern "C" {
#endif

// ip header structure
struct xilnet_ip_hdr {
  unsigned char version:4,
                hdr_len:4;
  unsigned char	tos;
  unsigned short total_len;
  unsigned short ident;
  unsigned short frag_off;
  unsigned char	ttl;
  unsigned char	prot;
  unsigned short check_sum;
  unsigned int	src_ip;
  unsigned int	dst_ip;
};

#define IP_VERSION         4       /* 4 for IPV4 */
#define IP_HDR_LEN         5       /* no. of 32-bit words in header */
#define IP_TOS             0x00    /* 0x00 is the tos val for tftp */
#define IP_TOTAL_LEN       0x0220  /* 544 bytes is the max length of ip datagram for TFTP */
#define IP_IDENT           0x006F  /* 111 is the value for no fragmentation */
#define IP_FRAG_OFF        0x0000  /* No fragmentation - 0x0000 */
#define IP_TTL             0x20    /* 32 hops */

#define IP_DADDR_BASE 16
#define IP_SADDR_BASE 12

#define IP_PROTO_TCP       0x06    /* Xilnet does not support TCP connections */


#ifdef __cplusplus
}
#endif
 
#endif	/* _SYS_IP_H */
