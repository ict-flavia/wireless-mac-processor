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
// File   : icmp.h
// Date   : 2002, March 20.
// Author : Sathya Thammanur
// Company: Xilinx
// Group  : Emerging Software Technologies
//
// Summary:
// Header file for ICMP
//
// $Id: icmp.h,v 1.2.8.6 2005/11/15 23:41:10 salindac Exp $
//
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// see copyright.txt for Rice University/Mango Communications modifications
////////////////////////////////////////////////////////////////////////////////

#ifndef _ICMP_H
#define	_ICMP_H

#ifdef __cplusplus
extern "C" {
#endif

#define ICMP_ECHO_REQ_TYPE	8	 /* ping req type */
#define ICMP_ECHO_CODE	        0        /* ping req/reply code */
#define ICMP_ECHO_REPLY_TYPE	0	 /* ping reply type */
#define IP_PROTO_ICMP           1        /* protocol field in IP header */ 
#define ICMP_HDR_LEN            8        /* icmp hdr len */

// icmp header structure
struct xilnet_icmp_hdr {
  unsigned char type;    
  unsigned char	code;
  unsigned short check_sum;
  unsigned short ident;
  unsigned short seq_no;
};

#ifdef __cplusplus
}
#endif

#endif	/* _ICMP_H */
