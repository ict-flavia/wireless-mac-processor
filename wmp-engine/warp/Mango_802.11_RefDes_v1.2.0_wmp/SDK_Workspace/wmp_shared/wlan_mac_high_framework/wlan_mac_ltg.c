////////////////////////////////////////////////////////////////////////////////
// File   : wlan_mac_ltg.c
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
#include "wlan_mac_ltg.h"

static tg_schedule_list tg_list;

static function_ptr_t ltg_callback;

int wlan_mac_ltg_sched_init(){

	int return_value = 0;

	ltg_sched_remove(LTG_REMOVE_ALL);

	tg_schedule_list_init(&tg_list);
	ltg_callback = (function_ptr_t)nullCallback;

	wlan_mac_schedule_event(SCHEDULE_FINE, 0, (void*)ltg_sched_check);

	return return_value;
}

void wlan_mac_ltg_sched_set_callback(void(*callback)()){
	ltg_callback = (function_ptr_t)callback;
}

int ltg_sched_configure(u32 id, u32 type, void* params, void* callback_arg, void(*cleanup_callback)()){
	//This function can be called on uninitalized schedule IDs or on schedule IDs that had
	//been previously configured. In the event that they had been previously configured, care
	//must be taken by the calling application to free previous the previous callback_arg if
	//applicable.

	tg_schedule* curr_tg;
	u8 create_new = 1;
	u8 is_enabled = 0;

	curr_tg = ltg_sched_find_tg_schedule(id);
	if(curr_tg != NULL){
		//A schedule with this ID has already been configured. We'll destroy it
		//and overwrite its parameters.
		create_new = 0;
		is_enabled = ((ltg_sched_state_hdr*)(curr_tg->state))->enabled;

		//Stop this LTG to make this function interrupt safe. The ltg_sched_check function
		//might be called at any point during this function. A partially-configured LTG
		//that is currently running would result in very difficult-to-debug results if
		//it happens to execute.
		((ltg_sched_state_hdr*)(curr_tg->state))->enabled = 0;
		ltg_sched_destroy(curr_tg);
	}

	//Create a new tg for this id if we didn't find it in the list
	if(create_new){
		curr_tg = ltg_sched_create();
		tg_schedule_insertEnd(&tg_list,curr_tg);
		if(tg_list.length == 1){
			//start the scheduler if the only thing in it is what we just added
			wlan_mac_schedule_event(SCHEDULE_FINE, 0, (void*)ltg_sched_check);
		}
	}

	if(curr_tg != NULL){
		curr_tg->id = id;
		curr_tg->type = type;
		curr_tg->cleanup_callback = (function_ptr_t)cleanup_callback;
		switch(type){
			case LTG_SCHED_TYPE_PERIODIC:
				curr_tg->params = wlan_malloc(sizeof(ltg_sched_periodic_params));
				curr_tg->state = wlan_malloc(sizeof(ltg_sched_periodic_state));

				if(curr_tg->params != NULL){
					memcpy(curr_tg->params, params, sizeof(ltg_sched_periodic_params));
					curr_tg->callback_arg = callback_arg;
				} else {
					xil_printf("Failed to initialize parameter struct\n");
					ltg_sched_destroy(curr_tg);
					return -1;
				}
			break;
			case LTG_SCHED_TYPE_UNIFORM_RAND:
				curr_tg->params = wlan_malloc(sizeof(ltg_sched_uniform_rand_params));
				curr_tg->state = wlan_malloc(sizeof(ltg_sched_uniform_rand_params));

				if(curr_tg->params != NULL){
					memcpy(curr_tg->params, params, sizeof(ltg_sched_uniform_rand_params));
					curr_tg->callback_arg = callback_arg;
				} else {
					xil_printf("Failed to initialize parameter struct\n");
					ltg_sched_destroy(curr_tg);
					return -1;
				}
			break;
			default:
				xil_printf("Unknown type %d, destroying tg_schedule struct\n");
				ltg_sched_destroy(curr_tg);
				return -1;
			break;
		}
		((ltg_sched_state_hdr*)(curr_tg->state))->enabled = is_enabled;


	} else {
		xil_printf("Failed to initialize tg_schedule struct\n");
		return -1;
	}

	return 0;
}

