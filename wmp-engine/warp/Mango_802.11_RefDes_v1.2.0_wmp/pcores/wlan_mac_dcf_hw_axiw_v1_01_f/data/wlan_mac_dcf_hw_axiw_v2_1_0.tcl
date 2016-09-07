##############################################################################
##
## ***************************************************************************
## **                                                                       **
## ** Copyright (c) 1995-2010 Xilinx, Inc.  All rights reserved.            **
## **                                                                       **
## ** You may copy and modify these files for your own internal use solely  **
## ** with Xilinx programmable logic devices and Xilinx EDK system or       **
## ** create IP modules solely for Xilinx programmable logic devices and    **
## ** Xilinx EDK system. No rights are granted to distribute any files      **
## ** unless they are distributed in Xilinx programmable logic devices.     **
## **                                                                       **
## ***************************************************************************
##
##############################################################################

proc generate {drv_handle} {
    puts "Generating Macros for wlan_mac_dcf_hw_axiw driver access ... "

    # initialize
    lappend config_table
    lappend addr_config_table
    lappend xparam_config_table

    # hardware version
    lappend config_table "C_XC_VERSION"
    # Low-level function names
    lappend config_table "C_XC_CREATE" "C_XC_RELEASE" "C_XC_OPEN" "C_XC_CLOSE" "C_XC_READ" "C_XC_WRITE" "C_XC_GET_SHMEM"
    # Optional parameters
    # (empty)

    # Memory map information
    sg_lappend config_table addr_config_table "C_MEMMAP_TX_START_TIMESTAMP_MSB"
    sg_lappend config_table xparam_config_table "C_MEMMAP_TX_START_TIMESTAMP_MSB_N_BITS"
    sg_lappend config_table xparam_config_table "C_MEMMAP_TX_START_TIMESTAMP_MSB_BIN_PT"
    # sg_lappend config_table xparam_config_table "C_MEMMAP_TX_START_TIMESTAMP_MSB_ATTR"
    sg_lappend config_table addr_config_table "C_MEMMAP_TX_START_TIMESTAMP_LSB"
    sg_lappend config_table xparam_config_table "C_MEMMAP_TX_START_TIMESTAMP_LSB_N_BITS"
    sg_lappend config_table xparam_config_table "C_MEMMAP_TX_START_TIMESTAMP_LSB_BIN_PT"
    # sg_lappend config_table xparam_config_table "C_MEMMAP_TX_START_TIMESTAMP_LSB_ATTR"
    sg_lappend config_table addr_config_table "C_MEMMAP_NAV_VALUE"
    sg_lappend config_table xparam_config_table "C_MEMMAP_NAV_VALUE_N_BITS"
    sg_lappend config_table xparam_config_table "C_MEMMAP_NAV_VALUE_BIN_PT"
    # sg_lappend config_table xparam_config_table "C_MEMMAP_NAV_VALUE_ATTR"
    sg_lappend config_table addr_config_table "C_MEMMAP_RX_START_TIMESTAMP_MSB"
    sg_lappend config_table xparam_config_table "C_MEMMAP_RX_START_TIMESTAMP_MSB_N_BITS"
    sg_lappend config_table xparam_config_table "C_MEMMAP_RX_START_TIMESTAMP_MSB_BIN_PT"
    # sg_lappend config_table xparam_config_table "C_MEMMAP_RX_START_TIMESTAMP_MSB_ATTR"
    sg_lappend config_table addr_config_table "C_MEMMAP_RX_START_TIMESTAMP_LSB"
    sg_lappend config_table xparam_config_table "C_MEMMAP_RX_START_TIMESTAMP_LSB_N_BITS"
    sg_lappend config_table xparam_config_table "C_MEMMAP_RX_START_TIMESTAMP_LSB_BIN_PT"
    # sg_lappend config_table xparam_config_table "C_MEMMAP_RX_START_TIMESTAMP_LSB_ATTR"
    sg_lappend config_table addr_config_table "C_MEMMAP_RX_RATE_LENGTH"
    sg_lappend config_table xparam_config_table "C_MEMMAP_RX_RATE_LENGTH_N_BITS"
    sg_lappend config_table xparam_config_table "C_MEMMAP_RX_RATE_LENGTH_BIN_PT"
    # sg_lappend config_table xparam_config_table "C_MEMMAP_RX_RATE_LENGTH_ATTR"
    sg_lappend config_table addr_config_table "C_MEMMAP_TIMESTAMP_MSB"
    sg_lappend config_table xparam_config_table "C_MEMMAP_TIMESTAMP_MSB_N_BITS"
    sg_lappend config_table xparam_config_table "C_MEMMAP_TIMESTAMP_MSB_BIN_PT"
    # sg_lappend config_table xparam_config_table "C_MEMMAP_TIMESTAMP_MSB_ATTR"
    sg_lappend config_table addr_config_table "C_MEMMAP_TIMESTAMP_LSB"
    sg_lappend config_table xparam_config_table "C_MEMMAP_TIMESTAMP_LSB_N_BITS"
    sg_lappend config_table xparam_config_table "C_MEMMAP_TIMESTAMP_LSB_BIN_PT"
    # sg_lappend config_table xparam_config_table "C_MEMMAP_TIMESTAMP_LSB_ATTR"
    sg_lappend config_table addr_config_table "C_MEMMAP_LATEST_RX_BYTE"
    sg_lappend config_table xparam_config_table "C_MEMMAP_LATEST_RX_BYTE_N_BITS"
    sg_lappend config_table xparam_config_table "C_MEMMAP_LATEST_RX_BYTE_BIN_PT"
    # sg_lappend config_table xparam_config_table "C_MEMMAP_LATEST_RX_BYTE_ATTR"
    sg_lappend config_table addr_config_table "C_MEMMAP_STATUS"
    sg_lappend config_table xparam_config_table "C_MEMMAP_STATUS_N_BITS"
    sg_lappend config_table xparam_config_table "C_MEMMAP_STATUS_BIN_PT"
    # sg_lappend config_table xparam_config_table "C_MEMMAP_STATUS_ATTR"
    sg_lappend config_table addr_config_table "C_MEMMAP_AUTO_TX_PARAMS"
    sg_lappend config_table xparam_config_table "C_MEMMAP_AUTO_TX_PARAMS_N_BITS"
    sg_lappend config_table xparam_config_table "C_MEMMAP_AUTO_TX_PARAMS_BIN_PT"
    # sg_lappend config_table xparam_config_table "C_MEMMAP_AUTO_TX_PARAMS_ATTR"
    sg_lappend config_table addr_config_table "C_MEMMAP_CALIB_TIMES"
    sg_lappend config_table xparam_config_table "C_MEMMAP_CALIB_TIMES_N_BITS"
    sg_lappend config_table xparam_config_table "C_MEMMAP_CALIB_TIMES_BIN_PT"
    # sg_lappend config_table xparam_config_table "C_MEMMAP_CALIB_TIMES_ATTR"
    sg_lappend config_table addr_config_table "C_MEMMAP_IFS_INTERVALS2"
    sg_lappend config_table xparam_config_table "C_MEMMAP_IFS_INTERVALS2_N_BITS"
    sg_lappend config_table xparam_config_table "C_MEMMAP_IFS_INTERVALS2_BIN_PT"
    # sg_lappend config_table xparam_config_table "C_MEMMAP_IFS_INTERVALS2_ATTR"
    sg_lappend config_table addr_config_table "C_MEMMAP_IFS_INTERVALS1"
    sg_lappend config_table xparam_config_table "C_MEMMAP_IFS_INTERVALS1_N_BITS"
    sg_lappend config_table xparam_config_table "C_MEMMAP_IFS_INTERVALS1_BIN_PT"
    # sg_lappend config_table xparam_config_table "C_MEMMAP_IFS_INTERVALS1_ATTR"
    sg_lappend config_table addr_config_table "C_MEMMAP_TX_START"
    sg_lappend config_table xparam_config_table "C_MEMMAP_TX_START_N_BITS"
    sg_lappend config_table xparam_config_table "C_MEMMAP_TX_START_BIN_PT"
    # sg_lappend config_table xparam_config_table "C_MEMMAP_TX_START_ATTR"
    sg_lappend config_table addr_config_table "C_MEMMAP_MPDU_TX_PARAMS"
    sg_lappend config_table xparam_config_table "C_MEMMAP_MPDU_TX_PARAMS_N_BITS"
    sg_lappend config_table xparam_config_table "C_MEMMAP_MPDU_TX_PARAMS_BIN_PT"
    # sg_lappend config_table xparam_config_table "C_MEMMAP_MPDU_TX_PARAMS_ATTR"
    sg_lappend config_table addr_config_table "C_MEMMAP_CONTROL"
    sg_lappend config_table xparam_config_table "C_MEMMAP_CONTROL_N_BITS"
    sg_lappend config_table xparam_config_table "C_MEMMAP_CONTROL_BIN_PT"
    # sg_lappend config_table xparam_config_table "C_MEMMAP_CONTROL_ATTR"
    sg_lappend config_table addr_config_table "C_MEMMAP_TIMESTAMP_SET_LSB"
    sg_lappend config_table xparam_config_table "C_MEMMAP_TIMESTAMP_SET_LSB_N_BITS"
    sg_lappend config_table xparam_config_table "C_MEMMAP_TIMESTAMP_SET_LSB_BIN_PT"
    # sg_lappend config_table xparam_config_table "C_MEMMAP_TIMESTAMP_SET_LSB_ATTR"
    sg_lappend config_table addr_config_table "C_MEMMAP_TIMESTAMP_SET_MSB"
    sg_lappend config_table xparam_config_table "C_MEMMAP_TIMESTAMP_SET_MSB_N_BITS"
    sg_lappend config_table xparam_config_table "C_MEMMAP_TIMESTAMP_SET_MSB_BIN_PT"
    # sg_lappend config_table xparam_config_table "C_MEMMAP_TIMESTAMP_SET_MSB_ATTR"
    sg_lappend config_table addr_config_table "C_MEMMAP_BACKOFF_CTRL"
    sg_lappend config_table xparam_config_table "C_MEMMAP_BACKOFF_CTRL_N_BITS"
    sg_lappend config_table xparam_config_table "C_MEMMAP_BACKOFF_CTRL_BIN_PT"
    # sg_lappend config_table xparam_config_table "C_MEMMAP_BACKOFF_CTRL_ATTR"
    sg_lappend config_table addr_config_table "C_MEMMAP_MPDU_TX_GAINS"
    sg_lappend config_table xparam_config_table "C_MEMMAP_MPDU_TX_GAINS_N_BITS"
    sg_lappend config_table xparam_config_table "C_MEMMAP_MPDU_TX_GAINS_BIN_PT"
    # sg_lappend config_table xparam_config_table "C_MEMMAP_MPDU_TX_GAINS_ATTR"
    sg_lappend config_table addr_config_table "C_MEMMAP_AUTO_TX_GAINS"
    sg_lappend config_table xparam_config_table "C_MEMMAP_AUTO_TX_GAINS_N_BITS"
    sg_lappend config_table xparam_config_table "C_MEMMAP_AUTO_TX_GAINS_BIN_PT"
    # sg_lappend config_table xparam_config_table "C_MEMMAP_AUTO_TX_GAINS_ATTR"
    sg_lappend config_table addr_config_table "C_MEMMAP_TIMESTAMP_INSERT_OFFSET"
    sg_lappend config_table xparam_config_table "C_MEMMAP_TIMESTAMP_INSERT_OFFSET_N_BITS"
    sg_lappend config_table xparam_config_table "C_MEMMAP_TIMESTAMP_INSERT_OFFSET_BIN_PT"
    # sg_lappend config_table xparam_config_table "C_MEMMAP_TIMESTAMP_INSERT_OFFSET_ATTR"

    # XPS parameters
    sg_lappend config_table xparam_config_table "DEVICE_ID" "C_BASEADDR"

    # generate xparameters.h
    eval xdefine_include_file $drv_handle "xparameters.h" "WLAN_MAC_DCF_HW_AXIW" "NUM_INSTANCES" ${xparam_config_table}
    eval sg_xdefine_include_file $drv_handle "xparameters.h" "WLAN_MAC_DCF_HW_AXIW" ${addr_config_table}
    # generate wlan_mac_dcf_hw_axiw_g.c
    eval xdefine_config_file $drv_handle "wlan_mac_dcf_hw_axiw_g.c" "WLAN_MAC_DCF_HW_AXIW" ${config_table}
}

