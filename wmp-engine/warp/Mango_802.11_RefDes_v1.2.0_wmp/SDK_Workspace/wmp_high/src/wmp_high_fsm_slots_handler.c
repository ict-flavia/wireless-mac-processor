/*
 * wmp_high_fsm_slots_handler.c
 *
 *  Created on: Nov 8, 2013
 *      Author: Nicolo' Facchi
 */

#include "wlan_mac_util.h"

#include "wmp_high_fsm_slots_handler.h"
#include "wmp_fsm.h"
#include "wmp_common_sw_reg.h"

#include "xmutex.h"


static u8 wmp_high_fsm_slots_handler_last_written;
static struct wmp_high_fsm_slot_info slot_info[WMP_FSM_BUFFER_MUTEX_N];

void wmp_high_fsm_slots_handler_init()
{
	int i;

	wmp_high_fsm_slots_handler_last_written = 0;

	for (i = 0; i < WMP_FSM_BUFFER_MUTEX_N; i++) {
		slot_info[i].id = 0xFFFF;
		slot_info[i].timestamp = 0;
		slot_info[i].used = 0;
	}
}

void wmp_high_fsm_slots_handler_set_last_written(u8 idx)
{
	wmp_high_fsm_slots_handler_last_written = idx;
}

void wmp_high_fsm_slots_handler_set_slot_used(u8 idx, u16 id)
{
	slot_info[idx].id = id;
	slot_info[idx].timestamp = get_usec_timestamp();
	slot_info[idx].used = 1;
}

/*
 * For now we look for the first unused slot starting
 * from wmp_high_fsm_slots_handler_last_written.
 *
 * Extend this function to implement a more
 * complex logic.
 */
u8 wmp_high_fsm_slots_handler_next_slot()
{
	u8 k;
	struct wmp_common_sw_reg *container_cmn = wmp_common_sw_reg_get_container();
	struct wmp_fsm *wmp_fsm = wmp_common_sw_reg_get_fsm(container_cmn);

	for (k = 0; k < WMP_FSM_BUFFER_MUTEX_N; k ++) {
		if (!XMutex_IsLocked(&(wmp_fsm->fsm_mutex),
				((wmp_high_fsm_slots_handler_last_written + k + 1) % WMP_FSM_BUFFER_MUTEX_N)))
			break;
	}

	return (u8)((wmp_high_fsm_slots_handler_last_written + k + 1) % WMP_FSM_BUFFER_MUTEX_N);
}

u8 wmp_high_fsm_slots_handler_free_lru_slot()
{
	u8 k;
	u8 index;
	u8 lru_idx = 0;
	u64 mintimestamp = 0xFFFFFFFFFFFFFFFFL;
	struct wmp_common_sw_reg *container_cmn = wmp_common_sw_reg_get_container();
	struct wmp_fsm *wmp_fsm = wmp_common_sw_reg_get_fsm(container_cmn);

	for (k = 0; k < WMP_FSM_BUFFER_MUTEX_N; k ++) {
		index = ((wmp_high_fsm_slots_handler_last_written + k + 1) % WMP_FSM_BUFFER_MUTEX_N);
		if (!XMutex_IsLocked(&(wmp_fsm->fsm_mutex), index)) {
			if (slot_info[index].timestamp < mintimestamp) {
				mintimestamp = slot_info[index].timestamp;
				lru_idx = index;
			}
		}
	}

	slot_info[index].used = 0;
	slot_info[index].timestamp = 0;
	slot_info[index].id = 0xFFFF;

	return lru_idx;
}

u8 wmp_high_fsm_slots_handler_delete_slot(u16 id)
{
	u8 k;
	u8 index;
	struct wmp_common_sw_reg *container_cmn = wmp_common_sw_reg_get_container();
	struct wmp_fsm *wmp_fsm = wmp_common_sw_reg_get_fsm(container_cmn);

	for (k = 0; k < WMP_FSM_BUFFER_MUTEX_N; k ++) {
		index = ((wmp_high_fsm_slots_handler_last_written + k + 1) % WMP_FSM_BUFFER_MUTEX_N);
		if (!XMutex_IsLocked(&(wmp_fsm->fsm_mutex), index) && (slot_info[index].id == id))
			break;
	}

	if (k == WMP_FSM_BUFFER_MUTEX_N) {
		return 0xFF;
	}

	slot_info[index].used = 0;
	slot_info[index].timestamp = 0;
	slot_info[index].id = 0xFFFF;

	return index;
}

u8 wmp_high_fsm_slots_handler_is_fsm_currently_running(u16 id)
{
	u8 k;
	u8 index;
	struct wmp_common_sw_reg *container_cmn = wmp_common_sw_reg_get_container();
	struct wmp_fsm *wmp_fsm = wmp_common_sw_reg_get_fsm(container_cmn);

	for (k = 0; k < WMP_FSM_BUFFER_MUTEX_N; k ++) {
		index = ((wmp_high_fsm_slots_handler_last_written + k + 1) % WMP_FSM_BUFFER_MUTEX_N);
		if (slot_info[index].id == id) {
			break;
		}
	}

	if (k == WMP_FSM_BUFFER_MUTEX_N) {
		return 0;
	}

	if (!XMutex_IsLocked(&(wmp_fsm->fsm_mutex), index)) {
		return 0;
	}

	return 1;
}

u8 wmp_high_fsm_slots_handler_id_to_slot(u16 id)
{
	u8 k;
	u8 index;

	for (k = 0; k < WMP_FSM_BUFFER_MUTEX_N; k ++) {
		index = ((wmp_high_fsm_slots_handler_last_written + k + 1) % WMP_FSM_BUFFER_MUTEX_N);
		if (slot_info[index].id == id) {
			break;
		}
	}

	if (k == WMP_FSM_BUFFER_MUTEX_N) {
		return 0xFF;
	}

	return index;
}

u8 wmp_high_fsm_slots_handler_slot_exist(u16 id)
{
	u8 k;
	u8 index;

	for (k = 0; k < WMP_FSM_BUFFER_MUTEX_N; k ++) {
		index = ((wmp_high_fsm_slots_handler_last_written + k + 1) % WMP_FSM_BUFFER_MUTEX_N);
		if ((slot_info[index].id == id))
			break;
	}

	if (k == WMP_FSM_BUFFER_MUTEX_N) {
		return 0;
	}

	return 1;
}

u8 wmp_high_fsm_slots_handler_first_not_used_slot()
{
	u8 k;
	u8 index;
	struct wmp_common_sw_reg *container_cmn = wmp_common_sw_reg_get_container();
	struct wmp_fsm *wmp_fsm = wmp_common_sw_reg_get_fsm(container_cmn);

	for (k = 0; k < WMP_FSM_BUFFER_MUTEX_N; k ++) {
		index = ((wmp_high_fsm_slots_handler_last_written + k + 1) % WMP_FSM_BUFFER_MUTEX_N);
		if (!XMutex_IsLocked(&(wmp_fsm->fsm_mutex), index) && !slot_info[index].used)
			break;
	}

	if (k == WMP_FSM_BUFFER_MUTEX_N) {
		return wmp_high_fsm_slots_handler_free_lru_slot();
	}

	return (u8)((wmp_high_fsm_slots_handler_last_written + k + 1) % WMP_FSM_BUFFER_MUTEX_N);
}
