/*
 * wmp_fsm.h
 *
 *  Created on: Oct 7, 2013
 *      Author: Nicolo' Facchi
 */

#ifndef WMP_FSM_H_
#define WMP_FSM_H_

#include "xbram.h"
#include "xmutex.h"
#include "wmp_state.h"
#include "wmp_transition.h"

/* descriptor of a single FSM */
struct wmp_fsm_desc {

	/* Base address of this FSM */
	u32 base_addr;
	/* Total length (in byte) of this FSM)
	 * length = last_addr - base_addr + 1
	 */
	u16 length;
	/* First address after this FSM */
	u32 last_addr;

	/* Base address of the parameters section */
	u32 param_base_addr;
	/* Length of the parameters section
	 * param_length = parame_last_addr - param_base_addr + 1
	 */
	u16 param_length;
	/* First address after the parameters section */
	u32 param_last_addr;

	/* Base address of the states section */
	u32 state_base_addr;
	/* Length of the states section
	 * state_length = state_last_addr - state_base_addr + 1
	 */
	u16 state_length;
	/* First address after the state section */
	u32 state_last_addr;

	/* Base address of the transitions section */
	u32 tran_base_addr;
	/* Length of the transitions section
	 * tran_length = tran_last_addr - tran_base_addr + 1
	 */
	u16 tran_length;
	/* First address after the tran section */
	u32 tran_last_addr;

	/* mutex number associated with this FSM */
	u8 mutex_n;
};

struct wmp_fsm {
	/* fsm_buffer BRAM */
	XBram fsm_bram;
	/* fsm mutex */
	XMutex fsm_mutex;
	/* ID of the fsm_buffer BRAM */
	u8 fsm_buffer_bram_id;
	/* ID of the fsm_mutex component */
	u8 fsm_mutex_id;

	struct wmp_fsm_desc fsm_desc;
};


/* 2048 byte for every FSM
 *
 *
 * 232 bytes for state section
 * 1680 bytes for transition section
 * 136 bytes for parameters section
 *
 * The first 16 bit of every section contain
 * the number of element written in that section
 *
 */
#define WMP_FSM_STATE_SECTION_SIZE_DEFAULT			232
#define WMP_FSM_TRAN_SECTION_SIZE_DEFAULT			1680
#define WMP_FSM_PARAM_SECTION_SIZE_DEFAULT			136

#define WMP_FSM_LENGTH	WMP_FSM_STATE_SECTION_SIZE_DEFAULT +\
						WMP_FSM_TRAN_SECTION_SIZE_DEFAULT + \
						WMP_FSM_PARAM_SECTION_SIZE_DEFAULT


/*
 * x must be an (u8 *).
 *
 * This macro swaps the bytes of the area memory
 * pointed by x.
 */
#define WMP_FSM_SWAP_BYTES(x)	(((((u16)(*(x + 1))) << 8) & 0xFF00) | (((u16)(*(x))) & 0x00FF))


#endif /* WMP_FSM_H_ */

/*
 * For now we suppose that a maximum of 32 FSM can be stored
 * in the fsm_buffer BRAM and that every FSM can have a max
 * length of 2048 byte. Every memory location has his own
 * mutex.
 */
#define WMP_FSM_BUFFER_SIZE				65536 /* byte */
#define WMP_FSM_BUFFER_MUTEX_N			32
#define WMP_FSM_BUFFER_SINGLE_SIZE		(WMP_FSM_BUFFER_SIZE / 32)
/* i goes from 0 to (FSM_BUFFER_MUTEX_N - 1)
 * wmp_fsm is a pointer to a struct wmp_fsm
 */
#define WMP_FSM_BUFFER_MUTEX(i)			i
#define WMP_FSM_BUFFER_BASE_ADDR(wmp_fsm, i)		\
	(((wmp_fsm)->fsm_bram.Config.MemBaseAddress) + (i) * WMP_FSM_BUFFER_SINGLE_SIZE)
