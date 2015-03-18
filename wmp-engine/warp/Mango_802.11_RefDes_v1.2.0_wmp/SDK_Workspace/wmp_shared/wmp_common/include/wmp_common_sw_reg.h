/*
 * wmp_common_sw_register.h
 *
 *  Created on: 04/nov/2013
 *      Author: Nicolo' Facchi
 */

#ifndef WMP_COMMON_SW_REGISTER_H_
#define WMP_COMMON_SW_REGISTER_H_

#include "wmp_fsm.h"
#include "xmutex.h"
#include "xtmrctr.h"
#include "xmbox.h"

struct wmp_common_sw_reg {
	XTmrCtr wmp_common_sw_reg_tmrctr;
	XMutex wmp_common_sw_reg_pkt_buf_mutex;
	XMbox wmp_common_sw_reg_ipc_mailbox;

	struct wmp_fsm wmp_common_sw_reg_fsm;
};

struct wmp_common_sw_reg *wmp_common_sw_reg_get_container();

static inline XTmrCtr  *wmp_common_sw_reg_get_tmrctr(struct wmp_common_sw_reg *container)
{
	return &container->wmp_common_sw_reg_tmrctr;
}

static inline XMutex *wmp_common_sw_reg_get_pkt_buf_mutex(struct wmp_common_sw_reg *container)
{
	return &container->wmp_common_sw_reg_pkt_buf_mutex;
}

static inline XMbox *wmp_common_sw_reg_get_ipc_mailbox(struct wmp_common_sw_reg *container)
{
	return &container->wmp_common_sw_reg_ipc_mailbox;
}

static inline struct wmp_fsm *wmp_common_sw_reg_get_fsm(struct wmp_common_sw_reg *container)
{
	return &container->wmp_common_sw_reg_fsm;
}


#endif /* WMP_COMMON_SW_REGISTER_H_ */
