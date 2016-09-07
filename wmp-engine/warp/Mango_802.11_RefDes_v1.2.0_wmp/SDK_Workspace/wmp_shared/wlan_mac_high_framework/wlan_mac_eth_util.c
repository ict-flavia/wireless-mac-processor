////////////////////////////////////////////////////////////////////////////////
// File   : wlan_mac_eth_util.c
// Authors: Patrick Murphy (murphpo [at] mangocomm.com)
//			Chris Hunter (chunter [at] mangocomm.com)
// License: Copyright 2013, Mango Communications. All rights reserved.
//          Distributed under the Mango Communications Reference Design License
//				See LICENSE.txt included in the design archive or
//				at http://mangocomm.com/802.11/license
////////////////////////////////////////////////////////////////////////////////

#include "xaxiethernet.h"
#include "xaxidma.h"
#include "xparameters.h"
#include "xintc.h"
#include "wlan_mac_ipc_util.h"
#include "wlan_mac_misc_util.h"
#include "wlan_mac_802_11_defs.h"
#include "wlan_mac_util.h"
#include "wlan_mac_packet_types.h"
#include "wlan_mac_queue.h"
#include "wlan_mac_eth_util.h"

#include "wlan_mac_queue.h"

/* WMP_START */
#include "wmp_high_util.h"
/* WMP_END */

//Global variable for instance of the axi_dma driver, scoped to this file only
static XAxiDma ETH_A_DMA_Instance;

//Top-level code defines the callback, wlan_mac_util does the actual calling
// It's sufficient to refer to the wlan_mac_util callback by name here
extern function_ptr_t eth_rx_callback;
extern u8 eth_encap_mode;

static XIntc* Intc_ptr;

u32 ETH_A_NUM_RX_BD;

#define RX_INTR_ID		XPAR_INTC_0_AXIDMA_0_S2MM_INTROUT_VEC_ID
#define TX_INTR_ID		XPAR_INTC_0_AXIDMA_0_MM2S_INTROUT_VEC_ID


//The station code's implementation of encapsulation and de-encapsulation has an important
//limitation: only one device may be plugged into the station's Ethernet port. The station
//does not provide NAT. It assumes that the last received Ethernet src MAC address is used
//as the destination MAC address on any Ethernet transmissions. This is fine when there is
//only one device on the station's Ethernet port, but will definitely not work if the station
//is plugged into a switch with more than one device.
u8 eth_sta_mac_addr[6];

extern wlan_mac_hw_info   	hw_info;


int wlan_eth_init() {
		int status;

		ETH_A_NUM_RX_BD = min(queue_total_size()/2,200);
		xil_printf("Setting up %d DMA BDs\n", ETH_A_NUM_RX_BD);

		//The TEMAC driver is only used during init - all packet interactions are handed via the DMA driver
		XAxiEthernet_Config *ETH_A_MAC_CFG_ptr;
		XAxiEthernet ETH_A_MAC_Instance;

		ETH_A_MAC_CFG_ptr = XAxiEthernet_LookupConfig(ETH_A_MAC_DEVICE_ID);
		status = XAxiEthernet_CfgInitialize(&ETH_A_MAC_Instance, ETH_A_MAC_CFG_ptr, ETH_A_MAC_CFG_ptr->BaseAddress);
		if (status != XST_SUCCESS) {xil_printf("Error in XAxiEthernet_CfgInitialize! Err = %d\n", status); return -1;};

		//Setup the TEMAC options
		status  = XAxiEthernet_ClearOptions(&ETH_A_MAC_Instance, XAE_LENTYPE_ERR_OPTION | XAE_FLOW_CONTROL_OPTION | XAE_JUMBO_OPTION);
		status |= XAxiEthernet_SetOptions(&ETH_A_MAC_Instance, XAE_FCS_STRIP_OPTION | XAE_PROMISC_OPTION | XAE_MULTICAST_OPTION | XAE_BROADCAST_OPTION | XAE_FCS_INSERT_OPTION);
		status |= XAxiEthernet_SetOptions(&ETH_A_MAC_Instance, XAE_RECEIVER_ENABLE_OPTION | XAE_TRANSMITTER_ENABLE_OPTION);
		if (status != XST_SUCCESS) {xil_printf("Error in XAxiEthernet_Set/ClearOptions! Err = %d\n", status); return -1;};

		XAxiEthernet_SetOperatingSpeed(&ETH_A_MAC_Instance, ETH_A_LINK_SPEED);

		//Initialize the axi_dma attached to the TEMAC
		status = wlan_eth_dma_init();

		XAxiEthernet_Start(&ETH_A_MAC_Instance);

		return 0;
}

