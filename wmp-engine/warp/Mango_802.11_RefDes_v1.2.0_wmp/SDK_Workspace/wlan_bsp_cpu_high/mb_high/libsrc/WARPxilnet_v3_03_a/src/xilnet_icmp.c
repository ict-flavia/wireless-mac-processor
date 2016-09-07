// ////////////////////////////////////////////////////////////////////////////////
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
// File   : icmp.c
// Date   : 2002, March 20.
// Author : Sathya Thammanur
// Company: Xilinx
// Group  : Emerging Software Technologies
//
// Summary:
// ICMP layer specific functions
//
// $Id: icmp.c,v 1.2.8.6 2005/11/15 23:41:10 salindac Exp $
//
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// see copyright.txt for Rice University/Mango Communications modifications
////////////////////////////////////////////////////////////////////////////////

#include <xilnet_xilsock.h>
#include <string.h>

/*
 * icmp packet handler - handles only echo requests (ping program requests)
 * "buf" is an IP datagram
 */

int xilnet_icmp(unsigned char* buf, int len, unsigned int eth_dev_num) {

    struct xilnet_icmp_hdr *icmph = (struct xilnet_icmp_hdr*) (buf+IP_HDR_LEN*4);

#ifdef _DEBUG_
    xil_printf("In xilnet_imcp(): \n");
#endif
   
    if ((icmph->type == ICMP_ECHO_REQ_TYPE) && (icmph->code == ICMP_ECHO_CODE)) {
        xilnet_icmp_echo_reply(buf, len, eth_dev_num);
    }
    return 0;
}


void xilnet_icmp_echo_reply(unsigned char *buf, unsigned int len, unsigned int eth_dev_num) {
  
   unsigned char * sendbuf = (unsigned char *)eth_device[eth_dev_num].sendbuf;

   struct xilnet_icmp_hdr* icmp_req   = (struct xilnet_icmp_hdr*)(buf + IP_HDR_LEN*4);
   struct xilnet_icmp_hdr* icmp_reply = (struct xilnet_icmp_hdr*)(sendbuf+LINK_HDR_LEN+IP_HDR_LEN*4);
   unsigned char * icmp_data          = sendbuf+LINK_HDR_LEN+IP_HDR_LEN*4+ICMP_HDR_LEN;

#ifdef _DEBUG_
    xil_printf("In xilnet_imcp_echo_reply(): \n");
#endif

   // copy the icmp echo request data 
   memcpy(icmp_data, buf+IP_HDR_LEN*4 + ICMP_HDR_LEN, (len - (IP_HDR_LEN*4 +ICMP_HDR_LEN)));

   icmp_reply->type      = ICMP_ECHO_REPLY_TYPE;
   icmp_reply->code      = ICMP_ECHO_CODE;
   icmp_reply->check_sum = 0;
   icmp_reply->ident     = icmp_req->ident;
   icmp_reply->seq_no    = icmp_req->seq_no;
   icmp_reply->check_sum = Xil_Htons(xilnet_ip_calc_chksum(sendbuf + LINK_HDR_LEN+(IP_HDR_LEN*4), len - (IP_HDR_LEN*4)));
   
   // call ip
   xilnet_ip_header(sendbuf+LINK_HDR_LEN, len, IP_PROTO_ICMP, (buf+IP_SADDR_BASE), eth_dev_num );
   
   // call ethernet
   xilnet_eth_send_frame(sendbuf, len+ETH_HDR_LEN, (buf+IP_SADDR_BASE), NULL, ETH_PROTO_IP, eth_dev_num);
   
}
