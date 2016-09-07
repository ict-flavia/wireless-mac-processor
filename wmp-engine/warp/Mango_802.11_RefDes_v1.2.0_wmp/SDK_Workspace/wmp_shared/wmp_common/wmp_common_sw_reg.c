/*
 * wmp_common_sw_register.c
 *
 *  Created on: 04/nov/2013
 *      Author: Nicolo' Facchi
 */

#include "wmp_common_sw_reg.h"

/********************************************************
 ********************************************************
 *					SW Registers
 ********************************************************
 ********************************************************/

struct wmp_common_sw_reg wmp_common_sw_reg_container;



/********************************************************
 ********************************************************
 *					Interface implementation
 ********************************************************
 ********************************************************/

struct wmp_common_sw_reg *wmp_common_sw_reg_get_container()
{
	return &wmp_common_sw_reg_container;
}