int eth_bd_total_size(){
	return ETH_A_NUM_RX_BD;
}

int wlan_eth_setup_interrupt(XIntc* intc){
	Intc_ptr = intc;
	XAxiDma_BdRing *RxRingPtr = XAxiDma_GetRxRing(&ETH_A_DMA_Instance);
	int Status;

	Status = XIntc_Connect(Intc_ptr, RX_INTR_ID,(XInterruptHandler) RxIntrHandler, RxRingPtr);
	if (Status != XST_SUCCESS) {

		xil_printf("Failed tx connect intc\r\n");
		return XST_FAILURE;
	}

	XIntc_Enable(Intc_ptr, RX_INTR_ID);



	return 0;
}

void RxIntrHandler(void *Callback){
	XAxiDma_BdRing *RxRingPtr = (XAxiDma_BdRing *) Callback;
	u32 IrqStatus;

	XIntc_Stop(Intc_ptr);

	IrqStatus = XAxiDma_BdRingGetIrq(RxRingPtr);
	XAxiDma_BdRingAckIrq(RxRingPtr, IrqStatus);

	if ((IrqStatus & (XAXIDMA_IRQ_DELAY_MASK | XAXIDMA_IRQ_IOC_MASK))) {
		wlan_poll_eth();
	}

	XIntc_Start(Intc_ptr, XIN_REAL_MODE);

	return;
}
int wlan_eth_dma_init() {
	int status;
	int bd_count;
	int i;
	u32 buf_addr;

	XAxiDma_Config *ETH_A_DMA_CFG_ptr;

	XAxiDma_Bd ETH_DMA_BD_Template;
	XAxiDma_BdRing *ETH_A_TxRing_ptr;
	XAxiDma_BdRing *ETH_A_RxRing_ptr;

	XAxiDma_Bd *first_bd_ptr;
	XAxiDma_Bd *cur_bd_ptr;

	packet_bd_list checkout;
	packet_bd*	tx_queue;

	ETH_A_DMA_CFG_ptr = XAxiDma_LookupConfig(ETH_A_DMA_DEV_ID);
	status = XAxiDma_CfgInitialize(&ETH_A_DMA_Instance, ETH_A_DMA_CFG_ptr);
	if(status != XST_SUCCESS) {xil_printf("Error in XAxiDma_CfgInitialize! Err = %d\n", status); return -1;}

	//Zero-out the template buffer descriptor
	XAxiDma_BdClear(&ETH_DMA_BD_Template);

	//Fetch handles to the Tx and Rx BD rings
	ETH_A_TxRing_ptr = XAxiDma_GetTxRing(&ETH_A_DMA_Instance);
	ETH_A_RxRing_ptr = XAxiDma_GetRxRing(&ETH_A_DMA_Instance);

	//Disable all Tx/Rx DMA interrupts
	XAxiDma_BdRingIntDisable(ETH_A_TxRing_ptr, XAXIDMA_IRQ_ALL_MASK);
	XAxiDma_BdRingIntDisable(ETH_A_RxRing_ptr, XAXIDMA_IRQ_ALL_MASK);

	//Disable delays and coalescing (for now - these will be useful when we transition to interrupts)
	XAxiDma_BdRingSetCoalesce(ETH_A_TxRing_ptr, 1, 0);
	XAxiDma_BdRingSetCoalesce(ETH_A_RxRing_ptr, 1, 0);

	//Setup Tx/Rx buffer descriptor rings in memory
	status =  XAxiDma_BdRingCreate(ETH_A_TxRing_ptr, ETH_A_TX_BD_SPACE_BASE, ETH_A_TX_BD_SPACE_BASE, XAXIDMA_BD_MINIMUM_ALIGNMENT, ETH_A_NUM_TX_BD);
	status |= XAxiDma_BdRingCreate(ETH_A_RxRing_ptr, ETH_A_RX_BD_SPACE_BASE, ETH_A_RX_BD_SPACE_BASE, XAXIDMA_BD_MINIMUM_ALIGNMENT, ETH_A_NUM_RX_BD);
	if(status != XST_SUCCESS) {xil_printf("Error creating DMA BD Rings! Err = %d\n", status); return -1;}

	//Populate each ring with empty buffer descriptors
	status =  XAxiDma_BdRingClone(ETH_A_TxRing_ptr, &ETH_DMA_BD_Template);
	status |= XAxiDma_BdRingClone(ETH_A_RxRing_ptr, &ETH_DMA_BD_Template);
	if(status != XST_SUCCESS) {xil_printf("Error in XAxiDma_BdRingClone()! Err = %d\n", status); return -1;}

	//Start the DMA Tx channel
	// No Eth packets are transmitted until actual Tx BD's are pushed to the DMA hardware
	status = XAxiDma_BdRingStart(ETH_A_TxRing_ptr);

	//Initialize the Rx buffer descriptors
	bd_count = XAxiDma_BdRingGetFreeCnt(ETH_A_RxRing_ptr);
	if(bd_count != ETH_A_NUM_RX_BD) {xil_printf("Error in Eth Rx DMA init - not all Rx BDs were free at boot\n");}

	status = XAxiDma_BdRingAlloc(ETH_A_RxRing_ptr, bd_count, &first_bd_ptr);
	if(status != XST_SUCCESS) {xil_printf("Error in XAxiDma_BdRingAlloc()! Err = %d\n", status); return -1;}

	//Checkout ETH_A_NUM_RX_BD packet_bds
	queue_checkout(&checkout, ETH_A_NUM_RX_BD);

	if(checkout.length == ETH_A_NUM_RX_BD){
		tx_queue = checkout.first;
	} else {
		xil_printf("Error during wlan_eth_dma_init: able to check out %d of %d packet_bds\n", checkout.length, ETH_A_NUM_RX_BD);
		return -1;
	}

	//Iterate over each Rx buffer descriptor
	cur_bd_ptr = first_bd_ptr;
	for(i = 0; i < bd_count; i++) {
		//Set the memory address for this BD's buffer
		buf_addr = (u32)((void*)((tx_packet_buffer*)(tx_queue->buf_ptr))->frame + sizeof(mac_header_80211) + sizeof(llc_header) - sizeof(ethernet_header));

		status = XAxiDma_BdSetBufAddr(cur_bd_ptr, buf_addr);
		if(status != XST_SUCCESS) {xil_printf("XAxiDma_BdSetBufAddr failed (bd %d, addr 0x08x)! Err = %d\n", i, buf_addr, status); return -1;}

		//Set every Rx BD to max length (this assures 1 BD per Rx pkt)
		status = XAxiDma_BdSetLength(cur_bd_ptr, ETH_A_PKT_BUF_SIZE, ETH_A_RxRing_ptr->MaxTransferLen);
		if(status != XST_SUCCESS) {xil_printf("XAxiDma_BdSetLength failed (bd %d, addr 0x08x)! Err = %d\n", i, buf_addr, status); return -1;}

		//Rx BD's don't need control flags before use; DMA populates these post-Rx
		XAxiDma_BdSetCtrl(cur_bd_ptr, 0);

		//BD ID is arbitrary; use pointer to the packet_bd associated with this BD
		XAxiDma_BdSetId(cur_bd_ptr, (u32)tx_queue);

		//Update cur_bd_ptr to the next BD in the chain for the next iteration
		cur_bd_ptr = XAxiDma_BdRingNext(ETH_A_RxRing_ptr, cur_bd_ptr);

		//Traverse forward in the checked-out packet_bd list
		tx_queue = tx_queue->next;
	}

	//Push the Rx BD ring to hardware and start receiving
	status = XAxiDma_BdRingToHw(ETH_A_RxRing_ptr, bd_count, first_bd_ptr);

	//Enable Interrupts
	XAxiDma_BdRingIntEnable(ETH_A_RxRing_ptr, XAXIDMA_IRQ_ALL_MASK);

	status |= XAxiDma_BdRingStart(ETH_A_RxRing_ptr);
	if(status != XST_SUCCESS) {xil_printf("Error in XAxiDma_BdRingToHw/XAxiDma_BdRingStart(ETH_A_RxRing_ptr)! Err = %d\n", status); return -1;}

	return 0;
}


