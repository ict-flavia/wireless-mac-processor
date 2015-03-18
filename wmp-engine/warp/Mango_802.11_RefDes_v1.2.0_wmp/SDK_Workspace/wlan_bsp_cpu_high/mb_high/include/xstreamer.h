/**************************************************************
 * (c) Copyright 2005 - 2009 Xilinx, Inc. All rights reserved.
 *
 * This file contains confidential and proprietary information
 * of Xilinx, Inc. and is protected under U.S. and
 * international copyright and other intellectual property
 * laws.
 *
 * DISCLAIMER
 * This disclaimer is not a license and does not grant any
 * rights to the materials distributed herewith. Except as
 * otherwise provided in a valid license issued to you by
 * Xilinx, and to the maximum extent permitted by applicable
 * law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
 * WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
 * AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
 * BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
 * INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
 * (2) Xilinx shall not be liable (whether in contract or tort,
 * including negligence, or under any other theory of
 * liability) for any loss or damage of any kind or nature
 * related to, arising under or in connection with these
 * materials, including for any direct, or any indirect,
 * special, incidental, or consequential loss or damage
 * (including loss of data, profits, goodwill, or any type of
 * loss or damage suffered as a result of any action brought
 * by a third party) even if such damage or loss was
 * reasonably foreseeable or Xilinx had been advised of the
 * possibility of the same.
 *
 * CRITICAL APPLICATIONS
 * Xilinx products are not designed or intended to be fail-
 * safe, or for use in any application requiring fail-safe
 * performance, such as life-support or safety devices or
 * systems, Class III medical devices, nuclear facilities,
 * applications related to the deployment of airbags, or any
 * other applications that could lead to death, personal
 * injury, or severe property or environmental damage
 * (individually and collectively, "Critical
 * Applications"). Customer assumes the sole risk and
 * liability of any use of Xilinx products in Critical
 * Applications, subject only to applicable laws and
 * regulations governing limitations on product liability.
 *
 * THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
 * PART OF THIS FILE AT ALL TIMES.
 *************************************************************/
/*
 *
 * @file xstreamer.h
 *
 * The Xilinx byte streamer for packet FIFOs.
 *
 * <h2>Driver Description</h2>
 *
 * This driver enables higher layer software to access a hardware FIFO using
 * any alignment in the data buffers while preserving alignment for the hardware
 * FIFO access.
 *
 * This driver treats send and receive channels separately, using different
 * types of instance objects for each.
 *
 * This driver makes use of another FIFO driver to access the specific FIFO
 * hardware through use of the routines passed into the Tx/RxInitialize
 * routines.
 *
 * <h2>Initialization</h2>
 *
 * Send and receive channels are intialized separately. The receive channel is
 * initiailzed using XStrm_RxInitialize(). The send channel is initialized
 * using XStrm_TxInitialize().
 *
 *
 * <h2>Usage</h2>
 * It is fairly simple to use the API provided by this byte streamer
 * driver. The only somewhat tricky part is that the calling code must
 * correctly call a couple routines in the right sequence for receive and
 * transmit.
 *
 * 	This sequence is described here. Check the routine functional
 * descriptions for information on how to use a specific API routine.
 *
 * <h3>Receive</h3>
 * A frame is received by using the following sequence:<br>
 * 1) call XStrm_RxGetLen() to get the length of the next incoming frame.<br>
 * 2) call XStrm_Read() one or more times to read the number of bytes
 * 	   reported by XStrm_RxGetLen().<br>
 *
 * For example:
 * <pre>
 * 	frame_len = XStrm_RxGetLen(&RxInstance);
 * 	while (frame_len) {
 * 		unsigned bytes = min(sizeof(buffer), frame_len);
 * 		XStrm_Read(&RxInstance, buffer, bytes);
 * 		// do something with buffer here
 * 		frame_len -= bytes;
 * 	}
 * </pre>
 *
 * Other restrictions on the sequence of API calls may apply depending on
 * the specific FIFO driver used by this byte streamer driver.
 *
 * <h3>Transmit</h3>
 * A frame is transmittted by using the following sequence:<br>
 * 1) call XStrm_Write() one or more times to write all the of bytes in
 *    the next frame.<br>
 * 2) call XStrm_TxSetLen() to begin the transmission of frame just
 *    written.<br>
 *
 * For example:
 * <pre>
 * 	frame_left = frame_len;
 * 	while (frame_left) {
 * 		unsigned bytes = min(sizeof(buffer), frame_left);
 * 		XStrm_Write(&TxInstance, buffer, bytes);
 * 		// do something here to refill buffer
 * 	}
 * 	XStrm_TxSetLen(&RxInstance, frame_len);
 * </pre>
 *
 * Other restrictions on the sequence of API calls may apply depending on
 * the specific FIFO driver used by this byte streamer driver.
 *
 * <pre>
 * MODIFICATION HISTORY:
 *
 * Ver   Who  Date     Changes
 * ----- ---- -------- -------------------------------------------------------
 * 1.00a jvb  10/12/06 First release
 * 1.02a jz   12/04/09  Hal phase 1 support
 * 2.00a hbm  01/20/10  Hal phase 1 support, bump up major release
 * 2.02a asa  12/28/11  The macro XStrm_IsRxInternalEmpty is changed to use
 *			FrmByteCnt instead of HeadIndex.
 * </pre>
 *
 *****************************************************************************/