#define WMP_FSM_BUFFER_PARAM_BASE_ADDR(wmp_fsm, i)	\
		WMP_FSM_BUFFER_BASE_ADDR(wmp_fsm, i)
#define WMP_FSM_BUFFER_STATE_BASE_ADDR(wmp_fsm, i)	\
		(WMP_FSM_BUFFER_PARAM_BASE_ADDR(wmp_fsm, i) + WMP_FSM_PARAM_SECTION_SIZE_DEFAULT)
#define WMP_FSM_BUFFER_TRAN_BASE_ADDR(wmp_fsm, i)	\
		(WMP_FSM_BUFFER_STATE_BASE_ADDR(wmp_fsm, i) + WMP_FSM_STATE_SECTION_SIZE_DEFAULT)

#define WMP_FSM_COUNTER_FIELD_SIZE			2

#define WMP_FSM_BUFFER_CURRENT_BASE_ADDR(wmp_fsm)	\
	((wmp_fsm)->fsm_desc.base_addr)
#define WMP_FSM_BUFFER_CURRENT_PARAM_ADDR(wmp_fsm)	\
	((wmp_fsm)->fsm_desc.param_base_addr)
#define WMP_FSM_BUFFER_CURRENT_STATE_ADDR(wmp_fsm)	\
	((wmp_fsm)->fsm_desc.state_base_addr)
#define WMP_FSM_BUFFER_CURRENT_TRAN_ADDR(wmp_fsm)	\
	((wmp_fsm)->fsm_desc.tran_base_addr)


/* Macros used during byte code parsing
 *
 * bc is a (u8 *)
 */
#define WMP_FSM_BYTE_CODE_START_TAG_PARSE(bc)			\
	(((*(bc)) == 0x00) && ((*(bc + 1)) == 0x00) && ((*(bc + 2)) == 0x01))
#define WMP_FSM_BYTE_CODE_START_TAG_SIZE	3
#define WMP_FSM_BYTE_CODE_PARAM_TAG_PARSE(bc)			\
	(((*(bc)) == 0x00) && ((*(bc + 1)) == 0x00) && ((*(bc + 2)) == 0x04))
#define WMP_FSM_BYTE_CODE_PARAM_TAG_SIZE	3
#define WMP_FSM_BYTE_CODE_PARAM_SIZE		2
#define WMP_FSM_BYTE_CODE_STATE_TAG_PARSE(bc)			\
	(((*(bc)) == 0x00) && ((*(bc + 1)) == 0x00) && ((*(bc + 2)) == 0x10))
#define WMP_FSM_BYTE_CODE_STATE_TAG_SIZE	3
#define WMP_FSM_BYTE_CODE_STATE_SIZE		2
#define WMP_FSM_BYTE_CODE_TRAN_TAG_PARSE(bc)			\
	(((*(bc)) == 0x00) && ((*(bc + 1)) == 0x00) && ((*(bc + 2)) == 0x06))
#define WMP_FSM_BYTE_CODE_TRAN_TAG_SIZE	3
#define WMP_FSM_BYTE_CODE_TRAN_SIZE		6
#define WMP_FSM_BYTE_CODE_END_TAG_PARSE(bc)			\
	(((*(bc)) == 0x00) && ((*(bc + 1)) == 0x00) && ((*(bc + 2)) == 0x99))
#define WMP_FSM_BYTE_CODE_END_TAG_SIZE	3


/**
 * get the number of parameters
 *
 * wmp_fsm is a pointer to a struct wmp_fsm
 */
#define wmp_fsm_get_n_param(wmp_fsm)	\
	(Xil_In16((wmp_fsm)->fsm_desc.param_base_addr))

/**
 * get i-th fsm parameter
 *
 * wmp_fsm is a pointer to a struct wmp_fsm
 * i counts from 0
 */
