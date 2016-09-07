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
// File   : arp.c
// Date   : 2002, March 20.
// Author : Sathya Thammanur
// Company: Xilinx
// Group  : Emerging Software Technologies
//
// Summary:
// ARP layer specific functions
//
// $Id: arp.c,v 1.2.8.6 2005/11/15 23:41:10 salindac Exp $
//
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// see copyright.txt for Rice University/Mango Communications modifications
////////////////////////////////////////////////////////////////////////////////

#include <xilnet_xilsock.h>
#include <string.h>

/*
 * xilnet_arp: handler for arp packets
 */

int xilnet_arp(unsigned char *buf, int len, unsigned int eth_dev_num) {

    struct xilnet_arp_pkt* ar = (struct xilnet_arp_pkt*) (buf+ETH_HDR_LEN);
  
#ifdef _DEBUG_
    xil_printf("BEGIN xilnet_arp(): \n");
#endif

    // Analyse if its a arp request and send a reply if needed
    if (
	    Xil_Ntohs(ar->hdr.hard_type) == ARP_HARD_TYPE_ETH &&
	    Xil_Ntohs(ar->hdr.prot_type) == ETH_PROTO_IP &&
	    ar->hdr.hard_size            == ARP_HARD_SIZE &&
	    ar->hdr.prot_size            == ARP_PROTO_IP_SIZE &&
	    ar->target_ip[0]             == eth_device[eth_dev_num].node_ip_addr[0] &&
	    ar->target_ip[1]             == eth_device[eth_dev_num].node_ip_addr[1] &&
	    ar->target_ip[2]             == eth_device[eth_dev_num].node_ip_addr[2] &&
	    ar->target_ip[3]             == eth_device[eth_dev_num].node_ip_addr[3]
	    ) {
        if (Xil_Ntohs(ar->hdr.op) == ARP_REQ) {
            // update hw addr table
            xilnet_eth_update_hw_tbl(buf, ETH_PROTO_ARP, eth_dev_num);
            xilnet_arp_reply( (buf + ETH_HDR_LEN), (len - ETH_HDR_LEN), eth_dev_num);
        }
    }

#ifdef _DEBUG_
    xil_printf("END xilnet_arp(): \n");
#endif

    return 0;
}


/* 
 * xilnet_arp_reply: 
 */

void xilnet_arp_reply(unsigned char *buf, int len, unsigned int eth_dev_num) {

    int i;
    struct xilnet_arp_pkt *pkt;
    struct xilnet_arp_pkt *arp_req = (struct xilnet_arp_pkt*) buf;

#ifdef _DEBUG_  
    xil_printf("BEGIN arp_reply(): \n");
#endif

    pkt = (struct xilnet_arp_pkt*)( ((unsigned char *)eth_device[eth_dev_num].sendbuf) + ETH_HDR_LEN);
  
    pkt->hdr.hard_type = Xil_Htons(ARP_HARD_TYPE_ETH);
    pkt->hdr.prot_type = Xil_Htons(ETH_PROTO_IP);
    pkt->hdr.hard_size = ARP_HARD_SIZE;
    pkt->hdr.prot_size = ARP_PROTO_IP_SIZE;
    pkt->hdr.op        = Xil_Htons(ARP_REPLY);
  
    for (i = 0; i < ETH_ADDR_LEN; i++) {
        pkt->sender_hw[i] = eth_device[eth_dev_num].node_hw_addr[i];
        pkt->target_hw[i] = arp_req->sender_hw[i];
    }
  
    for (i = 0; i < ARP_PROTO_IP_SIZE ; i++) {
        pkt->sender_ip[i] = eth_device[eth_dev_num].node_ip_addr[i];
        pkt->target_ip[i] = arp_req->sender_ip[i];
    }
    memset(pkt->pad, 0, ARP_PAD_SIZE);

#ifdef _DEBUG_
    xil_printf("  ARP packet: \n");
    print_pkt((unsigned char *)eth_device[eth_dev_num].sendbuf, ETH_MIN_FRAME_LEN);
#endif

    /* initialize ethernet header */
    xilnet_eth_send_frame((unsigned char *)eth_device[eth_dev_num].sendbuf,
    		              ETH_MIN_FRAME_LEN, arp_req->sender_ip, pkt->target_hw, ETH_PROTO_ARP, eth_dev_num);

#ifdef _DEBUG_
    xil_printf("BEGIN arp_reply(): \n");
#endif
}


/* 
 * xilnet_arp_reply: 
 */

// Currently ARP Announce is not used by the WARPNet framework.  If needed, please uncomment this code.
#if 0
 
void xilnet_arp_announce(unsigned int eth_dev_num) {

    int i;
    struct xilnet_arp_pkt *pkt;
    unsigned char bcast_addr[6] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};

#ifdef _DEBUG_
    xil_printf("BEGIN xilnet_arp_announce(): \n");
#endif

    pkt = (struct xilnet_arp_pkt*)(((unsigned char *)eth_device[eth_dev_num].sendbuf) + ETH_HDR_LEN);
  
    pkt->hdr.hard_type = ARP_HARD_TYPE_ETH;
    pkt->hdr.prot_type = ETH_PROTO_IP;
    pkt->hdr.hard_size = ARP_HARD_SIZE;
    pkt->hdr.prot_size = ARP_PROTO_IP_SIZE;
    pkt->hdr.op        = ARP_REPLY;
  
    for (i = 0; i < ETH_ADDR_LEN; i++) {
      pkt->sender_hw[i] = eth_device[eth_dev_num].node_hw_addr[i];
      pkt->target_hw[i] = 0xFF;
    }
  
    for (i = 0; i < ARP_PROTO_IP_SIZE ; i++) {
      pkt->sender_ip[i] = eth_device[eth_dev_num].node_ip_addr[i];
      pkt->target_ip[i] = 0xFF;
    }
    memset(pkt->pad, 0, ARP_PAD_SIZE);
  
#ifdef _DEBUG_
    xil_printf("xilnet_arp_announce: Sending arp announce\r\n");
#endif

    /* initialize ethernet header */
    xilnet_eth_send_frame((unsigned char *)eth_device[eth_dev_num].sendbuf,
    		              ETH_MIN_FRAME_LEN, NULL, (void *)&bcast_addr, ETH_PROTO_ARP, eth_dev_num);

#ifdef _DEBUG_
    xil_printf("END xilnet_arp_announce(): \n");
#endif
}


#endif