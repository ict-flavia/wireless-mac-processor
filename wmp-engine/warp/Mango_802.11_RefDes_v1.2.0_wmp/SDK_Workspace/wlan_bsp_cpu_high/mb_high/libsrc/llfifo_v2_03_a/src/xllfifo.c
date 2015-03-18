/**************************************************************
 * (c) Copyright 2005 - 2010 Xilinx, Inc. All rights reserved.
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
/**
 *
 * @file xllfifo.c
 *
 * The Xilinx local link FIFO driver component. This driver supports the
 * Xilinx xps_ll_fifo core.
 *
 * <pre>
 * MODIFICATION HISTORY:
 *
 * Ver   Who  Date     Changes
 * ----- ---- -------- -------------------------------------------------------
 * 1.00a jvb  10/13/06 First release
 * 1.00a xd   12/17/07 Added type casting to fix CR #456850
 * 1.02a jz   12/04/09  Hal phase 1 support
 * 2.00a hbm  01/20/10  Hal phase 1 support, bump up major release
 * 2.01a asa  09/17/10  Added code for resetting Streaming interface
 *		        for CR574868
 * </pre>
 ******************************************************************************/


/***************************** Include Files *********************************/

#include "xstatus.h"
#include "xllfifo.h"
#include "xil_assert.h"

/************************** Constant Definitions *****************************/
#define FIFO_WIDTH_BYTES 4

/*
 * Implementation Notes:
 *
 * This Fifo driver makes use of a byte streamer driver (xstreamer.h). The code
 * is structured like so:
 *
 * +--------------------+
 * |     llfifo        |
 * |   +----------------+
 * |   | +--------------+
 * |   | |  xstreamer   |
 * |   | +--------------+
 * |   +----------------+
 * |                    |
 * +--------------------+
 *
 * Initialization
 * At initialization time this driver (llfifo) sets up the streamer objects to
 * use routines in this driver (llfifo) to perform the actual I/O to the H/W
 * FIFO core.
 *
 * Operation
 * Once the streamer objects are set up, the API routines in this driver, just
 * call through to the streamer driver to perform the read/write operations.
 * The streamer driver will eventually make calls back into the routines (which
 * reside in this driver) given at initialization to peform the actual I/O.
 *
 * Interrupts
 * Interrupts are handled in the OS/Application layer above this driver.
 */

xdbg_stmnt(u32 _xllfifo_rr_value;)
xdbg_stmnt(u32 _xllfifo_ipie_value;)
xdbg_stmnt(u32 _xllfifo_ipis_value;)

/****************************************************************************/
/*
*
* XLlFifo_RxGetWord reads one 32 bit word from the FIFO specified by
* <i>InstancePtr</i>.
*
* XLlFifo_RxGetLen or XLlFifo_iRxGetLen must be called before calling
* XLlFifo_RxGetWord. Otherwise, the hardware will raise an <i>Over Read
* Exception</i>.
*
* @param    InstancePtr references the FIFO on which to operate.
*
* @return   XLlFifo_RxGetWord returns the 32 bit word read from the FIFO.
*
* @note
* C-style signature:
*    u32 XLlFifo_RxGetWord(XLlFifo *InstancePtr)
*
*****************************************************************************/
#define XLlFifo_RxGetWord(InstancePtr) \
	XLlFifo_ReadReg((InstancePtr)->BaseAddress, XLLF_RDFD_OFFSET)

/****************************************************************************/
/*
*
* XLlFifo_TxPutWord writes the 32 bit word, <i>Word</i> to the FIFO specified by
* <i>InstancePtr</i>.
*
* @param    InstancePtr references the FIFO on which to operate.
*
* @return   N/A
*
* @note
* C-style signature:
*    void XLlFifo_TxPutWord(XLlFifo *InstancePtr, u32 Word)
*
*****************************************************************************/
#define XLlFifo_TxPutWord(InstancePtr, Word) \
	XLlFifo_WriteReg((InstancePtr)->BaseAddress, XLLF_TDFD_OFFSET, \
			(Word))

/*****************************************************************************/
/*
*
* XLlFifo_iRxOccupancy returns the number of 32-bit words available (occupancy)
* to be read from the receive channel of the FIFO, specified by
* <i>InstancePtr</i>.
*
* @param    InstancePtr references the FIFO on which to operate.
*
* @return   XLlFifo_iRxOccupancy returns the occupancy count in 32-bit words for
*           the specified FIFO.
*
******************************************************************************/
static u32 XLlFifo_iRxOccupancy(XLlFifo *InstancePtr)
{
	Xil_AssertNonvoid(InstancePtr);

	return XLlFifo_ReadReg(InstancePtr->BaseAddress,
			XLLF_RDFO_OFFSET);
}