int ltg_sched_start(u32 id){
	tg_schedule* curr_tg;

	curr_tg = ltg_sched_find_tg_schedule(id);
	if(curr_tg != NULL){
		return ltg_sched_start_l(curr_tg);
	}
	else {
		xil_printf("Failed to start LTG ID: %d. Please ensure LTG is configured before starting\n", id);
		return -1;
	}

}
int ltg_sched_start_l(tg_schedule* curr_tg){
	u64 timestamp = get_usec_timestamp();
	u64 random_timestamp;

	switch(curr_tg->type){
		case LTG_SCHED_TYPE_PERIODIC:
			curr_tg->timestamp = timestamp + ((ltg_sched_periodic_params*)(curr_tg->params))->interval_usec;
			((ltg_sched_state_hdr*)(curr_tg->state))->enabled = 1;
		break;
		case LTG_SCHED_TYPE_UNIFORM_RAND:
			random_timestamp = (rand()%(((ltg_sched_uniform_rand_params*)(curr_tg->params))->max_interval - ((ltg_sched_uniform_rand_params*)(curr_tg->params))->min_interval))+((ltg_sched_uniform_rand_params*)(curr_tg->params))->min_interval;
			curr_tg->timestamp = timestamp + random_timestamp;
			((ltg_sched_state_hdr*)(curr_tg->state))->enabled = 1;
		break;

		default:
			xil_printf("Unknown type %d, destroying tg_schedule struct\n");
			ltg_sched_destroy(curr_tg);
			return -1;
		break;
	}
	return 0;
}


void ltg_sched_check(){
	u64 timestamp;
	tg_schedule* curr_tg;
	u32 i;

	if(tg_list.length > 0){
		timestamp = get_usec_timestamp();
		curr_tg = tg_list.first;
		for(i = 0; i < tg_list.length; i++ ){
			if(((ltg_sched_state_hdr*)(curr_tg->state))->enabled && timestamp >= ( curr_tg->timestamp) ){
				ltg_sched_stop_l(curr_tg);
				ltg_sched_start_l(curr_tg);
				ltg_callback(curr_tg->id, curr_tg->callback_arg);
			}
			curr_tg = curr_tg->next;
		}
		wlan_mac_schedule_event(SCHEDULE_FINE, 0, (void*)ltg_sched_check);
	}
	return;
}

int ltg_sched_stop(u32 id){
	tg_schedule* curr_tg;

	curr_tg = ltg_sched_find_tg_schedule(id);
	if(curr_tg != NULL){
		return ltg_sched_stop_l(curr_tg);
	}
	return -1;
}

int ltg_sched_stop_l(tg_schedule* curr_tg){
	((ltg_sched_state_hdr*)(curr_tg->state))->enabled = 0;
	return 0;
}

int ltg_sched_get_state(u32 id, u32* type, void** state){
	//This function returns the type of schedule corresponding to the id argument
	//It fills in the state argument with the state of the schedule

	u64 timestamp = get_usec_timestamp();
	tg_schedule* curr_tg;

	curr_tg = ltg_sched_find_tg_schedule(id);
	if(curr_tg == NULL){
		return -1;
	}

	*type = curr_tg->type;
	*state = curr_tg->state;


	switch(curr_tg->type){
		case LTG_SCHED_TYPE_PERIODIC:
		case LTG_SCHED_TYPE_UNIFORM_RAND:
			if(timestamp < (curr_tg->timestamp) ){
				((ltg_sched_periodic_state*)state)->time_to_next_usec = (u32)(timestamp - curr_tg->timestamp);
			} else {
				((ltg_sched_periodic_state*)state)->time_to_next_usec = 0;
			}
		break;
		default:
			xil_printf("Unknown type %d\n", curr_tg->type);
			return -1;
		break;
	}

	return 0;

}
int ltg_sched_get_params(u32 id, u32* type, void** params){
	//This function returns the type of the schedule corresponding to the id argument
	//It fills in the current parameters of the schedule into the params argument
	tg_schedule* curr_tg;

	curr_tg = ltg_sched_find_tg_schedule(id);
	if(curr_tg == NULL){
		return -1;
	}

	*params = curr_tg->params;

	return 0;
}

