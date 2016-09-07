////////////////////////////////////////////////////////////////////////////////
// File   : wlan_mac_queue.c
// Authors: Patrick Murphy (murphpo [at] mangocomm.com)
//			Chris Hunter (chunter [at] mangocomm.com)
// License: Copyright 2013, Mango Communications. All rights reserved.
//          Distributed under the Mango Communications Reference Design License
//				See LICENSE.txt included in the design archive or
//				at http://mangocomm.com/802.11/license
////////////////////////////////////////////////////////////////////////////////

#include "xil_types.h"
#include "stdlib.h"
#include "stdio.h"
#include "xparameters.h"
#include "xintc.h"
#include "string.h"

#include "wlan_mac_ipc_util.h"
#include "wlan_mac_util.h"
#include "wlan_mac_queue.h"

//This list holds all of the empty, free elements
static packet_bd_list queue_free;

//This vector of lists will get filled in with elements from the free list
static packet_bd_list queue[NUM_QUEUES];


u32 PQUEUE_LEN;
void* PQUEUE_BUFFER_SPACE_BASE;

#define USE_DRAM 1
static u8 dram_present;

void queue_dram_present(u8 present){
	dram_present = present;
}

int queue_init(){
	u32 i;

#if USE_DRAM
	if(dram_present == 1){
		//Use DRAM
		PQUEUE_LEN = 3000;
		xil_printf("Queue of %d placed in DRAM: using %d kB\n", PQUEUE_LEN, (PQUEUE_LEN*PQUEUE_MAX_FRAME_SIZE)/1024);
		PQUEUE_BUFFER_SPACE_BASE = (void*)(DDR3_BASEADDR);
	} else {
		//Use BRAM
		PQUEUE_LEN = 20;
		xil_printf("Queue of %d placed in BRAM: using %d kB\n", PQUEUE_LEN, (PQUEUE_LEN*PQUEUE_MAX_FRAME_SIZE)/1024);
		PQUEUE_BUFFER_SPACE_BASE = (void*)(PQUEUE_MEM_BASE+(PQUEUE_LEN*sizeof(packet_bd)));
	}

#else
	//Use BRAM
	PQUEUE_LEN = 20;
	xil_printf("Queue of %d placed in BRAM: using %d kB\n", PQUEUE_LEN, (PQUEUE_LEN*PQUEUE_MAX_FRAME_SIZE)/1024);
	PQUEUE_BUFFER_SPACE_BASE = (void*)(PQUEUE_MEM_BASE+(PQUEUE_LEN*sizeof(packet_bd)));
#endif

	packet_bd_list_init(&queue_free);

	queue_free.first = (packet_bd*)PQUEUE_SPACE_BASE;

	bzero((void*)PQUEUE_BUFFER_SPACE_BASE, PQUEUE_LEN*PQUEUE_MAX_FRAME_SIZE);

	//At boot, every packet_bd buffer descriptor is free
	//To set up the doubly linked list, we exploit the fact that we know the starting state is sequential.
	//This matrix addressing is not safe once the queue is used. The insert/remove helper functions should be used
	queue_free.length = PQUEUE_LEN;
	for(i=0;i<PQUEUE_LEN;i++){
		queue_free.first[i].buf_ptr = (void*)(PQUEUE_BUFFER_SPACE_BASE + (i*PQUEUE_MAX_FRAME_SIZE));
		queue_free.first[i].metadata_ptr = NULL;

		//xil_printf("packet_bd %d: pktbuf_ptr = 0x%08x\n",i, queue_free.first[i].pktbuf_ptr);

		if(i==(PQUEUE_LEN-1)){
			queue_free.first[i].next = NULL;
			queue_free.last = &(queue_free.first[i]);
		} else {
			queue_free.first[i].next = &(queue_free.first[i+1]);
		}


		if(i==0){
			queue_free.first[i].prev = NULL;
		} else {
			queue_free.first[i].prev = &(queue_free.first[i-1]);
		}

	}

	//By default, all queues are empty.
	for(i=0;i<NUM_QUEUES;i++){
		packet_bd_list_init(&(queue[i]));
	}

	return PQUEUE_LEN*PQUEUE_MAX_FRAME_SIZE;

}

int queue_total_size(){
	return PQUEUE_LEN;
}

void purge_queue(u16 queue_sel){
	packet_bd_list dequeue;
	u32            num_queued;

	num_queued = queue_num_queued(queue_sel);

	if( num_queued > 0 ){
		xil_printf("purging %d packets from queue for queue ID %d\n", num_queued, queue_sel);
		dequeue_from_beginning(&dequeue, queue_sel, 1);
		queue_checkin(&dequeue);
	}
}

void enqueue_after_end(u16 queue_sel, packet_bd_list* list){
	packet_bd* curr_packet_bd;
	packet_bd* next_packet_bd;

	curr_packet_bd = list->first;

	while(curr_packet_bd != NULL){
		next_packet_bd = curr_packet_bd->next;
		packet_bd_remove(list,curr_packet_bd);
		packet_bd_insertEnd(&(queue[queue_sel]),curr_packet_bd);
		curr_packet_bd = next_packet_bd;
	}
	return;
}

