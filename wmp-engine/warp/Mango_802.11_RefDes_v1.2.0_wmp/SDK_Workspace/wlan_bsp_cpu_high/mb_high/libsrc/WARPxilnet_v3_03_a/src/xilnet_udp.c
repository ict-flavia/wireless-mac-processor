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
// File   : udp.c
// Date   : 2002, March 20.
// Author : Sathya Thammanur
// Company: Xilinx
// Group  : Emerging Software Technologies
//
// Summary:
// UDP layer specific functions
//
// $Id: udp.c,v 1.2.8.6 2005/11/15 23:41:10 salindac Exp $
//
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// see copyright.txt for Rice University/Mango Communications modifications
////////////////////////////////////////////////////////////////////////////////

#include <xilnet_xilsock.h>
#include <stdio.h>


/*
 * udp packet handler
 * "buf" is a IP datagram
 * currently, this fn just checks for the src port and returns
 * there is only one udp conn available. multiple conns has to have 
 * more support from high level applns for handling packets for diff conns.
 */

int xilnet_udp(unsigned char* buf, int len, unsigned int eth_dev_num) {

    int i;
	struct xilsock_socket  *sockets   = (struct xilsock_socket  *)eth_device[eth_dev_num].xilsock_sockets;
    struct xilnet_udp_hdr  *udph      = (struct xilnet_udp_hdr  *)(buf+IP_HDR_LEN*4);
	struct xilnet_udp_conn *conns     = (struct xilnet_udp_conn *)eth_device[eth_dev_num].xilnet_udp_conns;
	struct xilnet_udp_conn *curr_conn = NULL;
    pktSrcInfo pktInfo;

#ifdef _DEBUG_
    xil_printf("BEGIN xilnet_udp(): \n");
#endif

    // check for an open conn
    for (i = 0; i < XILNET_MAX_UDP_CONNS; i++) {
        if (conns[i].state != UDP_CONN_CLOSED) {
            // match a conn
            if ( (conns[i].src_port == Xil_Ntohs(udph->dst_port))) {
                curr_conn = (conns + i);

                // update the conn with the dst ip only the first time
                conns[i].dst_port = Xil_Ntohs(udph->src_port);
                conns[i].dst_ip[0] = buf[IP_SADDR_BASE];
                conns[i].dst_ip[1] = buf[IP_SADDR_BASE+1];
                conns[i].dst_ip[2] = buf[IP_SADDR_BASE+2];
                conns[i].dst_ip[3] = buf[IP_SADDR_BASE+3];
                break;
            }
        }
    }
    // write data onto the socket of the found conn
    if (curr_conn) {
        buf = buf + (IP_HDR_LEN*4) + UDP_HDR_LEN;
        sockets[curr_conn->fd].recvbuf.buf  = buf;
        sockets[curr_conn->fd].recvbuf.size = len - (IP_HDR_LEN*4) - UDP_HDR_LEN;

        pktInfo.destPort = curr_conn->dst_port;
        pktInfo.srcPort  = curr_conn->src_port;

#ifdef _DEBUG_
        xil_printf("  pktInfo.destPort: %d, pktInfo.srcPort: %d\n", pktInfo.destPort, pktInfo.srcPort);
#endif

        pktInfo.srcIPAddr = (u32)((curr_conn->dst_ip[0]<<24)+(curr_conn->dst_ip[1]<<16)+(curr_conn->dst_ip[2]<<8)+(curr_conn->dst_ip[3]));

#ifdef _DEBUG_
        xil_printf("  pktInfo.srcIPAddr = %d.%d.%d.%d\n",( pktInfo.srcIPAddr>>24)&0xFF,( pktInfo.srcIPAddr>>16)&0xFF,( pktInfo.srcIPAddr>>8)&0xFF,( pktInfo.srcIPAddr)&0xFF);
#endif

        curr_conn->rxCallback(buf,len - (IP_HDR_LEN*4) - UDP_HDR_LEN, &pktInfo, eth_dev_num);

        return (len - (IP_HDR_LEN*4) - UDP_HDR_LEN);
    }  else {
#ifdef _DEBUG_
    xil_printf("  No socket connection found %d : \n", Xil_Ntohs(udph->dst_port) );
    xil_printf("  Current connections are:  \n");
    for (i = 0; i < XILNET_MAX_UDP_CONNS; i++) {
        if (conns[i].state != UDP_CONN_CLOSED) {
            xil_printf("    UDP conn[%d] = %d \n", i, conns[i].src_port);
        }
    }
#endif
    }

#ifdef _DEBUG_
    xil_printf("END xilnet_udp(): \n");
#endif

   return 0;
}


/*
 * udp_header: fills the udp header for the packet to be sent
 */

