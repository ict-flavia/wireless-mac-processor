/*
 * wmp_fsm.c
 *
 *  Created on: Oct 9, 2013
 *      Author: Nicolo' Facchi
 */

#include "wmp_fsm.h"
#include "xparameters.h"
#include "xil_io.h"


int wmp_fsm_init(struct wmp_fsm *wmp_fsm, u8 bram_id, u8 mutex_id)
{
    XBram_Config *fsm_bram_config;
    XMutex_Config *fsm_mutex_config;
    XStatus ret_status;
    u32 i;

	wmp_fsm->fsm_buffer_bram_id = bram_id;
	wmp_fsm->fsm_mutex_id = mutex_id;

	fsm_bram_config = XBram_LookupConfig(XPAR_FSM_BUFFER_CTRL_DEVICE_ID);
	if (fsm_bram_config == (XBram_Config *) NULL) {
			xil_printf("ERROR: Configuration table for FSM BRAM doesn't exist!\n");
			return XST_FAILURE;
	}

	ret_status = XBram_CfgInitialize(&(wmp_fsm->fsm_bram), fsm_bram_config,
								 fsm_bram_config->CtrlBaseAddress);
	if (ret_status != XST_SUCCESS) {
			xil_printf("ERROR: FSM BRAM initialization failed!\n");
			return XST_FAILURE;
	}

	fsm_mutex_config = XMutex_LookupConfig(XPAR_MUTEX_0_DEVICE_ID);
	if (fsm_mutex_config == (XMutex_Config *)NULL) {
			xil_printf("ERROR: Configuration table for FSM mutex doesn't exist!\n");
			return XST_FAILURE;
	}

	ret_status = XMutex_CfgInitialize(&(wmp_fsm->fsm_mutex), fsm_mutex_config,
									fsm_mutex_config->BaseAddress);
	if (ret_status != XST_SUCCESS) {
			xil_printf("ERROR: FSM mutex initialization failed!\n");
			return XST_FAILURE;
	}

	return XST_SUCCESS;
}

int wmp_fsm_acquire(struct wmp_fsm *wmp_fsm, int n)
{
	if (XMutex_Trylock(&(wmp_fsm->fsm_mutex), n) != XST_SUCCESS) {
		xil_printf("ERROR: FSM mutex %d acquisition failed!\n", n);
		return XST_FAILURE;
	}

	wmp_fsm->fsm_desc.base_addr = WMP_FSM_BUFFER_BASE_ADDR(wmp_fsm, n);
	wmp_fsm->fsm_desc.length = WMP_FSM_LENGTH;
	wmp_fsm->fsm_desc.last_addr = wmp_fsm->fsm_desc.base_addr +
										wmp_fsm->fsm_desc.length - 1;

	wmp_fsm->fsm_desc.param_base_addr = WMP_FSM_BUFFER_PARAM_BASE_ADDR(wmp_fsm, n);
	wmp_fsm->fsm_desc.param_length = WMP_FSM_PARAM_SECTION_SIZE_DEFAULT;
	wmp_fsm->fsm_desc.param_last_addr = wmp_fsm->fsm_desc.param_base_addr +
												wmp_fsm->fsm_desc.param_length - 1;

	wmp_fsm->fsm_desc.state_base_addr = WMP_FSM_BUFFER_STATE_BASE_ADDR(wmp_fsm, n);
	wmp_fsm->fsm_desc.state_length = WMP_FSM_STATE_SECTION_SIZE_DEFAULT;
	wmp_fsm->fsm_desc.state_last_addr = wmp_fsm->fsm_desc.state_base_addr +
												wmp_fsm->fsm_desc.state_length - 1;

	wmp_fsm->fsm_desc.tran_base_addr = WMP_FSM_BUFFER_TRAN_BASE_ADDR(wmp_fsm, n);
	wmp_fsm->fsm_desc.tran_length = WMP_FSM_TRAN_SECTION_SIZE_DEFAULT;
	wmp_fsm->fsm_desc.tran_last_addr = wmp_fsm->fsm_desc.tran_base_addr +
												wmp_fsm->fsm_desc.tran_length - 1;

	wmp_fsm->fsm_desc.mutex_n = n;

	return XST_SUCCESS;
}

int wmp_fsm_release(struct wmp_fsm *wmp_fsm)
{
	if (XMutex_Unlock(&(wmp_fsm->fsm_mutex), wmp_fsm->fsm_desc.mutex_n) != XST_SUCCESS) {
		xil_printf("ERROR: FSM mutex %d release failed! Exiting\n", wmp_fsm->fsm_desc.mutex_n);
		return XST_FAILURE;
	}

	return XST_SUCCESS;
}