void dequeue_from_beginning(packet_bd_list* new_list, u16 queue_sel, u16 num_packet_bd){
	u32 i,num_dequeue;
	packet_bd* curr_packet_bd;

	packet_bd_list_init(new_list);

	if(num_packet_bd <= queue[queue_sel].length){
		num_dequeue = num_packet_bd;
	} else {
		num_dequeue = queue[queue_sel].length;
	}

	for (i=0;i<num_dequeue;i++){
		curr_packet_bd = queue[queue_sel].first;
		//Remove from free list
		packet_bd_remove(&queue[queue_sel],curr_packet_bd);
		//Add to new checkout list
		packet_bd_insertEnd(new_list,curr_packet_bd);
	}
	return;
}

u32 queue_num_free(){
	return queue_free.length;
}

u32 queue_num_queued(u16 queue_sel){
	return queue[queue_sel].length;
}

void queue_checkout(packet_bd_list* new_list, u16 num_packet_bd){
	//Checks out up to num_packet_bd number of packet_bds from the free list. If num_packet_bd are not free,
	//then this function will return the number that are free and only check out that many.

	u32 i,num_checkout;
	packet_bd* curr_packet_bd;

	packet_bd_list_init(new_list);

	if(num_packet_bd <= queue_free.length){
		num_checkout = num_packet_bd;
	} else {
		num_checkout = queue_free.length;
	}

	//Traverse the queue_free and update the pointers
	for (i=0;i<num_checkout;i++){
		curr_packet_bd = queue_free.first;
		//Remove from free list
		packet_bd_remove(&queue_free,curr_packet_bd);
		//Add to new checkout list
		packet_bd_insertEnd(new_list,curr_packet_bd);
	}
	return;
}
void queue_checkin(packet_bd_list* list){
	packet_bd* curr_packet_bd;
	packet_bd* next_packet_bd;

	curr_packet_bd = list->first;

	while(curr_packet_bd != NULL){
		next_packet_bd = curr_packet_bd->next;
		packet_bd_remove(list,curr_packet_bd);
		packet_bd_insertEnd(&queue_free,curr_packet_bd);
		curr_packet_bd = next_packet_bd;
	}

	return;
}

void packet_bd_insertAfter(packet_bd_list* list, packet_bd* bd, packet_bd* bd_new){
	bd_new->prev = bd;
	bd_new->next = bd->next;
	if(bd->next == NULL){
		list->last = bd_new;
	} else {
		bd->next->prev = bd_new;
	}
	bd->next = bd_new;
	(list->length)++;
	return;
}

void packet_bd_insertBefore(packet_bd_list* list, packet_bd* bd, packet_bd* bd_new){
	bd_new->prev = bd->prev;
	bd_new->next = bd;
	if(bd->prev == NULL){
		list->first = bd_new;
	} else {
		bd->prev->next = bd_new;
	}
	bd->prev = bd_new;
	(list->length)++;
	return;
}

void packet_bd_insertBeginning(packet_bd_list* list, packet_bd* bd_new){
	if(list->first == NULL){
		list->first = bd_new;
		list->last = bd_new;
		bd_new->prev = NULL;
		bd_new->next = NULL;
		(list->length)++;
	} else {
		packet_bd_insertBefore(list, list->first, bd_new);
	}
	return;
}

void packet_bd_insertEnd(packet_bd_list* list, packet_bd* bd_new){
	if(list->last == NULL){
		packet_bd_insertBeginning(list,bd_new);
	} else {
		packet_bd_insertAfter(list,list->last, bd_new);
	}
	return;
}

void packet_bd_remove(packet_bd_list* list, packet_bd* bd){
	if(bd->prev == NULL){
		list->first = bd->next;
	} else {
		bd->prev->next = bd->next;
	}

	if(bd->next == NULL){
		list->last = bd->prev;
	} else {
		bd->next->prev = bd->prev;
	}
	(list->length)--;
}

void packet_bd_list_init(packet_bd_list* list){
	list->first = NULL;
	list->last = NULL;
	list->length = 0;
	return;
}


void packet_bd_print(packet_bd_list* list){
	packet_bd* curr_bd = list->first;

	xil_printf("******** packet_bd_print ********\n");
	xil_printf("list->first:     0x%08x\n", list->first);
	xil_printf("list->last:      0x%08x\n", list->last);
	xil_printf("list->length:    %d\n\n", list->length);

	while(curr_bd != NULL){
		xil_printf("0x%08x\n", curr_bd);
		xil_printf("  |  prev:      0x%08x\n", curr_bd->prev);
		xil_printf("  |  next:      0x%08x\n", curr_bd->next);
		xil_printf("  |       buf_ptr: 0x%08x\n", curr_bd->buf_ptr);
		curr_bd = curr_bd->next;
	}
}
