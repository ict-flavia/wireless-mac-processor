
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
// File   : xilsock.c
// Date   : 2002, March 20.
// Author : Sathya Thammanur
// Company: Xilinx
// Group  : Emerging Software Technologies
//
// Summary:
// Xilinx internal socket related functions (xilsock functions)
//
// $Id: xilsock.c,v 1.2.8.6 2005/11/15 23:41:10 salindac Exp $
//
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// see copyright.txt for Rice University/Mango Communications modifications
////////////////////////////////////////////////////////////////////////////////

#include <xilnet_config.h>

/*
 * Print the xilsock error message
 */

void xilsock_print_error_msg( unsigned int eth_dev_num ) {
    xil_printf("  **** ERROR:  Ethernet device %d is not supported by the WARPxilnet library.  \n", (eth_dev_num+1) );
    xil_printf("               Please check library configuration in the BSP.   \n" );
}



/*
 * Initialization of xilsock_sockets
 */

int xilsock_init (unsigned int eth_dev_num) {

    int i;
    
    struct xilsock_socket * sockets = (struct xilsock_socket *)eth_device[eth_dev_num].xilsock_sockets;
    
    // Check to see if the xilnet driver uses the Ethernet instance
	if ( !eth_device[eth_dev_num].uses_driver ) {
        xilsock_print_error_msg( eth_dev_num );
		return -1;
	}

    if (!eth_device[eth_dev_num].is_xilsock_init) {
        for (i = 0; i < NO_OF_XILSOCKS; i++) {
    	    sockets[i].type          = 0;
    	    sockets[i].domain        = 0;
    	    sockets[i].proto         = 0;
    	    sockets[i].listen        = 0;
    	    sockets[i].bound         = 0;
    	    sockets[i].accept        = 0;
    	    sockets[i].connect       = 0;
    	    sockets[i].closing       = 0;
    	    sockets[i].closed        = 0;
    	    sockets[i].free          = 1;
    	    sockets[i].conn.tcp_conn = NULL;
    	    sockets[i].recvbuf.buf   = NULL;
    	    sockets[i].recvbuf.size  = 0;
        }
        eth_device[eth_dev_num].is_xilsock_init = 1;
    }
    return eth_device[eth_dev_num].is_xilsock_init;
}


/*
 * Release a socket
 */

void xilsock_rel_socket (int sd, unsigned int eth_dev_num) {

	struct xilsock_socket * sockets = (struct xilsock_socket *)eth_device[eth_dev_num].xilsock_sockets;

	// Check to see if the xilnet driver uses the Ethernet instance
	if ( !eth_device[eth_dev_num].uses_driver ) {
        xilsock_print_error_msg( eth_dev_num );
		return;
	}

    // Zero out the socket
    memset( &( sockets[sd] ), 0x0, sizeof( xilsock_socket ) );

    // Set the free field
    sockets[sd].free = 1;
    
    
#if 0    
    if (sockets[sd].type == SOCK_STREAM) {
    	sockets[sd].conn.tcp_conn = NULL;
    }
    else {
    	sockets[sd].conn.udp_conn = NULL;
    }
    sockets[sd].type         = 0;
    sockets[sd].domain       = 0;
    sockets[sd].proto        = 0;
    sockets[sd].listen       = 0;
    sockets[sd].bound        = 0;
    sockets[sd].accept       = 0;
    sockets[sd].connect      = 0;
    sockets[sd].closing      = 0;
    sockets[sd].closed       = 0;
    sockets[sd].free         = 1;
    sockets[sd].recvbuf.buf  = NULL;
    sockets[sd].recvbuf.size = 0;
#endif

}


/*
 * Allocate a xilsock_socket and return socket descriptor
 * if not able to alloc socket, return -1
 */

int xilsock_socket(int domain, int type, int proto, unsigned int eth_dev_num) {

    int sd;
	struct xilsock_socket * sockets = (struct xilsock_socket *)eth_device[eth_dev_num].xilsock_sockets;

	// Check to see if the xilnet driver uses the Ethernet instance
	if ( !eth_device[eth_dev_num].uses_driver ) {
        xilsock_print_error_msg( eth_dev_num );
		return -1;
	}

    // find a free xilsock_socket
    if (!xilsock_init(eth_dev_num)){
	    xil_printf("xilsock is not initialized\n");
        return (-1);
    }
    
    for (sd = 0; sd < NO_OF_XILSOCKS; sd++) {
        if (sockets[sd].free) {
            // initialise the socket & make it unavailable
            sockets[sd].domain = domain;
            sockets[sd].type   = type;
            sockets[sd].proto  = proto;
            sockets[sd].free   = 0;

            // Debug print:
            // xil_printf("Socket %d: [%d, %d, %d, %d] \n", sd, domain, type, proto, eth_dev_num);
            return sd;
        }
    }
    // return as no sockets available
    xil_printf("No sockets available on ethernet device %d!\n", eth_dev_num);
    return -1;
}