#define wmp_fsm_get_param(wmp_fsm, i)											\
	(Xil_In16((wmp_fsm)->fsm_desc.param_base_addr +								\
			WMP_FSM_COUNTER_FIELD_SIZE + ((i) * WMP_FSM_BYTE_CODE_PARAM_SIZE)))

/**
 * set i-th fsm parameter
 *
 * wmp_fsm is a pointer to a struct wmp_fsm
 * i counts from 0
 * val is a u16
 */
#define wmp_fsm_set_param(wmp_fsm, i, val)											\
	(Xil_Out16((wmp_fsm)->fsm_desc.param_base_addr +								\
			WMP_FSM_COUNTER_FIELD_SIZE + ((i) * WMP_FSM_BYTE_CODE_PARAM_SIZE), val))

/**
 * Iterate over the fsm parameters
 *
 * wmp_fsm is a pointer to a struct wmp_fsm
 * i is the loop index variable
 * during the i-th iteration param (u16) has the value of the i-th parameters
 * the macro assign the number of parameters to param_n(u16)
 */
#define wmp_fsm_for_each_param(wmp_fsm, param, param_n, i)							\
		for ((i) = 0, (param_n) = wmp_fsm_get_n_param(wmp_fsm),							\
			(((i) < (param_n)) && ((param) = wmp_fsm_get_param((wmp_fsm), (i)))); 		\
			(i) < (param_n);																\
			(i)++, (((i) < param_n) && ((param) = wmp_fsm_get_param((wmp_fsm), (i)))))

/**
 * get the number of states
 *
 * wmp_fsm is a pointer to a struct wmp_fsm
 */
#define wmp_fsm_get_n_state(wmp_fsm)	\
	(Xil_In16((wmp_fsm)->fsm_desc.state_base_addr))

/**
 * get i-th fsm state
 *
 * wmp_fsm is a pointer to a struct wmp_fsm
 * i counts from 0
 */
#define wmp_fsm_get_state(wmp_fsm, i)											\
	(Xil_In16((wmp_fsm)->fsm_desc.state_base_addr +								\
			WMP_FSM_COUNTER_FIELD_SIZE + ((i) * WMP_FSM_BYTE_CODE_STATE_SIZE)))

#define wmp_fsm_set_state(wmp_fsm, i, s)											\
	(Xil_Out16((wmp_fsm)->fsm_desc.state_base_addr +								\
			WMP_FSM_COUNTER_FIELD_SIZE + ((i) * WMP_FSM_BYTE_CODE_STATE_SIZE), s))

/**
 * Iterate over the fsm states
 *
 * wmp_fsm is a pointer to a struct wmp_fsm
 * i is the loop index variable
 * during the i-th iteration state (u16) has the value of the i-th state
 * the macro assign the number of states to state_n(u16)
 */
#define wmp_fsm_for_each_state(wmp_fsm, state, state_n, i)								\
		for ((i) = 0, (state_n) = wmp_fsm_get_n_state(wmp_fsm),							\
			(((i) < (state_n)) && ((state) = wmp_fsm_get_state((wmp_fsm), (i)))); 		\
			(i) < (state_n);																\
			(i)++, (((i) < (state_n)) && ((state) = wmp_fsm_get_state((wmp_fsm), (i)))))

/**
 * get the number of transitions
 *
 * wmp_fsm is a pointer to a struct wmp_fsm
 */
#define wmp_fsm_get_n_tran(wmp_fsm)	\
	(Xil_In16((wmp_fsm)->fsm_desc.tran_base_addr))

/**
 * get the number of transitions for state i
 *
 * wmp_fsm is a pointer to a struct wmp_fsm
 * i counts from 0
 */
#define wmp_fsm_get_n_tran_state(wmp_fsm, i)	\
		(WMP_STATE_GET_OUT_TRAN(wmp_fsm_get_state(wmp_fsm, i)) + 1)

/**
 * get transitions offset (from transition base address) for state i
 *
 * wmp_fsm is a pointer to a struct wmp_fsm
 * i counts from 0
 */