//De-encapsulate packet and send over Ethernet
int wlan_mpdu_eth_send(void* mpdu, u16 length){
	int status;

	u8* eth_mid_ptr;

	mac_header_80211* rx80211_hdr;
	llc_header* llc_hdr;
	ethernet_header* eth_hdr;

	u8 continue_loop;
	ipv4_header* ip_hdr;
	arp_packet* arp;
	udp_header* udp;
	dhcp_packet* dhcp;

	u8 addr_cache[6];

	switch(eth_encap_mode){
		case ENCAP_MODE_AP:
			rx80211_hdr = (mac_header_80211*)((void *)mpdu);
			llc_hdr = (llc_header*)((void *)mpdu + sizeof(mac_header_80211));
			eth_hdr = (ethernet_header*)((void *)mpdu + sizeof(mac_header_80211) + sizeof(llc_header) - sizeof(ethernet_header));

			length = length - sizeof(mac_header_80211) - sizeof(llc_header) + sizeof(ethernet_header);

			memmove(eth_hdr->address_destination, rx80211_hdr->address_3, 6);
			memmove(eth_hdr->address_source, rx80211_hdr->address_2, 6);

			switch(llc_hdr->type){
				case LLC_TYPE_ARP:
					//xil_printf("Sending ARP\n");
					eth_hdr->type = ETH_TYPE_ARP;
				break;

				case LLC_TYPE_IP:
					//xil_printf("Sending IP\n");
					eth_hdr->type = ETH_TYPE_IP;
				break;
				default:
					//Invalid or unsupported Eth type; punt
					return -1;
				break;
			}
		break;

		case ENCAP_MODE_STA:
			rx80211_hdr = (mac_header_80211*)((void *)mpdu);
			llc_hdr = (llc_header*)((void *)mpdu + sizeof(mac_header_80211));
			eth_hdr = (ethernet_header*)((void *)mpdu + sizeof(mac_header_80211) + sizeof(llc_header) - sizeof(ethernet_header));

			length = length - sizeof(mac_header_80211) - sizeof(llc_header) + sizeof(ethernet_header);

			if(wlan_addr_eq(rx80211_hdr->address_3, hw_info.hw_addr_wlan)){
				//This case handles the behavior of an AP reflecting a station-sent broadcast packet back out over the air.
				//Without this filtering, a station would see its own packet. This leads to very bad DHCP and ARP behavior.
				return -1;
			}

			///DEBUG



			memcpy(addr_cache,rx80211_hdr->address_3,6);

			if(wlan_addr_eq(rx80211_hdr->address_1,hw_info.hw_addr_wlan)){
				memcpy(eth_hdr->address_destination, eth_sta_mac_addr, 6);
			} else {
				memmove(eth_hdr->address_destination, rx80211_hdr->address_1, 6);
			}
			//memmove(eth_hdr->address_source, rx80211_hdr->address_3, 6);
			memcpy(eth_hdr->address_source, addr_cache,6);




			switch(llc_hdr->type){
				case LLC_TYPE_ARP:
					arp = (arp_packet*)((void*)eth_hdr + sizeof(ethernet_header));

					//	Here we hijack ARP messages and overwrite their source MAC address field with
					//	the Ethernet-connected client's MAC address

					if(wlan_addr_eq(arp->eth_dst,hw_info.hw_addr_wlan)){
						memcpy(arp->eth_dst, eth_sta_mac_addr, 6);
					}

					eth_hdr->type = ETH_TYPE_ARP;
				break;

				case ETH_TYPE_IP:
					eth_hdr->type = ETH_TYPE_IP;
					ip_hdr = (ipv4_header*)((void*)eth_hdr + sizeof(ethernet_header));

					if(ip_hdr->prot == IPV4_PROT_UDP){
						udp = (udp_header*)((void*)ip_hdr + 4*((u8)(ip_hdr->ver_ihl) & 0xF));
						udp->checksum = 0; //Disable the checksum since we are about to mess with the bytes in the packet

						if(Xil_Ntohs(udp->src_port) == UDP_SRC_PORT_BOOTPC || Xil_Ntohs(udp->src_port) == UDP_SRC_PORT_BOOTPS){
							//This is a DHCP Discover packet, which contains the source hardware address
							//deep inside the packet (in addition to its usual location in the Eth header).
							//For STA encapsulation, we need to overwrite this address with the MAC addr
							//of the wireless station.

							dhcp = (dhcp_packet*)((void*)udp + sizeof(udp_header));

							if(Xil_Ntohl(dhcp->magic_cookie) == DHCP_MAGIC_COOKIE){

									eth_mid_ptr = (u8*)((void*)dhcp + sizeof(dhcp_packet));

									//Tagged DHCP Options
									continue_loop = 1;

									while(continue_loop){
										switch(eth_mid_ptr[0]){

											case DHCP_OPTION_TAG_TYPE:
												switch(eth_mid_ptr[2]){
													case DHCP_OPTION_TYPE_DISCOVER:
													case DHCP_OPTION_TYPE_REQUEST:
														//memcpy(dhcp->chaddr,hw_info.hw_addr_wlan,6);
													break;

													case DHCP_OPTION_TYPE_ACK:
													break;

													case DHCP_OPTION_TYPE_OFFER:

													break;

												}

											break;

											case DHCP_OPTION_TAG_IDENTIFIER:
											//	memcpy(&(eth_mid_ptr[3]),eth_sta_mac_addr,6);

											break;


											case DHCP_OPTION_END:
												continue_loop = 0;
											break;
										}
										eth_mid_ptr += (2+eth_mid_ptr[1]);
									}
							//	}


							}
						}
					}

				break;
				default:
					//Invalid or unsupported Eth type; punt
					return -1;
				break;
			}
		break;
	}

	status = wlan_eth_dma_send((u8*)eth_hdr, length);
	if(status != 0) {xil_printf("Erroor in wlan_mac_send_eth! Err = %d\n", status); return -1;}

	return 0;
}