/*
 * bind a socket to the specified address.
 * binds addr to socket sd. returns 1 if bound
 * returns -1 if not able to bind
 */

int xilsock_bind(int sd, struct sockaddr* addr, int addrlen, void (*callback) (), unsigned int eth_dev_num) {

    int connd;
	struct xilsock_socket  * sockets = (struct xilsock_socket  *)eth_device[eth_dev_num].xilsock_sockets;
	struct xilnet_udp_conn * conns   = (struct xilnet_udp_conn *)eth_device[eth_dev_num].xilnet_udp_conns;

	// Check to see if the xilnet driver uses the Ethernet instance
	if ( !eth_device[eth_dev_num].uses_driver ) {
        xilsock_print_error_msg( eth_dev_num );
		return -1;
	}

    // open a tcp conn/udp conn
    if (sockets[sd].type == SOCK_STREAM) {
	    xil_printf("*** Error xilsock_bind: tcp sockets not available \n");
        xilsock_rel_socket(sd, eth_dev_num);
        return -1;
    }
    else if (sockets[sd].type == SOCK_DGRAM) {
        if ( (connd = xilnet_udp_open_conn (((struct sockaddr_in*)addr)->sin_port, callback, eth_dev_num)) == -1) {
    	    xil_printf("*** Error xilsock_bind: udp sockets not available \n");
            xilsock_rel_socket(sd, eth_dev_num);
            return -1;
        }
        sockets[sd].conn.udp_conn = (conns + connd);
        // update fd of udp conn
        conns[connd].fd = sd;
    }

    return 1;
}


/*
 * listen on a socket
 * called from listen()
 */

int xilsock_listen(int s, int backlog, unsigned int eth_dev_num) {

	struct xilsock_socket  * sockets = (struct xilsock_socket  *)eth_device[eth_dev_num].xilsock_sockets;

	// Check to see if the xilnet driver uses the Ethernet instance
	if ( !eth_device[eth_dev_num].uses_driver ) {
        xilsock_print_error_msg( eth_dev_num );
		return -1;
	}

	sockets[s].listen = 1;
    return 1;
}



/*
 * recv data on socket
 * called from recv()
 * returns -1 if no data recvd for "s" (non_blocking call) or
 * number of bytes recvd for "s"
 */

int xilsock_recv(int s, unsigned char *buf, unsigned int len, unsigned int eth_dev_num) {

    unsigned int n;
	struct xilsock_socket  * sockets = (struct xilsock_socket  *)eth_device[eth_dev_num].xilsock_sockets;
    int bytes_recvd = 0;

	// Check to see if the xilnet driver uses the Ethernet instance
	if ( !eth_device[eth_dev_num].uses_driver ) {
        xilsock_print_error_msg( eth_dev_num );
		return -1;
	}

    if (s > NO_OF_XILSOCKS) {
	    xil_printf("*** Error xilsock_recv: invalid socket descriptor %d \n", s);
        return -1;
    }

   n = xilnet_eth_recv_frame(eth_dev_num);

   // Return if data not for socket s
   if ((n == -1) || (sockets[s].recvbuf.buf == NULL))
      return -1;

   // Copy data if required onto buf
   if (sockets[s].recvbuf.buf != buf)
   {
      memcpy(buf, sockets[s].recvbuf.buf, len);
      bytes_recvd = sockets[s].recvbuf.size;

      //reset socket buffer and size
      sockets[s].recvbuf.buf  = NULL;
      sockets[s].recvbuf.size = 0;
   }

   // return no of bytes recvd for this conn
   return bytes_recvd;
}


/*
 * send data on socket
 * called from send()
 */