int ltg_sched_get_callback_arg(u32 id, void** callback_arg){
	tg_schedule* curr_tg;

	curr_tg = ltg_sched_find_tg_schedule(id);
	if(curr_tg == NULL){
		return -1;
	}

	*callback_arg = curr_tg->callback_arg;

	return 0;
}



int ltg_sched_remove(u32 id){
	u32 i;
	tg_schedule* curr_tg;

	curr_tg = tg_list.first;
	for(i = 0; i < tg_list.length; i++ ){
		if( (curr_tg->id)==id || id == LTG_REMOVE_ALL){
			curr_tg->cleanup_callback(curr_tg->id, curr_tg->callback_arg);
			ltg_sched_destroy(curr_tg);
			tg_schedule_remove(&tg_list, curr_tg);
			if(id != LTG_REMOVE_ALL) return 0;
		}
		curr_tg = curr_tg->next;
	}


	if(id != LTG_REMOVE_ALL){
		return -1;
	} else {
		return 0;
	}
}

tg_schedule* ltg_sched_create(){
	return (tg_schedule*)wlan_malloc(sizeof(tg_schedule));
}

void ltg_sched_destroy(tg_schedule* tg){

	switch(tg->type){
		case LTG_SCHED_TYPE_PERIODIC:
		case LTG_SCHED_TYPE_UNIFORM_RAND:
			wlan_free(tg->params);
			wlan_free(tg->state);
		break;
	}

	//free(tg);
	return;
}

tg_schedule* ltg_sched_find_tg_schedule(u32 id){
	u32 i;
	tg_schedule* curr_tg;

	curr_tg = tg_list.first;
	for(i = 0; i < tg_list.length; i++ ){
		if( (curr_tg->id)==id){
			return curr_tg;
		}
		curr_tg = curr_tg->next;
	}
	return NULL;
}

void tg_schedule_insertAfter(tg_schedule_list* list, tg_schedule* tg, tg_schedule* tg_new){
	tg_new->prev = tg;
	tg_new->next = tg->next;
	if(tg->next == NULL){
		list->last = tg_new;
	} else {
		tg->next->prev = tg_new;
	}
	tg->next = tg_new;
	(list->length)++;
	return;
}

void tg_schedule_insertBefore(tg_schedule_list* list, tg_schedule* tg, tg_schedule* tg_new){
	tg_new->prev = tg->prev;
	tg_new->next = tg;
	if(tg->prev == NULL){
		list->first = tg_new;
	} else {
		tg->prev->next = tg_new;
	}
	tg->prev = tg_new;
	(list->length)++;
	return;
}

void tg_schedule_insertBeginning(tg_schedule_list* list, tg_schedule* tg_new){
	if(list->first == NULL){
		list->first = tg_new;
		list->last = tg_new;
		tg_new->prev = NULL;
		tg_new->next = NULL;
		(list->length)++;
	} else {
		tg_schedule_insertBefore(list, list->first, tg_new);
	}
	return;
}

void tg_schedule_insertEnd(tg_schedule_list* list, tg_schedule* tg_new){
	if(list->last == NULL){
		tg_schedule_insertBeginning(list,tg_new);
	} else {
		tg_schedule_insertAfter(list,list->last, tg_new);
	}
	return;
}

void tg_schedule_remove(tg_schedule_list* list, tg_schedule* tg){
	if(tg->prev == NULL){
		list->first = tg->next;
	} else {
		tg->prev->next = tg->next;
	}

	if(tg->next == NULL){
		list->last = tg->prev;
	} else {
		tg->next->prev = tg->prev;
	}
	(list->length)--;
}

void tg_schedule_list_init(tg_schedule_list* list){
	list->first = NULL;
	list->last = NULL;
	list->length = 0;
	return;
}