int wlan_eth_dma_send(u8* pkt_ptr, u32 length) {
	int status;
	XAxiDma_BdRing *txRing_ptr;
	XAxiDma_Bd *cur_bd_ptr;

	//Flush the data cache of the pkt buffer
	// Comment this back in if the dcache is enabled
	//Xil_DCacheFlushRange((u32)TxPacket, MAX_PKT_LEN);

	txRing_ptr = XAxiDma_GetTxRing(&ETH_A_DMA_Instance);

	status = XAxiDma_BdRingAlloc(txRing_ptr, 1, &cur_bd_ptr);
	status |= XAxiDma_BdSetBufAddr(cur_bd_ptr, (u32)pkt_ptr);
	status |= XAxiDma_BdSetLength(cur_bd_ptr, length, txRing_ptr->MaxTransferLen);
	if(status != XST_SUCCESS) {xil_printf("Error in setting ETH Tx BD! Err = %d\n", status); return -1;}

	//When using 1 BD for 1 pkt set both SOF and EOF
	XAxiDma_BdSetCtrl(cur_bd_ptr, (XAXIDMA_BD_CTRL_TXSOF_MASK | XAXIDMA_BD_CTRL_TXEOF_MASK) );

	//Set arbitrary ID
	XAxiDma_BdSetId(cur_bd_ptr, (u32)pkt_ptr);

	//Push the BD ring to hardware; this initiates the actual DMA transfer and Ethernet Tx
	status = XAxiDma_BdRingToHw(txRing_ptr, 1, cur_bd_ptr);
	if(status != XST_SUCCESS) {xil_printf("Error in XAxiDma_BdRingToHw(txRing_ptr)! Err = %d\n", status); return -1;}

	//Wait for this DMA transfer to finish (will be replaced by post-Tx ISR)
	while (XAxiDma_BdRingFromHw(txRing_ptr, 1, &cur_bd_ptr) == 0) {/*Do Nothing*/}
	status = XAxiDma_BdRingFree(txRing_ptr, 1, cur_bd_ptr);
	if(status != XST_SUCCESS) {xil_printf("Error in XAxiDma_BdRingFree(txRing_ptr, 1)! Err = %d\n", status); return -1;}

	return 0;
}

