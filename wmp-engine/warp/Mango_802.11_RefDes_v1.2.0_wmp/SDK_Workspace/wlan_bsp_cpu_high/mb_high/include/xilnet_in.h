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
// File   : in.h
// Date   : 2002, March 20.
// Author : Sathya Thammanur
// Company: Xilinx
// Group  : Emerging Software Technologies
//
// Summary:
// Header file for Internet related socket definitions
//
// $Id: in.h,v 1.2.8.6 2005/11/15 23:41:10 salindac Exp $
//
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// see copyright.txt for Rice University/Mango Communications modifications
////////////////////////////////////////////////////////////////////////////////

#ifndef _IN_H
#define _IN_H

#ifdef __cplusplus
extern "C" {
#endif

struct in_addr {
   unsigned int s_addr;
};


// structure for internet socket

#define SOCKET_SIZE   16       /* sizeof(struct sockaddr) */
struct sockaddr_in {
   unsigned short    sin_family; /* Address family */
   unsigned short    sin_port   ; /* Port number    */
   struct in_addr    sin_addr   ; /* Internet addr. */
   
   /* Pad to size of `struct sockaddr'. */
   unsigned char  pad[SOCKET_SIZE
                     - sizeof(unsigned short)
                     - sizeof(unsigned short)
                     - sizeof(struct in_addr)];
};


// Accept on any interface
#define INADDR_ANY        ((unsigned int) 0x00000000)

#ifdef __cplusplus
}
#endif

#endif	/* _IN_H */