void xilnet_udp_header(struct xilnet_udp_conn *conn, unsigned char* buf, int len, unsigned int eth_dev_num) {
   
   struct xilnet_udp_hdr *udph = (struct xilnet_udp_hdr*) buf;
   
   udph->src_port  = Xil_Htons(conn->src_port);
   udph->dst_port  = Xil_Htons(conn->dst_port);
   udph->udp_len   = Xil_Htons(len);
   udph->check_sum = 0;
   
   // NOTE:  Currently, we are not computing the checksum on the UDP packets.  This is primarly due to the long
   // compute time (~1ms @ 160 MHz).  It is ok to not compute the checksum since we are using IPv4 (which has its
   // own checksum calculation) and we are only using local networks.
   //   
   // udph->check_sum = Xil_Htons(xilnet_udp_tcp_calc_chksum(buf, len, eth_device[eth_dev_num].node_ip_addr, conn->dst_ip, IP_PROTO_UDP));
}


/* 
 * xilnet_udp_tcp_calc_chksum: Calculate UDP checksum 
 */
unsigned short xilnet_udp_tcp_calc_chksum(unsigned char *buf, int buflen, unsigned char *saddr,
                                          unsigned char *daddr, unsigned short protocol) {
   unsigned int   sum   = 0;
   unsigned short w16   = 0;
   unsigned short proto = protocol;
   short          pad   = 0;
   int            i     = 0;
 
   //check if udp/tcp datagram needs padding
   if (buflen %2) {
      pad = 1; 
      buf[buflen+1] = 0;
   }
   // get the 16bit sum for udp/tcp datagram
   for (i = 0; i < buflen+pad; i = i + 2) {
      w16 = ((buf[i] << 8) & 0xFF00) + (buf[i+1] & 0xFF);
      sum = sum + (unsigned int) w16;   
   }
   
   // add the src and dst ip address
   for (i = 0; i < 4; i = i + 2) {
      w16 = ((saddr[i] << 8) & 0xFF00) + (saddr[i+1] & 0xFF);
      sum = sum + (unsigned int) w16;   
   }
   
   for (i = 0; i < 4; i = i + 2) {
      w16 = ((daddr[i] << 8) & 0xFF00) + (daddr[i+1] & 0x00FF);
      sum = sum + (unsigned int) w16;   
   }
   // add proto and udplength to sum
   sum = sum + proto + buflen;

   while (sum >> 16)
      sum = (sum & 0xFFFF) + (sum >> 16);   
   
   return ((unsigned short)(~sum));	
} 


/******************************
 * udp connection management **
 ******************************/

/*
 * initialize all udp conns so that all the states are CLOSED
 */

void xilnet_udp_init_conns(unsigned int eth_dev_num) {
   
    int i;
	struct xilnet_udp_conn *conns = (struct xilnet_udp_conn *)eth_device[eth_dev_num].xilnet_udp_conns;

    for (i = 0; i < XILNET_MAX_UDP_CONNS; i++) {
        conns[i].state = UDP_CONN_CLOSED;
    }
}


/*
 * open a udp conn:
 * opens a new udp conn and changes state to OPEN
 * returns connection index if able to open else -1 if not possible
 */

int xilnet_udp_open_conn(unsigned short port, void (*callback) (), unsigned int eth_dev_num) {
   
    int i;
	struct xilnet_udp_conn *conns = (struct xilnet_udp_conn *)eth_device[eth_dev_num].xilnet_udp_conns;
   
    if (!eth_device[eth_dev_num].is_udp_init) {
        xilnet_udp_init_conns(eth_dev_num);
        eth_device[eth_dev_num].is_udp_init = 1;
    }
   
    for (i = 0; i < XILNET_MAX_UDP_CONNS; i++) {
        if (conns[i].state == UDP_CONN_CLOSED)
            break;
    }
   
    if (i < XILNET_MAX_UDP_CONNS) {
        conns[i].src_port = port;
        conns[i].state = UDP_CONN_OPEN;
        conns[i].rxCallback = callback;
        return i;
    }
   
    return -1;
}


/* close a udp conn:
 * closes a udp conn by changing state to CLOSED
 * returns 1 if able to close else return -1
 */

int xilnet_udp_close_conn(struct xilnet_udp_conn *conn, unsigned int eth_dev_num) {
   
   int i;
	struct xilnet_udp_conn *conns = (struct xilnet_udp_conn *)eth_device[eth_dev_num].xilnet_udp_conns;

   for (i = 0; i < XILNET_MAX_UDP_CONNS; i++) {
      if ( (conns+i) == conn) {
         conns[i].state = UDP_CONN_CLOSED;
         return 1;
      }
   }
   
   return -1;
}