int xilsock_send(int s,  unsigned char* buf, unsigned int len, unsigned int eth_dev_num) {

    xil_printf("*** Error xilsock_send: TCP connections are not supported\n");
    return -1;

#if 0
    struct xilnet_tcp_conn *conn;
	struct xilsock_socket  * sockets = (struct xilsock_socket  *)eth_device[eth_dev_num].xilsock_sockets;
    unsigned char          * sendbuf = (unsigned char *)eth_device[eth_dev_num].sendbuf;


    conn = sockets[s].conn.tcp_conn;

    if (!conn) {
        xil_printf("*** Error xilsock_send: no such socket %d \n", conn);
        return -1;
    }

    if (buf != sendbuf) {
        memset(sendbuf, 0, eth_device[eth_dev_num].buf_size);
        memcpy(sendbuf+LINK_HDR_LEN+IP_HDR_LEN*4+(TCP_HDR_LEN*4), buf, len);
    }

     xilnet_tcp_send_pkt(conn, sendbuf+LINK_HDR_LEN+IP_HDR_LEN*4, len, TCP_ACK, eth_dev_num);
     xilnet_ip_header(sendbuf+LINK_HDR_LEN, len+(TCP_HDR_LEN*4)+IP_HDR_LEN*4, IP_PROTO_TCP, conn->dst_ip, eth_dev_num);

     xilnet_eth_send_frame(sendbuf, len+(TCP_HDR_LEN*4)+IP_HDR_LEN*4+ETH_HDR_LEN, conn->dst_ip, NULL, ETH_PROTO_IP, eth_dev_num);

     return len;
#endif
}


/*
 * recvfrom socket
 * Data recvd on any UDP socket
 * return -1 if data not for socket "s" [non-blocking call]
 */
int xilsock_recvfrom(int s, unsigned char *buf, unsigned int len,
                     struct sockaddr* from, unsigned int *fromlen, unsigned int eth_dev_num)
{
    int n;
    int bytes_recvd = 0;
	struct xilsock_socket  * sockets = (struct xilsock_socket  *)eth_device[eth_dev_num].xilsock_sockets;
    struct xilnet_udp_conn * conn    = sockets[s].conn.udp_conn;

	// Check to see if the xilnet driver uses the Ethernet instance
	if ( !eth_device[eth_dev_num].uses_driver ) {
        xilsock_print_error_msg( eth_dev_num );
		return -1;
	}

    if (s > NO_OF_XILSOCKS) {
        xil_printf("*** Error xilsock_recvfrom: invalid socket descriptor %d \n", s);
        return -1;
    }

    n = xilnet_eth_recv_frame(eth_dev_num);

    // Return if data not for socket s
    if ((n < 0 ) || (sockets[s].recvbuf.buf == NULL))
        return -1;

   // Copy data if required onto buf
   if (sockets[s].recvbuf.buf != buf)
   {
      memcpy(buf, sockets[s].recvbuf.buf, len);
      bytes_recvd = sockets[s].recvbuf.size;

      //reset socket buffer and size
      sockets[s].recvbuf.buf = NULL;
      sockets[s].recvbuf.size = 0;
   }

   // Copy the source address onto "to"
   ((struct sockaddr_in*)from)->sin_addr.s_addr =
      (conn->dst_ip[0] << 24) + (conn->dst_ip[1] << 16) + (conn->dst_ip[2] << 8) + conn->dst_ip[3];
   ((struct sockaddr_in*)from)->sin_port = conn->dst_port;
   *fromlen = sizeof(from);

   // return no of bytes recvd for this conn
   return bytes_recvd;
}


/*
 * sendto socket
 * called from sendto()
 */