#define wmp_fsm_get_tran_offset_state(wmp_fsm, i)	\
		(WMP_STATE_GET_OUT_TRAN_OFFSET(wmp_fsm_get_state(wmp_fsm, i)) * 2)

/**
 * get i-th tranition
 *
 * wmp_fsm is a pointer to a struct wmp_fsm
 * i counts from 0
 */
#define wmp_fsm_get_tran(wmp_fsm, i)														\
	((u64)																					\
	(((((u64)(Xil_In16((wmp_fsm)->fsm_desc.tran_base_addr + WMP_FSM_COUNTER_FIELD_SIZE +	\
		((i) * WMP_FSM_BYTE_CODE_TRAN_SIZE)))) << 32) & 0x0000FFFF00000000) |				\
	 ((((u64)(Xil_In16((wmp_fsm)->fsm_desc.tran_base_addr + WMP_FSM_COUNTER_FIELD_SIZE +	\
		((i) * WMP_FSM_BYTE_CODE_TRAN_SIZE) + 2))) << 16) & 0x00000000FFFF0000) |			\
	 (((u64)(Xil_In16((wmp_fsm)->fsm_desc.tran_base_addr + WMP_FSM_COUNTER_FIELD_SIZE +		\
		((i) * WMP_FSM_BYTE_CODE_TRAN_SIZE) + 4))) & 0x000000000000FFFF)))

/**
 * get i-th transition of state s
 *
 * wmp_fsm is a pointer to a struct wmp_fsm
 * i and s count from 0
 */
#define wmp_fsm_get_tran_state(wmp_fsm, i, s)																	  \
	((u64)																										  \
	(((((u64)(Xil_In16((wmp_fsm)->fsm_desc.tran_base_addr + wmp_fsm_get_tran_offset_state(wmp_fsm, (s)) +		  \
			WMP_FSM_COUNTER_FIELD_SIZE + ((i) * WMP_FSM_BYTE_CODE_TRAN_SIZE)))) << 32) & 0x0000FFFF00000000) |	  \
	 ((((u64)(Xil_In16((wmp_fsm)->fsm_desc.tran_base_addr + wmp_fsm_get_tran_offset_state(wmp_fsm, (s)) +		  \
			WMP_FSM_COUNTER_FIELD_SIZE + ((i) * WMP_FSM_BYTE_CODE_TRAN_SIZE) + 2))) << 16) & 0x00000000FFFF0000) |\
	 (((u64)(Xil_In16((wmp_fsm)->fsm_desc.tran_base_addr + wmp_fsm_get_tran_offset_state(wmp_fsm, (s)) +		  \
			WMP_FSM_COUNTER_FIELD_SIZE + ((i) * WMP_FSM_BYTE_CODE_TRAN_SIZE) + 4))) & 0x000000000000FFFF)))

/**
 * Iterate over the fsm transition
 *
 * wmp_fsm is a pointer to a struct wmp_fsm
 * i is the loop index variable
 * during the i-th iteration tran (u64) has the value of the i-th transition
 * the macro assign the number of transition to tran_n(u16)
 */
#define wmp_fsm_for_each_tran(wmp_fsm, tran, tran_n, i)									\
		for ((i) = 0, (tran_n) = wmp_fsm_get_n_tran(wmp_fsm),							\
			(((i) < (tran_n)) && ((tran) = wmp_fsm_get_tran((wmp_fsm), (i)))); 			\
			(i) < (tran_n);																\
			(i)++, (((i) < (tran_n)) && ((tran) = wmp_fsm_get_tran((wmp_fsm), (i)))))

/**
 * Iterate over the fsm transition of state n
 *
 * wmp_fsm is a pointer to a struct wmp_fsm
 * i is the loop index variable
 * during the i-th iteration tran (u64) has the value of the i-th transition of state s
 * the macro assign the number of transition of state n to tran_n(u16)
 */