void wlan_poll_eth() {
	XAxiDma_BdRing *rxRing_ptr;
	XAxiDma_Bd *cur_bd_ptr;
	XAxiDma_Bd *first_bd_ptr;
	u8* mpdu_start_ptr;
	u8* eth_start_ptr;
	u8* eth_mid_ptr;
	packet_bd* tx_queue;
	u32 eth_rx_len, eth_rx_buf;
	u32 mpdu_tx_len;
	packet_bd_list tx_queue_list;
	u32 i;
	u8 continue_loop;

	int bd_count;
	int status;
	int packet_is_queued;

	ethernet_header* eth_hdr;
	ipv4_header* ip_hdr;
	arp_packet* arp;
	udp_header* udp;
	dhcp_packet* dhcp;

	llc_header* llc_hdr;
	u8 eth_dest[6];
	u8 eth_src[6];

	static u32 max_bd_count = 0;

	rxRing_ptr = XAxiDma_GetRxRing(&ETH_A_DMA_Instance);

	//Check if any Rx BDs have been executed
	//TODO: process XAXIDMA_ALL_BDS instead of 1 at a time
	//bd_count = XAxiDma_BdRingFromHw(rxRing_ptr, 1, &cur_bd_ptr);
	bd_count = XAxiDma_BdRingFromHw(rxRing_ptr, XAXIDMA_ALL_BDS, &first_bd_ptr);
	cur_bd_ptr = first_bd_ptr;

	if(bd_count > max_bd_count){
		max_bd_count = bd_count;
		//xil_printf("max_bd_count = %d\n",max_bd_count);
	}

	if(bd_count == 0) {
		//No Rx BDs have been processed - no new Eth receptions waiting
		return;
	}

	for(i=0;i<bd_count;i++){

		//A packet has been received and transferred by DMA
		tx_queue = (packet_bd*)XAxiDma_BdGetId(cur_bd_ptr);

		//xil_printf("DMA has filled in packet_bd at 0x%08x\n", tx_queue);

		eth_rx_len = XAxiDma_BdGetActualLength(cur_bd_ptr, rxRing_ptr->MaxTransferLen);
		eth_rx_buf = XAxiDma_BdGetBufAddr(cur_bd_ptr);

		//After encapsulation, byte[0] of the MPDU will be at byte[0] of the queue entry frame buffer
		mpdu_start_ptr = (void*)((tx_packet_buffer*)(tx_queue->buf_ptr))->frame;

		eth_start_ptr = (u8*)eth_rx_buf;

		//Calculate actual wireless Tx len (eth payload - eth header + wireless header)
		mpdu_tx_len = eth_rx_len - sizeof(ethernet_header) + sizeof(llc_header) + sizeof(mac_header_80211);

		//Helper pointers to interpret/fill fields in the new MPDU
		eth_hdr = (ethernet_header*)eth_start_ptr;
		llc_hdr = (llc_header*)(mpdu_start_ptr + sizeof(mac_header_80211));

		//Copy the src/dest addresses from the received Eth packet to temp space
		memcpy(eth_src, eth_hdr->address_source, 6);
		memcpy(eth_dest, eth_hdr->address_destination, 6);

		//Prepare the MPDU LLC header
		llc_hdr->dsap = LLC_SNAP;
		llc_hdr->ssap = LLC_SNAP;
		llc_hdr->control_field = LLC_CNTRL_UNNUMBERED;
		bzero((void *)(llc_hdr->org_code), 3); //Org Code 0x000000: Encapsulated Ethernet

		packet_is_queued = 0;
		packet_bd_list tx_queue_list;
		packet_bd_list_init(&tx_queue_list);
		packet_bd_insertEnd(&tx_queue_list, tx_queue);

		switch(eth_encap_mode){
			case ENCAP_MODE_AP:

				switch(eth_hdr->type) {
					case ETH_TYPE_ARP:
						llc_hdr->type = LLC_TYPE_ARP;
						packet_is_queued = eth_rx_callback(&tx_queue_list, eth_dest, eth_src, mpdu_tx_len);
					break;
					case ETH_TYPE_IP:
						llc_hdr->type = LLC_TYPE_IP;
						packet_is_queued = eth_rx_callback(&tx_queue_list, eth_dest, eth_src, mpdu_tx_len);
					break;

					/* WMP_START */
					case WMP4WARP_ETHER_TYPE:
						wmp_high_util_handle_wmp_cmd_from_ethernet(eth_hdr);
					break;
					/* WMP_END */
					default:
						//Unknown/unsupported EtherType; don't process the Eth frame
					break;
				}

			break;

			case ENCAP_MODE_STA:

				//Save this ethernet src address for d
				memcpy(eth_sta_mac_addr, eth_src, 6);
				memcpy(eth_src, hw_info.hw_addr_wlan, 6);

				switch(eth_hdr->type) {
					case ETH_TYPE_ARP:
						arp = (arp_packet*)((void*)eth_hdr + sizeof(ethernet_header));

						//Here we hijack ARP messages and overwrite their source MAC address field with
						//the station's wireless MAC address.
						memcpy(arp->eth_src, hw_info.hw_addr_wlan, 6);

						llc_hdr->type = LLC_TYPE_ARP;
						packet_is_queued = eth_rx_callback(&tx_queue_list, eth_dest, eth_src, mpdu_tx_len);


					break;
					case ETH_TYPE_IP:
						llc_hdr->type = LLC_TYPE_IP;
						ip_hdr = (ipv4_header*)((void*)eth_hdr + sizeof(ethernet_header));

						if(ip_hdr->prot == IPV4_PROT_UDP){
							udp = (udp_header*)((void*)ip_hdr + 4*((u8)(ip_hdr->ver_ihl) & 0xF));
							udp->checksum = 0; //Disable the checksum since we are about to mess with the bytes in the packet

							if(Xil_Ntohs(udp->src_port) == UDP_SRC_PORT_BOOTPC || Xil_Ntohs(udp->src_port) == UDP_SRC_PORT_BOOTPS){
								//This is a DHCP Discover packet, which contains the source hardware address
								//deep inside the packet (in addition to its usual location in the Eth header).
								//For STA encapsulation, we need to overwrite this address with the MAC addr
								//of the wireless station.

								dhcp = (dhcp_packet*)((void*)udp + sizeof(udp_header));

								if(Xil_Ntohl(dhcp->magic_cookie) == DHCP_MAGIC_COOKIE){
									eth_mid_ptr = (u8*)((void*)dhcp + sizeof(dhcp_packet));

									dhcp->flags = Xil_Htons(DHCP_BOOTP_FLAGS_BROADCAST);

									//Tagged DHCP Options
									continue_loop = 1;

									while(continue_loop){
										switch(eth_mid_ptr[0]){

											case DHCP_OPTION_TAG_TYPE:
												switch(eth_mid_ptr[2]){
													case DHCP_OPTION_TYPE_DISCOVER:
													case DHCP_OPTION_TYPE_REQUEST:
														//memcpy(dhcp->chaddr,hw_info.hw_addr_wlan,6);
													break;

												}

											break;

											case DHCP_OPTION_TAG_IDENTIFIER:
												//memcpy(&(eth_mid_ptr[3]),hw_info.hw_addr_wlan,6);

											break;

											case DHCP_OPTION_END:
												continue_loop = 0;
											break;
										}
										eth_mid_ptr += (2+eth_mid_ptr[1]);
									}
								}
							}
						}
						packet_is_queued = eth_rx_callback(&tx_queue_list, eth_dest, eth_src, mpdu_tx_len);

					break;

					/* WMP_START */
					case WMP4WARP_ETHER_TYPE:{
						wmp_high_util_handle_wmp_cmd_from_ethernet(eth_hdr);
					break;}
					/* WMP_END */
					default:
						//Unknown/unsupported EtherType; don't process the Eth frame
					break;
			}

			break;

		}

		if(packet_is_queued == 0){
			//xil_printf("   ...checking in\n");
			queue_checkin(&tx_queue_list);
		}

		//TODO: Option A: We free this single BD and run the routine to checkout as many queues as we can and hook them up to BDs
		//Results: pretty good TCP performance
		//Free this bd
		status = XAxiDma_BdRingFree(rxRing_ptr, 1, cur_bd_ptr);
		if(status != XST_SUCCESS) {xil_printf("Error in XAxiDma_BdRingFree of Rx BD! Err = %d\n", status); return;}
		wlan_eth_dma_update();

		//Update cur_bd_ptr to the next BD in the chain for the next iteration
		cur_bd_ptr = XAxiDma_BdRingNext(rxRing_ptr, cur_bd_ptr);

	}
	//TODO: Option B: We free all BDs at once and run the routine to checkout as many queues as we can and hook them up to BDs
	//Results: pretty lackluster TCP performance. needs further investigation
	//Free this bd
	//status = XAxiDma_BdRingFree(rxRing_ptr, bd_count, first_bd_ptr);
	//if(status != XST_SUCCESS) {xil_printf("Error in XAxiDma_BdRingFree of Rx BD! Err = %d\n", status); return;}
	//wlan_eth_dma_update();

	return;
}