/*****************************************************************************/
/*
*
* XLlFifo_iRxGetLen notifies the hardware that the program is ready to receive the
* next frame from the receive channel of the FIFO specified by <i>InstancePtr</i>.
*
* Note that the program must first call XLlFifo_iRxGetLen before pulling data
* out of the receive channel of the FIFO with XLlFifo_Read.
*
* @param    InstancePtr references the FIFO on which to operate.
*
* @return   XLlFifo_iRxGetLen returns the number of bytes available in the next
*           frame.
*
******************************************************************************/
static u32 XLlFifo_iRxGetLen(XLlFifo *InstancePtr)
{
	Xil_AssertNonvoid(InstancePtr);

	return XLlFifo_ReadReg(InstancePtr->BaseAddress,
		XLLF_RLF_OFFSET);
}

/*****************************************************************************/
/*
*
* XLlFifo_iRead_Aligned reads, <i>WordCount</i>, words from the FIFO referenced by
* <i>InstancePtr</i> to the block of memory, referenced by <i>BufPtr</i>.
*
* XLlFifo_iRead_Aligned assumes that <i>BufPtr</i> is already aligned according
* to the following hardware limitations:
*    ppc        - aligned on 32 bit boundaries to avoid performance penalties
*                 from unaligned exception handling.
*    microblaze - aligned on 32 bit boundaries as microblaze does not handle
*                 unaligned transfers.
*
* Care must be taken to ensure that the number of words read with one or more
* calls to XLlFifo_Read() does not exceed the number of bytes (rounded up to
* the nearest whole 32 bit word) available given from the last call to
* XLlFifo_RxGetLen().
*
* @param    InstancePtr references the FIFO on which to operate.
*
* @param    BufPtr specifies the memory address to place the data read.
*
* @param    WordCount specifies the number of 32 bit words to read.
*
* @return   XLlFifo_iRead_Aligned always returns XST_SUCCESS. Error handling is
*           otherwise handled through hardware exceptions and interrupts.
*
* @note
*
* C Signature: int XLlFifo_iRead_Aligned(XLlFifo *InstancePtr,
*                      void *BufPtr, unsigned WordCount);
*
******************************************************************************/
/* static */ int XLlFifo_iRead_Aligned(XLlFifo *InstancePtr, void *BufPtr,
			     unsigned WordCount)
{
	unsigned WordsRemaining = WordCount;
	u32 *BufPtrIdx = (u32 *)BufPtr;

	xdbg_printf(XDBG_DEBUG_FIFO_RX, "XLlFifo_iRead_Aligned: start\n");
	Xil_AssertNonvoid(InstancePtr);
	Xil_AssertNonvoid(BufPtr);
	/* assert bufer is 32 bit aligned */
	Xil_AssertNonvoid(((unsigned)BufPtr & 0x3) == 0x0);
	xdbg_printf(XDBG_DEBUG_FIFO_RX, "XLlFifo_iRead_Aligned: after asserts\n");

	while (WordsRemaining) {
/*		xdbg_printf(XDBG_DEBUG_FIFO_RX,
			    "XLlFifo_iRead_Aligned: WordsRemaining: %d\n",
			    WordsRemaining);
*/
		*BufPtrIdx = XLlFifo_RxGetWord(InstancePtr);
		BufPtrIdx++;
		WordsRemaining--;
	}
	xdbg_printf(XDBG_DEBUG_FIFO_RX,
		    "XLlFifo_iRead_Aligned: returning SUCCESS\n");
	return XST_SUCCESS;
}

/****************************************************************************/
/*
*
* XLlFifo_iTxVacancy returns the number of unused 32 bit words available
* (vacancy) in the send channel of the FIFO, specified by <i>InstancePtr</i>.
*
* @param    InstancePtr references the FIFO on which to operate.
*
* @return   XLlFifo_iTxVacancy returns the vacancy count in 32-bit words for
*           the specified FIFO.
*
*****************************************************************************/
static u32 XLlFifo_iTxVacancy(XLlFifo *InstancePtr)
{
	Xil_AssertNonvoid(InstancePtr);

	return XLlFifo_ReadReg(InstancePtr->BaseAddress,
			XLLF_TDFV_OFFSET);
}

/*****************************************************************************/
/*
*
* XLlFifo_iTxSetLen begins a hardware transfer of data out of the transmit
* channel of the FIFO, specified by <i>InstancePtr</i>. <i>Bytes</i> specifies the number
* of bytes in the frame to transmit.
*
* Note that <i>Bytes</i> (rounded up to the nearest whole 32 bit word) must be same
* number of words just written using one or more calls to
* XLlFifo_iWrite_Aligned()
*
* @param    InstancePtr references the FIFO on which to operate.
*
* @param    Bytes specifies the number of bytes to transmit.
*
* @return   N/A
*
******************************************************************************/
static void XLlFifo_iTxSetLen(XLlFifo *InstancePtr, u32 Bytes)
{
	Xil_AssertVoid(InstancePtr);

	XLlFifo_WriteReg(InstancePtr->BaseAddress, XLLF_TLF_OFFSET,
			Bytes);
}