int wmp_fsm_write(struct wmp_fsm *wmp_fsm, u8 *fsm)
{
	u16 param_counter = 0;
	u16 state_counter = 0;
	u16 tran_counter = 0;
	u16 tmp_out_tran, tmp_out_tran_offset, tmp_state, k;
	u32 i;

	//Reset to 0 this slot
	for( i = wmp_fsm->fsm_desc.param_base_addr; i < wmp_fsm->fsm_desc.last_addr; i += 4) {
		Xil_Out32(i, 0);
	}

	if (!WMP_FSM_BYTE_CODE_START_TAG_PARSE(fsm)) {
		xil_printf("wmp_fsm_write: byte code start tag parse error (0x%02X, 0x%02X, 0x%02X)\n",
				*(fsm), *(fsm + 1), *(fsm + 2));
		return -1;
	}

	fsm += WMP_FSM_BYTE_CODE_START_TAG_SIZE;

	while (WMP_FSM_BYTE_CODE_PARAM_TAG_PARSE(fsm)) {
		fsm += WMP_FSM_BYTE_CODE_PARAM_TAG_SIZE;
		Xil_Out16(wmp_fsm->fsm_desc.param_base_addr + WMP_FSM_COUNTER_FIELD_SIZE +
				(param_counter * WMP_FSM_BYTE_CODE_PARAM_SIZE), (WMP_FSM_SWAP_BYTES(fsm)));
		fsm += WMP_FSM_BYTE_CODE_PARAM_SIZE;
		param_counter++;
	}

	Xil_Out16(wmp_fsm->fsm_desc.param_base_addr, param_counter);

	while (WMP_FSM_BYTE_CODE_STATE_TAG_PARSE(fsm)) {
		fsm += WMP_FSM_BYTE_CODE_STATE_TAG_SIZE;
		tmp_state = WMP_FSM_SWAP_BYTES(fsm);
		tmp_out_tran = WMP_STATE_GET_OUT_TRAN(tmp_state) + 1;
		tmp_out_tran_offset = WMP_STATE_GET_OUT_TRAN_OFFSET(tmp_state);
		Xil_Out16(wmp_fsm->fsm_desc.state_base_addr + WMP_FSM_COUNTER_FIELD_SIZE +
						(state_counter * WMP_FSM_BYTE_CODE_STATE_SIZE), tmp_state);
		fsm += WMP_FSM_BYTE_CODE_STATE_SIZE;
		state_counter++;
		tran_counter += tmp_out_tran;

		if (!WMP_FSM_BYTE_CODE_TRAN_TAG_PARSE(fsm)) {
			xil_printf("wmp_fsm_write: byte code tran tag parse error (0x%02X, 0x%02X, 0x%02X) (state_counter %d)\n",
									*(fsm), *(fsm + 1), *(fsm + 2), state_counter);
			return -1;
		}

		fsm += WMP_FSM_BYTE_CODE_TRAN_TAG_SIZE;

		for (k = 0; k < (tmp_out_tran * 3); k++) {
			Xil_Out16(wmp_fsm->fsm_desc.tran_base_addr + WMP_FSM_COUNTER_FIELD_SIZE +
							(tmp_out_tran_offset * 2) + (k * 2), (WMP_FSM_SWAP_BYTES(fsm)));
			fsm += 2;
		}
	}

	Xil_Out16(wmp_fsm->fsm_desc.state_base_addr, state_counter);
	Xil_Out16(wmp_fsm->fsm_desc.tran_base_addr, tran_counter);

	if (!WMP_FSM_BYTE_CODE_END_TAG_PARSE(fsm)) {
		xil_printf("wmp_fsm_write: byte code end tag parse error (0x%02X, 0x%02X, 0x%02X)\n",
						*(fsm), *(fsm + 1), *(fsm + 2));
		return -1;
	}

	return 0;
}

void wmp_fsm_dump(struct wmp_fsm *wmp_fsm)
{
	u32 k;

	for (k = 0; k < wmp_fsm->fsm_desc.length; k++) {
		if (!(k % 16)) {
			xil_printf("\n");
			xil_printf("0x%08X:", k);
		}

		xil_printf("0x%02X, ", Xil_In8(wmp_fsm->fsm_desc.base_addr + k));
	}

	xil_printf("\n\n");
}