void wlan_eth_dma_update(){
	//Used to submit new BDs to the DMA hardware if space is available
	int bd_count;
	int status;
	XAxiDma_BdRing *ETH_A_RxRing_ptr;
	XAxiDma_Bd *first_bd_ptr;
	XAxiDma_Bd *cur_bd_ptr;
	packet_bd_list checkout;
	packet_bd*	tx_queue;
	u32 i;
	u32 buf_addr;
	u32 num_available_packet_bd;

	ETH_A_RxRing_ptr = XAxiDma_GetRxRing(&ETH_A_DMA_Instance);
	bd_count = XAxiDma_BdRingGetFreeCnt(ETH_A_RxRing_ptr);

	num_available_packet_bd = queue_num_free();

	if(min(num_available_packet_bd,bd_count)>0){
//		xil_printf("%d BDs are free\n",bd_count);
//		xil_printf("%d packet_bds are free\n", num_available_packet_bd);
//		xil_printf("Attaching %d BDs to packet_bds\n",min(bd_count,num_available_packet_bd));

		//Checkout ETH_A_NUM_RX_BD packet_bds
		queue_checkout(&checkout, min(bd_count,num_available_packet_bd));

		status = XAxiDma_BdRingAlloc(ETH_A_RxRing_ptr, min(bd_count,checkout.length), &first_bd_ptr);
		if(status != XST_SUCCESS) {xil_printf("Error in XAxiDma_BdRingAlloc()! Err = %d\n", status); return;}

		tx_queue = checkout.first;

		//Iterate over each Rx buffer descriptor
		cur_bd_ptr = first_bd_ptr;
		for(i = 0; i < min(bd_count,checkout.length); i++) {
			//Set the memory address for this BD's buffer
			buf_addr = (u32)((void*)((tx_packet_buffer*)(tx_queue->buf_ptr))->frame + sizeof(mac_header_80211) + sizeof(llc_header) - sizeof(ethernet_header));

			status = XAxiDma_BdSetBufAddr(cur_bd_ptr, buf_addr);
			if(status != XST_SUCCESS) {xil_printf("XAxiDma_BdSetBufAddr failed (bd %d, addr 0x08x)! Err = %d\n", i, buf_addr, status); return;}

			//Set every Rx BD to max length (this assures 1 BD per Rx pkt)
			status = XAxiDma_BdSetLength(cur_bd_ptr, ETH_A_PKT_BUF_SIZE, ETH_A_RxRing_ptr->MaxTransferLen);
			if(status != XST_SUCCESS) {xil_printf("XAxiDma_BdSetLength failed (bd %d, addr 0x08x)! Err = %d\n", i, buf_addr, status); return;}

			//Rx BD's don't need control flags before use; DMA populates these post-Rx
			XAxiDma_BdSetCtrl(cur_bd_ptr, 0);

			//BD ID is arbitrary; use pointer to the packet_bd associated with this BD
			XAxiDma_BdSetId(cur_bd_ptr, (u32)tx_queue);

			//Update cur_bd_ptr to the next BD in the chain for the next iteration
			cur_bd_ptr = XAxiDma_BdRingNext(ETH_A_RxRing_ptr, cur_bd_ptr);

			//Remove this tx_queue from the checkout list
			//packet_bd_remove(&checkout,tx_queue);

			//Traverse forward in the checked-out packet_bd list
			tx_queue = tx_queue->next;
		}

		//Push the Rx BD ring to hardware and start receiving
		status = XAxiDma_BdRingToHw(ETH_A_RxRing_ptr, min(num_available_packet_bd,bd_count), first_bd_ptr);

		//Check any remaining unused entries from the checkout list back in
		//queue_checkin(&checkout);

	}
	return;
}