proc sg_xdefine_include_file {drv_handle file_name drv_string args} {
    # Open include file
    set file_handle [xopen_include_file $file_name]

    # Get all peripherals connected to this driver
    set periphs [xget_periphs $drv_handle] 

    # Print all parameters for all peripherals
    set device_id 0
    foreach periph ${periphs} {
        # base_addr of the peripheral
        set base_addr [xget_param_value ${periph} "C_BASEADDR"]

        puts ${file_handle} ""
        puts ${file_handle} "/* Definitions (address parameters) for peripheral [string toupper [xget_hw_name $periph]] */"
        foreach arg ${args} {
            set value [xget_param_value ${periph} ${arg}]
            if {[llength ${value}] == 0} {
                set value 0
            }
            set value [expr ${base_addr} + ${value}]
            set value_str [xformat_address_string ${value}]
            puts ${file_handle} "#define [xget_name ${periph} ${arg}] ${value_str}"
        }

        puts $file_handle "/* software driver settings for peripheral [string toupper [xget_hw_name $periph]] */"
        puts $file_handle "#define XPAR_[string toupper [xget_hw_name ${periph}]]_XC_VERSION   1"
        puts $file_handle "#define XPAR_[string toupper [xget_hw_name ${periph}]]_XC_CREATE    xc_wlan_mac_dcf_hw_axiw_create"
        puts $file_handle "#define XPAR_[string toupper [xget_hw_name ${periph}]]_XC_RELEASE   xc_wlan_mac_dcf_hw_axiw_release"
        puts $file_handle "#define XPAR_[string toupper [xget_hw_name ${periph}]]_XC_OPEN      xc_wlan_mac_dcf_hw_axiw_open"
        puts $file_handle "#define XPAR_[string toupper [xget_hw_name ${periph}]]_XC_CLOSE     xc_wlan_mac_dcf_hw_axiw_close"
        puts $file_handle "#define XPAR_[string toupper [xget_hw_name ${periph}]]_XC_READ      xc_wlan_mac_dcf_hw_axiw_read"
        puts $file_handle "#define XPAR_[string toupper [xget_hw_name ${periph}]]_XC_WRITE     xc_wlan_mac_dcf_hw_axiw_write"
        puts $file_handle "#define XPAR_[string toupper [xget_hw_name ${periph}]]_XC_GET_SHMEM xc_wlan_mac_dcf_hw_axiw_getshmem"

        puts $file_handle ""
    }		
    puts $file_handle "\n/******************************************************************/\n"
    close $file_handle
}

proc sg_lappend {required_config_table {extra_config_table ""} args} {
    upvar ${required_config_table} config_table_1
    if {[string length ${extra_config_table}] != 0} {
        upvar ${extra_config_table} config_table_2
    }

    foreach value ${args} {
        eval [list lappend config_table_1 ${value}]
        if {[string length ${extra_config_table}] != 0} {
            lappend config_table_2 ${value}
        }
    }
}