int xilsock_sendto(int s,  unsigned char* buf, unsigned int len, struct sockaddr* to, unsigned int eth_dev_num)
{

    struct xilnet_udp_conn * conn;
	struct xilsock_socket  * sockets = (struct xilsock_socket  *)eth_device[eth_dev_num].xilsock_sockets;
    unsigned int             dstaddr = ((struct sockaddr_in*)to)->sin_addr.s_addr;
    unsigned char          * sendbuf = buf;

    // Updated function so that it uses the provided buffer instead of copying the data to the sendbuf of the
    //   given ethernet device.  This enables callers to maintain buffers beyond the single send buffer 
    //   provided by the Xilnet framework.
    //
    // unsigned char          * sendbuf = (unsigned char *)eth_device[eth_dev_num].sendbuf;

	// Check to see if the xilnet driver uses the Ethernet instance
	if ( !eth_device[eth_dev_num].uses_driver ) {
        xilsock_print_error_msg( eth_dev_num );
		return -1;
	}
    
    conn = sockets[s].conn.udp_conn;
    conn->dst_ip[0] = (unsigned char) ((dstaddr >> 24) & 0xFF);
    conn->dst_ip[1] = (unsigned char) ((dstaddr >> 16) & 0xFF);
    conn->dst_ip[2] = (unsigned char) ((dstaddr >> 8) & 0xFF);
    conn->dst_ip[3] = (unsigned char) ((dstaddr) & 0xFF);
    conn->dst_port  = ((struct sockaddr_in*)to)->sin_port;

    if (!conn) {
        xil_printf("*** Error xilsock_sendto: no such socket %d \n", conn);
        return -1;
    }

    // See comments above.
    //
    // if (buf != sendbuf) {
    //     memset(sendbuf, 0, eth_device[eth_dev_num].buf_size);
    //     memcpy(sendbuf+LINK_HDR_LEN+IP_HDR_LEN*4+UDP_HDR_LEN, buf, len);
    // }

    // calls to udp stack
    xilnet_udp_header(conn, sendbuf+LINK_HDR_LEN+IP_HDR_LEN*4, len+UDP_HDR_LEN, eth_dev_num);

    xilnet_ip_header(sendbuf+LINK_HDR_LEN, len+UDP_HDR_LEN+IP_HDR_LEN*4, IP_PROTO_UDP, conn->dst_ip, eth_dev_num);

    xilnet_eth_send_frame(sendbuf, len+UDP_HDR_LEN+IP_HDR_LEN*4+ETH_HDR_LEN, conn->dst_ip, NULL, ETH_PROTO_IP, eth_dev_num);

    return len;
}


/*
 * close socket
 */

void xilsock_close(int s, unsigned int eth_dev_num) {

#if 0
	unsigned char flags = 0;
    unsigned short check = 0;
    unsigned char *tcp_reply;
    unsigned char          * sendbuf = (unsigned char *)eth_device[eth_dev_num].sendbuf;
#endif
	struct xilsock_socket  * sockets = (struct xilsock_socket  *)eth_device[eth_dev_num].xilsock_sockets;

	// Check to see if the xilnet driver uses the Ethernet instance
	if ( !eth_device[eth_dev_num].uses_driver ) {
        xilsock_print_error_msg( eth_dev_num );
		return;
	}

    if (sockets[s].type == SOCK_STREAM) {

    	xil_printf("*** Error xilsock_close: TCP connections are not supported\n");

#if 0
    	struct xilnet_tcp_conn *conn = sockets[s].conn.tcp_conn;

        // construct the FIN and wait for ack & FIN from client
        flags = (TCP_FIN | TCP_ACK);
        ((struct xilnet_tcp_conn*)conn)->state = TCP_FIN_WAIT1;
        memset(sendbuf, 0, LINK_FRAME_LEN);
        tcp_reply = sendbuf+ETH_HDR_LEN+(IP_HDR_LEN*4);

        xilnet_tcp_header(((struct xilnet_tcp_conn*)conn), tcp_reply, 1, flags, eth_dev_num);

        // calculate tcp checksum
        check = xilnet_udp_tcp_calc_chksum(tcp_reply, (TCP_HDR_LEN*4), eth_device[eth_dev_num].node_ip_addr, ((struct xilnet_tcp_conn*)conn)->dst_ip, IP_PROTO_TCP);
        tcp_reply[TCP_CHECK_OFF]   = (check & 0xff00) >> 8;
        tcp_reply[TCP_CHECK_OFF+1] = (check & 0x00ff);

        xilnet_ip_header(sendbuf+ETH_HDR_LEN,(IP_HDR_LEN*4)+(TCP_HDR_LEN*4), IP_PROTO_TCP, ((struct xilnet_tcp_conn*)conn)->dst_ip, eth_dev_num);
        xilnet_eth_send_frame(sendbuf, (TCP_HDR_LEN*4)+(IP_HDR_LEN*4)+ETH_HDR_LEN, ((struct xilnet_tcp_conn*)conn)->dst_ip, NULL, ETH_PROTO_IP, eth_dev_num);
#endif

    }
    else if (sockets[s].type == SOCK_DGRAM) {
        xilnet_udp_close_conn(sockets[s].conn.udp_conn, eth_dev_num);
        // close the socket
        xilsock_rel_socket(s, eth_dev_num);
    }
}
