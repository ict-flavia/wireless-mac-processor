/*
 * wmp_states.h
 *
 *  Created on: Oct 7, 2013
 *      Author: Nicolo' facchi
 */

#ifndef WMP_STATE_H_
#define WMP_STATE_H_

#define WMP_STATE_LAST_TRAN_IGNORE		0xF

/* Macros, masks and shifts for bytecode interpretation */
#define WMP_STATE_RESERVED_MASK		0xF000
#define WMP_STATE_RESERVED_SHIFT		12
#define WMP_STATE_GET_RESERVED(state)	\
		(((state) & WMP_STATE_RESERVED_MASK) >> WMP_STATE_RESERVED_SHIFT)

#define WMP_STATE_LAST_TRAN_MASK		0xF000
#define WMP_STATE_LAST_TRAN_SHIFT		12
#define WMP_STATE_GET_LAST_TRAN(state)	\
		(((state) & WMP_STATE_LAST_TRAN_MASK) >> WMP_STATE_LAST_TRAN_SHIFT)

#define WMP_STATE_OUT_TRAN_MASK		0x0E00
#define WMP_STATE_OUT_TRAN_SHIFT		9
#define WMP_STATE_GET_OUT_TRAN(state)	\
		(((state) & WMP_STATE_OUT_TRAN_MASK) >> WMP_STATE_OUT_TRAN_SHIFT)

#define WMP_STATE_OUT_TRAN_OFFSET_MASK		0x01FF
#define WMP_STATE_OUT_TRAN_OFFSET_SHIFT	0
#define WMP_STATE_GET_OUT_TRAN_OFFSET(state)	\
		(((state) & WMP_STATE_OUT_TRAN_OFFSET_MASK) >> WMP_STATE_OUT_TRAN_OFFSET_SHIFT)

#define wmp_state_set_last_tran(wmp_fsm, s_idx, t_idx)		\
		(wmp_fsm_set_state(wmp_fsm, (s_idx),					\
				(wmp_fsm_get_state(wmp_fsm, (s_idx)) &		\
				~WMP_STATE_LAST_TRAN_MASK) |				\
				(((t_idx) << WMP_STATE_LAST_TRAN_SHIFT) &		\
						WMP_STATE_LAST_TRAN_MASK)))			\


#endif /* WMP_STATES_H_ */
