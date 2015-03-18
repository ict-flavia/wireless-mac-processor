/*
 * wmp_high_fsm_slots_handler.h
 *
 *  Created on: Nov 8, 2013
 *      Author: Nicolo' Facchi
 */

#ifndef WMP_HIGH_FSM_SLOTS_HANDLER_H_
#define WMP_HIGH_FSM_SLOTS_HANDLER_H_

#include "xil_types.h"

struct wmp_high_fsm_slot_info {
	u16 id;
	u8 used;
	u64 timestamp;
};

void wmp_high_fsm_slots_handler_init();
u8 wmp_high_fsm_slots_handler_next_slot();
void wmp_high_fsm_slots_handler_set_last_written(u8 idx);
void wmp_high_fsm_slots_handler_set_slot_used(u8 idx, u16 id);
u8 wmp_high_fsm_slots_handler_free_lru_slot();
u8 wmp_high_fsm_slots_handler_first_not_used_slot();
u8 wmp_high_fsm_slots_handler_slot_exist(u16 id);
u8 wmp_high_fsm_slots_handler_delete_slot(u16 id);
u8 wmp_high_fsm_slots_handler_is_fsm_currently_running(u16 id);
u8 wmp_high_fsm_slots_handler_id_to_slot(u16 id);

#endif /* WMP_HIGH_FSM_SLOTS_HANDLER_H_ */
