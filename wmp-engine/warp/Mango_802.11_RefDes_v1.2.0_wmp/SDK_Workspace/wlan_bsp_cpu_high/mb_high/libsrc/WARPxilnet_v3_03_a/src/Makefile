##########################################################################
# Copyright (c) 2004 Xilinx, Inc.  All rights reserved. 
# 
# Xilinx, Inc. 
# XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS" AS A 
# COURTESY TO YOU.  BY PROVIDING THIS DESIGN, CODE, OR INFORMATION AS 
# ONE POSSIBLE   IMPLEMENTATION OF THIS FEATURE, APPLICATION OR 
# STANDARD, XILINX IS MAKING NO REPRESENTATION THAT THIS IMPLEMENTATION 
# IS FREE FROM ANY CLAIMS OF INFRINGEMENT, AND YOU ARE RESPONSIBLE 
# FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE FOR YOUR IMPLEMENTATION. 
# XILINX EXPRESSLY DISCLAIMS ANY WARRANTY WHATSOEVER WITH RESPECT TO 
# THE ADEQUACY OF THE IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO 
# ANY WARRANTIES OR REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE 
# FROM CLAIMS OF INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY 
# AND FITNESS FOR A PARTICULAR PURPOSE. 
##########################################################################

###########################
#
# Makefile for LibXil Net
#
##########################
COMPILER=
ARCHIVER=
CP=cp
COMPILER_FLAGS=-O2 -c -g
EXTRA_COMPILER_FLAGS=
LIB=libxil.a

RELEASEDIR=../../../lib
INCLUDEDIR=../../../include
INCLUDES=-I./. -I${INCLUDEDIR}

LIBSOURCES=xilnet_arp.c xilnet_eth.c xilnet_icmp.c xilnet_ip.c xilnet_udp.c xilnet_config.c xilnet_xilsock.c
LIBOBJS=$(LIBSOURCES:%.c=%.o)
INCLUDEFILES=xilnet_udp.h xilnet_arp.h xilnet_eth.h xilnet_icmp.h xilnet_in.h xilnet_ip.h xilnet_socket.h xilnet_config.h xilnet_xilsock.h

libs: ${RELEASEDIR}/${LIB}(${LIBOBJS})

(%.o):%.c
	$(COMPILER) $(COMPILER_FLAGS) $(EXTRA_COMPILER_FLAGS) $(INCLUDES) $< -o $*.o
	$(ARCHIVER) -r ${RELEASEDIR}/${LIB} $*.o
	$(RM) $*.o

include:
	${CP} $(INCLUDEFILES) $(INCLUDEDIR)

clean:
	rm -rf *.o