/*****************************************************************************/
/*
*
* XLlFifo_iWrite_Aligned writes, <i>WordCount</i>, words to the FIFO referenced by
* <i>InstancePtr</i> from the block of memory, referenced by <i>BufPtr</i>.
*
* XLlFifo_iWrite_Aligned assumes that <i>BufPtr</i> is already aligned according
* to the following hardware limitations:
*    ppc        - aligned on 32 bit boundaries to avoid performance penalties
*                 from unaligned exception handling.
*    microblaze - aligned on 32 bit boundaries as microblaze does not handle
*                 unaligned transfers.
*
* Care must be taken to ensure that the number of words written with one or
* more calls to XLlFifo_iWrite_Aligned() matches the number of bytes (rounded up
* to the nearest whole 32 bit word) given in the next call to
* XLlFifo_iTxSetLen().
*
* @param    InstancePtr references the FIFO on which to operate.
*
* @param    BufPtr specifies the memory address to place the data read.
*
* @param    WordCount specifies the number of 32 bit words to read.
*
* @return   XLlFifo_iWrite_Aligned always returns XST_SUCCESS. Error handling is
*           otherwise handled through hardware exceptions and interrupts.
*
* @note
*
* C Signature: int XLlFifo_iWrite_Aligned(XLlFifo *InstancePtr,
*                      void *BufPtr, unsigned WordCount);
*
******************************************************************************/
/* static */ int XLlFifo_iWrite_Aligned(XLlFifo *InstancePtr, void *BufPtr,
			      unsigned WordCount)
{
	unsigned WordsRemaining = WordCount;
	u32 *BufPtrIdx = (u32 *)BufPtr;

	xdbg_printf(XDBG_DEBUG_FIFO_TX,
		    "XLlFifo_iWrite_Aligned: Inst: %p; Buff: %p; Count: %d\n",
		    InstancePtr, BufPtr, WordCount);
	Xil_AssertNonvoid(InstancePtr);
	Xil_AssertNonvoid(BufPtr);
	/* assert bufer is 32 bit aligned */
	Xil_AssertNonvoid(((unsigned)BufPtr & 0x3) == 0x0);

	xdbg_printf(XDBG_DEBUG_FIFO_TX,
		    "XLlFifo_iWrite_Aligned: WordsRemaining: %d\n",
		    WordsRemaining);
	while (WordsRemaining) {
		XLlFifo_TxPutWord(InstancePtr, *BufPtrIdx);
		BufPtrIdx++;
		WordsRemaining--;
	}

	xdbg_printf(XDBG_DEBUG_FIFO_TX,
		    "XLlFifo_iWrite_Aligned: returning SUCCESS\n");
	return XST_SUCCESS;
}

/*****************************************************************************/
/**
*
* XLlFifo_Initialize initializes an XPS_ll_Fifo device along with the
* <i>InstancePtr</i> that references it.
*
* @param    InstancePtr references the memory instance to be associated with
*           the FIFO device upon initialization.
*
* @param    BaseAddress is the processor address used to access the
*           base address of the Fifo device.
*
* @return   N/A
*
******************************************************************************/
void XLlFifo_Initialize(XLlFifo *InstancePtr, u32 BaseAddress)
{
	Xil_AssertVoid(InstancePtr);
	Xil_AssertVoid(BaseAddress);

	/* Clear instance memory */
	memset(InstancePtr, 0, sizeof(XLlFifo));

	/*
	 * We don't care about the physical base address, just copy the
	 * processor address over it.
	 */
	InstancePtr->BaseAddress = BaseAddress;

	InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

	XLlFifo_TxReset(InstancePtr);
	XLlFifo_RxReset(InstancePtr);

	/*
	 * Reset the core and generate the external reset by writing to
	 * the Local Link/AXI Streaming Reset Register.
	 */
	XLlFifo_WriteReg((InstancePtr)->BaseAddress, XLLF_LLR_OFFSET,
				XLLF_RDFR_RESET_MASK);

	XStrm_RxInitialize(&(InstancePtr->RxStreamer), FIFO_WIDTH_BYTES,
			(void *)InstancePtr,
			(XStrm_XferFnType)XLlFifo_iRead_Aligned,
			(XStrm_GetLenFnType)XLlFifo_iRxGetLen,
			(XStrm_GetOccupancyFnType)XLlFifo_iRxOccupancy);

	XStrm_TxInitialize(&(InstancePtr->TxStreamer), FIFO_WIDTH_BYTES,
			(void *)InstancePtr,
			(XStrm_XferFnType)XLlFifo_iWrite_Aligned,
			(XStrm_SetLenFnType)XLlFifo_iTxSetLen,
			(XStrm_GetVacancyFnType)XLlFifo_iTxVacancy);
}

