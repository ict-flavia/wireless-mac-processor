################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/wlan_exp_node_sta.c \
../src/wlan_mac_sta_uart_menu.c \
../src/wmp_high.c \
../src/wmp_high_ap.c \
../src/wmp_high_fsm_slots_handler.c \
../src/wmp_high_util.c 

LD_SRCS += \
../src/lscript.ld 

OBJS += \
./src/wlan_exp_node_sta.o \
./src/wlan_mac_sta_uart_menu.o \
./src/wmp_high.o \
./src/wmp_high_ap.o \
./src/wmp_high_fsm_slots_handler.o \
./src/wmp_high_util.o 

C_DEPS += \
./src/wlan_exp_node_sta.d \
./src/wlan_mac_sta_uart_menu.d \
./src/wmp_high.d \
./src/wmp_high_ap.d \
./src/wmp_high_fsm_slots_handler.d \
./src/wmp_high_util.d 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.c
	@echo Building file: $<
	@echo Invoking: MicroBlaze gcc compiler
	mb-gcc -Wall -O0 -g3 -I../../wlan_bsp_cpu_high/mb_high/include -I"C:\Users\Alice\Desktop\Mango_802.11_RefDes_v1.2.0\SDK_Workspace\wmp_high\src\include" -I"C:\Users\Alice\Desktop\Mango_802.11_RefDes_v1.2.0\SDK_Workspace\wmp_shared\wlan_mac_common\include" -I"C:\Users\Alice\Desktop\Mango_802.11_RefDes_v1.2.0\SDK_Workspace\wmp_shared\wlan_mac_high_framework\include" -I"C:\Users\Alice\Desktop\Mango_802.11_RefDes_v1.2.0\SDK_Workspace\wmp_shared\wmp_common\include" -c -fmessage-length=0 -Wl,--no-relax -mlittle-endian -mxl-barrel-shift -mxl-pattern-compare -mcpu=v8.40.b -mno-xl-soft-mul -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o"$@" "$<"
	@echo Finished building: $<
	@echo ' '