#define wmp_fsm_for_each_tran_state(wmp_fsm, tran, tran_n, s, i)									\
		for ((i) = 0, (tran_n) = wmp_fsm_get_n_tran_state(wmp_fsm, (s)),							\
			(((i) < (tran_n)) && ((tran) = wmp_fsm_get_tran_state((wmp_fsm), (i), (s)))); 			\
			(i) < (tran_n);																			\
			(i)++, (((i) < (tran_n)) && ((tran) = wmp_fsm_get_tran_state((wmp_fsm), (i), (s)))))

/**
 * Iterate over the condition/event of the transitions of state s
 *
 * wmp_fsm is a pointer to a struct wmp_fsm
 * i is the loop index variable
 * during the i-th iteration ev_cond (u64) has the value of the event/condition of the i-th transition of state s
 * the macro assign the number of transition of state n to tran_n(u16)
 */
#define wmp_fsm_for_each_ev_cond_tran_state(wmp_fsm, ev_cond, tran_n, s, i)										\
		for ((i) = 0, (tran_n) = wmp_fsm_get_n_tran_state(wmp_fsm, (s)),										\
			(((i) < (tran_n)) &&																					\
			((ev_cond) = (u8)WMP_TRANSITION_GET_EVENT_CONDITION(wmp_fsm_get_tran_state((wmp_fsm), (i), (s))))); \
			(i) < (tran_n); (i)++, (((i) < (tran_n)) &&																\
			((ev_cond) = (u8)WMP_TRANSITION_GET_EVENT_CONDITION(wmp_fsm_get_tran_state((wmp_fsm), (i), (s))))))

/**
 * This function initialize the fields of struct wmp_fsm.
 * Moreover it initializes the fsm_bram BRAM and the fsm MUTEX.
 *
 * wmp_fsm MUST be allocated by the caller.
 *
 * @param wmp_fsm: top level structure for wmp_fsm module
 * @param bram_id: fsm_buffer BRAM ID
 * @param mutex_id: fsm MUTEX ID
 *
 * @return: XST_SUCCESS if everything is OK, XST_FAILURE otherwise
 */
int wmp_fsm_init(struct wmp_fsm *wmp_fsm, u8 bram_id, u8 mutex_id);
/**
 * Initialize the field fsm_desc of struct fsm_wmp.
 *
 * It's not possible to acquire more than one FSM at the same time.
 * In order to acquire a new FSM, the caller must release the current one
 * using the function wmp_fsm_acquire.
 *
 * @param wmp_fsm: top level structure for wmp_fsm module
 * @param n: identify the memory block where the acuired FSM
 *           is stored and the corresponding mutex (count from 0)
 *
 * @return: XST_SUCCESS if everything is OK, XST_FAILURE otherwise
 */
int wmp_fsm_acquire(struct wmp_fsm *wmp_fsm, int n);
/**
 * Release the lock of a previous acuired FSM.
 *
 * The caller must be sure a FSM has been acquired succesfully
 * before calling this function.
 *
 * @param wmp_fsm: top level structure for wmp_fsm module
 *
 * @return: XST_SUCCESS if everything is OK, XST_FAILURE otherwise
 */
int wmp_fsm_release(struct wmp_fsm *wmp_fsm);

/**
 * Write fsm in the memory block currently acquired.
 *
 * @param wmp_fsm: top level structure for wmp_fsm module
 * @param fsm: byte code of the fsm to write in memory
 *
 * @return: 0 if everything is ok, -1 if fsm byte code is not correct
 */
int wmp_fsm_write(struct wmp_fsm *wmp_fsm, u8 *fsm);

/**
 * Debug function
 *
 * Print fsm in the memory block currently acquired.
 *
 * @param wmp_fsm: top level structure for wmp_fsm module
 *
 * @return: 0 if everything is ok, -1 if fsm byte code is not correct
 */
void wmp_fsm_dump(struct wmp_fsm *wmp_fsm);
