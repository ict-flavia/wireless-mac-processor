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
// File   : ip.c
// Date   : 2002, March 20.
// Author : Sathya Thammanur
// Company: Xilinx
// Group  : Emerging Software Technologies
//
// Summary:
// IP layer specific functions
//
// $Id: ip.c,v 1.2.8.6 2005/11/15 23:41:10 salindac Exp $
//
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// see copyright.txt for Rice University/Mango Communications modifications
////////////////////////////////////////////////////////////////////////////////

#include <xilnet_xilsock.h>


/*
 * initialize xilnet ip address
 */
void xilnet_ip_init(unsigned char* addr, unsigned int eth_dev_num) {
    int k = 0;
    int j;
    int sum = 0;

    for (j = 0; j < 3; j++) {

        // parse input for dotted decimal notation of ip address
        while(addr[k] != '.') {
            sum = sum * 10 + addr[k] - 48;
            k++;
        }

        k++; // move over the dot
        eth_device[eth_dev_num].node_ip_addr[j] = (unsigned char) sum;
        sum = 0;
    }

    // read last byte of ip address
    while (addr[k] != '\0') {
        sum = sum * 10 + addr[k] - 48;
        k++;
    }
    eth_device[eth_dev_num].node_ip_addr[3] = (unsigned char) sum;
}


/*
 * ip datagram handler:
 * checks for the source ip address and calls the corr protocol handler
 * no checksum calc is done to detect any errors
 */

int xilnet_ip(unsigned char*buf, int len, unsigned int eth_dev_num) {

    int iplen = 0;
    struct xilnet_ip_hdr *iph = (struct xilnet_ip_hdr *) (buf+ETH_HDR_LEN);

#ifdef _DEBUG_
    xil_printf("BEGIN xilnet_ip(): \n");
    xil_printf("  Packet IP Address: %d.%d.%d.%d \n", (buf+ETH_HDR_LEN)[IP_DADDR_BASE],   (buf+ETH_HDR_LEN)[IP_DADDR_BASE+1],
                                                      (buf+ETH_HDR_LEN)[IP_DADDR_BASE+2], (buf+ETH_HDR_LEN)[IP_DADDR_BASE+3]);
    xil_printf("  Device IP Address: %d.%d.%d.%d \n", eth_device[eth_dev_num].node_ip_addr[0], eth_device[eth_dev_num].node_ip_addr[1],
                                                      eth_device[eth_dev_num].node_ip_addr[2], eth_device[eth_dev_num].node_ip_addr[3]);
#endif

    unsigned char * ip_hdr  = (unsigned char *) buf + ETH_HDR_LEN;
    unsigned char addr_pass = 0;

    // If the node has not been initialized (ie address is 10.0.0.0)    
    if ( eth_device[eth_dev_num].node_ip_addr[3] == 0 ) {

        // Accept broadcast packets from 10.0.X.255
        if ( ip_hdr[IP_DADDR_BASE]   == eth_device[eth_dev_num].node_ip_addr[0] &&
             ip_hdr[IP_DADDR_BASE+1] == eth_device[eth_dev_num].node_ip_addr[1] &&
             ip_hdr[IP_DADDR_BASE+3] == 255 ) {

             addr_pass = 1;
        }
    } else {
        // Accept unicast packets and broadcast packets on the given subnet
        if ( ip_hdr[IP_DADDR_BASE]   == eth_device[eth_dev_num].node_ip_addr[0] &&
             ip_hdr[IP_DADDR_BASE+1] == eth_device[eth_dev_num].node_ip_addr[1] &&
             ip_hdr[IP_DADDR_BASE+2] == eth_device[eth_dev_num].node_ip_addr[2] &&
            (ip_hdr[IP_DADDR_BASE+3] == eth_device[eth_dev_num].node_ip_addr[3] || ip_hdr[IP_DADDR_BASE+3] == 255 )) {

            addr_pass = 1;
        }
    }

    if (addr_pass == 1) {

        // update hw addr table
        xilnet_eth_update_hw_tbl(buf, ETH_PROTO_IP, eth_dev_num);

        iplen = (unsigned short)( ((((unsigned short)buf[ETH_HDR_LEN+2]) << 8) & 0xFF00) +
                                   (((unsigned short)buf[ETH_HDR_LEN+3]) & 0x00FF) );

#ifdef _DEBUG_
    xil_printf("  IP protocol: %d \n", iph->prot);
#endif

    // call corr protocol handler with the ip datagram
        switch (iph->prot) {
            case IP_PROTO_UDP:
	            return (xilnet_udp(buf+ETH_HDR_LEN, iplen, eth_dev_num));
	        break;
            case IP_PROTO_TCP:
                xil_printf("Error:  Xilnet does not support TCP \n");
            	return 0;
	        break;
            case IP_PROTO_ICMP:
	            return (xilnet_icmp(buf+ETH_HDR_LEN, iplen, eth_dev_num));
	        break;
            default:
                xil_printf("Error:  unknown IP protocol \n");
                return 0;
	        break;
        }
    }

#ifdef _DEBUG_
    xil_printf("END xilnet_ip(): \n");
#endif

    return 0;
}


/*
 * xilnet_ip_header: fills in the ip header for proto
 */
int ip_id_cnt = 0;

void xilnet_ip_header(unsigned char* buf, int len, int proto, unsigned char *peer_ip_addr, unsigned int eth_dev_num) {

   struct xilnet_ip_hdr *iph = (struct xilnet_ip_hdr*) buf;

#ifdef _DEBUG_
   xil_printf("In xilnet_ip_header(): \n");
#endif

   buf[0]               = IP_VERSION << 4;
   buf[0]              |= IP_HDR_LEN;
   iph->tos             = IP_TOS;
   iph->total_len       = Xil_Htons(len);
   iph->ident           = Xil_Htons(ip_id_cnt++);
   iph->frag_off        = Xil_Htons(IP_FRAG_OFF);
   iph->ttl             = IP_TTL;
   iph->prot            = proto;
   iph->check_sum       = 0;
   buf[IP_SADDR_BASE]   = eth_device[eth_dev_num].node_ip_addr[0];
   buf[IP_SADDR_BASE+1] = eth_device[eth_dev_num].node_ip_addr[1];
   buf[IP_SADDR_BASE+2] = eth_device[eth_dev_num].node_ip_addr[2];
   buf[IP_SADDR_BASE+3] = eth_device[eth_dev_num].node_ip_addr[3];
   buf[IP_DADDR_BASE]   = peer_ip_addr[0];
   buf[IP_DADDR_BASE+1] = peer_ip_addr[1];
   buf[IP_DADDR_BASE+2] = peer_ip_addr[2];
   buf[IP_DADDR_BASE+3] = peer_ip_addr[3];
   iph->check_sum = Xil_Htons(xilnet_ip_calc_chksum(buf, IP_HDR_LEN*4));

}


/*
 * xilnet_ip_calc_chksum: compute checksum for ip header
 */

unsigned short xilnet_ip_calc_chksum(unsigned char* buf, int len) {

   unsigned int sum = 0;
   unsigned short w16 = 0;
   int i;

   for (i = 0; i < len; i = i + 2) {
      w16 = ((buf[i] << 8) & 0xFF00) + (buf[i+1] & 0x00FF);
      sum = sum + (unsigned int) w16;
   }

   while (sum >> 16)
      sum = (sum & 0xFFFF) + (sum >> 16);

   return (unsigned short) (~sum);
}