#ifndef XSTREAMER_H		/* prevent circular inclusions */
#define XSTREAMER_H		/* by using preprocessor symbols */

/* force C linkage */
#ifdef __cplusplus
extern "C" {
#endif

#include "xenv.h"
#include "xdebug.h"
#include "xil_types.h"

/*
 * key hole size in 32 bit words
 */
#define LARGEST_FIFO_KEYHOLE_SIZE_WORDS 4

/*
 * This union is used simply to force a 32bit alignment on the
 * buffer. Only the 'bytes' member is really used.
 */
union XStrm_AlignedBufferType {
	u32 _words[LARGEST_FIFO_KEYHOLE_SIZE_WORDS];
	char bytes[LARGEST_FIFO_KEYHOLE_SIZE_WORDS * 4];
};

typedef int(*XStrm_XferFnType) (void *FifoInstance, void *BufPtr,
                                    unsigned WordCount);
typedef u32 (*XStrm_GetLenFnType) (void *FifoInstance);
typedef void (*XStrm_SetLenFnType) (void *FifoInstance,
                                    u32 ByteCount);
typedef u32 (*XStrm_GetOccupancyFnType) (void *FifoInstance);
typedef u32 (*XStrm_GetVacancyFnType) (void *FifoInstance);

/**
 * This typedef defines a run-time instance of a receive byte-streamer.
 */
typedef struct XStrm_RxFifoStreamer {
	union XStrm_AlignedBufferType AlignedBuffer;
	unsigned HeadIndex;  /**< HeadIndex is the index to the AlignedBuffer
	                      *   as bytes.
                              */
	unsigned FifoWidth;  /**< FifoWidth is the FIFO key hole width in bytes.
	                      */
	unsigned FrmByteCnt; /**< FrmByteCnt is the number of bytes in the next
			      *   Frame.
			      */
	void *FifoInstance;  /**< FifoInstance is the FIFO driver instance to
	                      *   pass to ReadFn, GetLenFn, and GetOccupancyFn
	                      *   routines.
	                      */
	XStrm_XferFnType ReadFn;     /**< ReadFn is the routine the streamer
	                              *   uses to receive bytes from the Fifo.
	                              */
	XStrm_GetLenFnType GetLenFn; /**< GetLenFn is the routine the streamer
	                              *   uses to initiate receive operations
	                              *   on the FIFO.
                                      */
	XStrm_GetOccupancyFnType GetOccupancyFn; /**< GetOccupancyFn is the
	                                          *   routine the streamer uses
	                                          *   to get the occupancy from
	                                          *   the FIFO.
	                                          */
} XStrm_RxFifoStreamer;

/**
 * This typedef defines a run-time instance of a transmit byte-streamer.
 */
typedef struct XStrm_TxFifoStreamer {
	union XStrm_AlignedBufferType AlignedBuffer;
	unsigned TailIndex; /**< TailIndex is the index to the AlignedBuffer
	                     *   as bytes
                             */
	unsigned FifoWidth; /**< FifoWidth is the FIFO key hole width in bytes.
	                     */

	void *FifoInstance; /**< FifoInstance is the FIFO driver instance to
	                     *   pass to WriteFn, SetLenFn, and GetVacancyFn
	                     *   routines.
	                     */
	XStrm_XferFnType WriteFn; /**< WriteFn is the routine the streamer
	                           *   uses to transmit bytes to the Fifo.
	                           */
	XStrm_SetLenFnType SetLenFn; /**< SetLenFn is the routine the streamer
	                              *   uses to initiate transmit operations
	                              *   on the FIFO.
                                      */
	XStrm_GetVacancyFnType GetVacancyFn; /**< GetVaccancyFn is the routine
	                                      *   the streamer uses to get the
	                                      *   vacancy from the FIFO.
	                                      */
} XStrm_TxFifoStreamer;

/*****************************************************************************/
/*
*
* XStrm_TxVacancy returns the number of unused 32-bit words available (vacancy)
* between the streamer, specified by <i>InstancePtr</i>, and the FIFO this
* streamer is using.
*
* @param    InstancePtr references the streamer on which to operate.
*
* @return   XStrm_TxVacancy returns the vacancy count in number of 32 bit words.
*
* @note
*
* C Signature: u32 XStrm_TxVacancy(XStrm_TxFifoStreamer *InstancePtr)
*
* The amount of bytes in the holding buffer (rounded up to whole 32-bit words)
* is subtracted from the vacancy value of FIFO this streamer is using. This is
* to ensure the caller can write the number words given in the return value and
* not overflow the FIFO.
*
******************************************************************************/
#define XStrm_TxVacancy(InstancePtr) \
	(((*(InstancePtr)->GetVacancyFn)((InstancePtr)->FifoInstance)) - \
			(((InstancePtr)->TailIndex + 3) / 4))

/*****************************************************************************/
/*
*
* XStrm_RxOccupancy returns the number of 32-bit words available (occupancy) to
* be read from the streamer, specified by <i>InstancePtr</i>, and FIFO this
* steamer is using.
*
* @param    InstancePtr references the streamer on which to operate.
*
* @return   XStrm_RxOccupancy returns the occupancy count in number of 32 bit
*           words.
*
* @note
*
* C Signature: u32 XStrm_RxOccupancy(XStrm_RxFifoStreamer *InstancePtr)
*
* The amount of bytes in the holding buffer (rounded up to whole 32-bit words)
* is added to the occupancy value of FIFO this streamer is using. This is to
* ensure the caller will get a little more accurate occupancy value.
*
******************************************************************************/
#ifdef DEBUG
extern u32 _xstrm_ro_value;
extern u32 _xstrm_buffered;
#define XStrm_RxOccupancy(InstancePtr) \
        (_xstrm_ro_value = ((*(InstancePtr)->GetOccupancyFn)((InstancePtr)->FifoInstance)), \
	xdbg_printf(XDBG_DEBUG_FIFO_RX, "reg: %d; frmbytecnt: %d\n", \
		_xstrm_ro_value, (InstancePtr)->FrmByteCnt), \
	(((InstancePtr)->FrmByteCnt) ? \
		_xstrm_buffered = ((InstancePtr)->FifoWidth - (InstancePtr)->HeadIndex) : \
		0), \
	xdbg_printf(XDBG_DEBUG_FIFO_RX, "buffered_bytes: %d\n", _xstrm_buffered), \
	xdbg_printf(XDBG_DEBUG_FIFO_RX, "buffered (rounded): %d\n", _xstrm_buffered), \
	(_xstrm_ro_value + _xstrm_buffered))
#else
#define XStrm_RxOccupancy(InstancePtr) \
	( \
	  ((*(InstancePtr)->GetOccupancyFn)((InstancePtr)->FifoInstance)) + \
	  ( \
	    ((InstancePtr)->FrmByteCnt) ? \
	      ((InstancePtr)->FifoWidth - (InstancePtr)->HeadIndex) : \
	      0 \
	  ) \
	)
#endif

/****************************************************************************/
/*
*
* XStrm_IsRxInternalEmpty returns true if the streamer, specified by
* <i>InstancePtr</i>, is not holding any bytes in it's  internal buffers. Note
* that this routine does not reflect information about the state of the
* FIFO used by this streamer.
*
* @param    InstancePtr references the streamer on which to operate.
*
* @return   XStrm_IsRxInternalEmpty returns TRUE when the streamer is not
*           holding any bytes in it's internal buffers. Otherwise,
*           XStrm_IsRxInternalEmpty returns FALSE.
*
* @note
* C-style signature:
*    int XStrm_IsRxInternalEmpty(XStrm_RxFifoStreamer *InstancePtr)
*
*****************************************************************************/
#define XStrm_IsRxInternalEmpty(InstancePtr) \
	(((InstancePtr)->FrmByteCnt == 0) ? TRUE : FALSE)

void XStrm_RxInitialize(XStrm_RxFifoStreamer *InstancePtr,
                        unsigned FifoWidth, void *FifoInstance,
                        XStrm_XferFnType ReadFn,
                        XStrm_GetLenFnType GetLenFn,
                        XStrm_GetOccupancyFnType GetOccupancyFn);

void XStrm_TxInitialize(XStrm_TxFifoStreamer *InstancePtr,
                        unsigned FifoWidth, void *FifoInstance,
                        XStrm_XferFnType WriteFn,
                        XStrm_SetLenFnType SetLenFn,
                        XStrm_GetVacancyFnType GetVacancyFn);

void XStrm_TxSetLen(XStrm_TxFifoStreamer *InstancePtr, u32 Bytes);
void XStrm_Write(XStrm_TxFifoStreamer *InstancePtr, void *BufPtr,
                    unsigned bytes);

u32 XStrm_RxGetLen(XStrm_RxFifoStreamer *InstancePtr);
void XStrm_Read(XStrm_RxFifoStreamer *InstancePtr, void *BufPtr,
                   unsigned bytes);

#ifdef __cplusplus
}
#endif
#endif				/* XSTREAMER_H  end of preprocessor protection symbols */
