////////////////////////////////////////////////////////////////////////////////
// File   : wlan_mac_misc_util.h
// Authors: Patrick Murphy (murphpo [at] mangocomm.com)
//			Chris Hunter (chunter [at] mangocomm.com)
// License: Copyright 2013, Mango Communications. All rights reserved.
//          Distributed under the Mango Communications Reference Design License
//				See LICENSE.txt included in the design archive or
//				at http://mangocomm.com/802.11/license
////////////////////////////////////////////////////////////////////////////////

#ifndef WLAN_MAC_MISC_UTIL_H_
#define WLAN_MAC_MISC_UTIL_H_

typedef int (*function_ptr_t)();

#define max(A,B) (((A)>(B))?(A):(B))
#define min(A,B) (((A)<(B))?(A):(B))

#define PRINT_LEVEL PL_ERROR

#define PL_NONE		0
#define PL_ERROR 	1
#define PL_WARNING  2
#define PL_VERBOSE  3

#define warp_printf(severity,format,args...) \
	do { \
	 if(PRINT_LEVEL>=severity){xil_printf(format, ##args);} \
	} while(0)

#define wlan_addr_eq(addr1, addr2) (memcmp((void*)(addr1), (void*)(addr2), 6)==0)


typedef struct{
	u8 state;
	u8 rate;
	u16 length;
	u8 flags;
	u8 retry_count;
	u8 retry_max;
	u8 state_verbose;
	u16 AID;
	u16 reserved0;
	u32 reserved1;
	u64 tx_mpdu_accept_timestamp;
	u64 tx_mpdu_done_timestamp;
} tx_frame_info;


#define TX_MPDU_STATE_EMPTY			0
#define TX_MPDU_STATE_TX_PENDING	1
#define TX_MPDU_STATE_READY			2

#define TX_MPDU_STATE_VERBOSE_SUCCESS	0
#define TX_MPDU_STATE_VERBOSE_FAILURE	1

#define TX_MPDU_FLAGS_REQ_TO				0x01
#define TX_MPDU_FLAGS_FILL_TIMESTAMP		0x02
#define TX_MPDU_FLAGS_FILL_DURATION			0x04

//The rx_frame_info struct is padded to give space for the PHY to fill in channel estimates. The offset where
//the PHY fills in this information must be written to the wlan_phy_rx_pkt_buf_h_est_offset macro
typedef struct{
	u8 state;
	u8 rate;
	u16 length;
	char rx_power;
	u8 rf_gain;
	u8 bb_gain;
	u8 channel;
	u8 flags;
	u8 reserved[7];
	u32 channel_est[64];
} rx_frame_info;

#define RX_MPDU_FLAGS_ACKED		0x1
#define RX_MPDU_FLAGS_RETRY		0x2

#define RX_MPDU_STATE_EMPTY 	 	0
#define RX_MPDU_STATE_RX_PENDING	1
#define RX_MPDU_STATE_FCS_GOOD 	 	2
#define RX_MPDU_STATE_FCS_BAD 	 	3

#define CPU_STATUS_INITIALIZED			0x00000001
#define CPU_STATUS_WAIT_FOR_IPC_ACCEPT	0x00000002
#define CPU_STATUS_EXCEPTION			0x80000000

#define NUM_TX_PKT_BUFS	16
#define NUM_RX_PKT_BUFS	16

#define PKT_BUF_SIZE 4096

//Tx and Rx packet buffers
#define TX_PKT_BUF_TO_ADDR(n)	(XPAR_PKT_BUFF_TX_BRAM_CTRL_S_AXI_BASEADDR + (n)*PKT_BUF_SIZE)
#define RX_PKT_BUF_TO_ADDR(n)	(XPAR_PKT_BUFF_RX_BRAM_CTRL_S_AXI_BASEADDR + (n)*PKT_BUF_SIZE)

#define PHY_RX_PKT_BUF_PHY_HDR_OFFSET (sizeof(rx_frame_info))
#define PHY_TX_PKT_BUF_PHY_HDR_OFFSET (sizeof(tx_frame_info))

#define PHY_TX_PKT_BUF_PHY_HDR_SIZE 0x8

#define PHY_RX_PKT_BUF_MPDU_OFFSET (PHY_TX_PKT_BUF_PHY_HDR_SIZE+PHY_RX_PKT_BUF_PHY_HDR_OFFSET)
#define PHY_TX_PKT_BUF_MPDU_OFFSET (PHY_TX_PKT_BUF_PHY_HDR_SIZE+PHY_TX_PKT_BUF_PHY_HDR_OFFSET)

typedef struct{
	tx_frame_info frame_info;
	u8 phy_hdr_pad[PHY_TX_PKT_BUF_PHY_HDR_SIZE];
	u8 frame[PKT_BUF_SIZE - PHY_TX_PKT_BUF_PHY_HDR_SIZE - sizeof(tx_frame_info)];
} tx_packet_buffer;

#endif /* WLAN_MAC_MISC_UTIL_H_ */
