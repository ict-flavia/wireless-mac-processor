################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/wmp_action.c \
../src/wmp_event_condition.c \
../src/wmp_low.c \
../src/wmp_parameter.c \
../src/wmp_sw_reg.c \
../src/wmp_util.c 

LD_SRCS += \
../src/lscript.ld 

OBJS += \
./src/wmp_action.o \
./src/wmp_event_condition.o \
./src/wmp_low.o \
./src/wmp_parameter.o \
./src/wmp_sw_reg.o \
./src/wmp_util.o 

C_DEPS += \
./src/wmp_action.d \
./src/wmp_event_condition.d \
./src/wmp_low.d \
./src/wmp_parameter.d \
./src/wmp_sw_reg.d \
./src/wmp_util.d 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.c
	@echo Building file: $<
	@echo Invoking: MicroBlaze gcc compiler
	mb-gcc -Wall -O3 -I../../wlan_bsp_cpu_low/mb_low/include -I"C:\Users\Alice\Desktop\wmp4warp\RefDes_v0.6_wmp\SDK_Workspace\wmp_low\src\include" -I"C:\Users\Alice\Desktop\wmp4warp\RefDes_v0.6_wmp\SDK_Workspace\wmp_shared\wlan_mac_common\include" -I"C:\Users\Alice\Desktop\wmp4warp\RefDes_v0.6_wmp\SDK_Workspace\wmp_shared\wlan_mac_high_framework\include" -I"C:\Users\Alice\Desktop\wmp4warp\RefDes_v0.6_wmp\SDK_Workspace\wmp_shared\wlan_mac_low\include" -I"C:\Users\Alice\Desktop\wmp4warp\RefDes_v0.6_wmp\SDK_Workspace\wmp_shared\wmp_common\include" -c -fmessage-length=0 -I../../wlan_bsp_cpu_low/mb_low/include -mlittle-endian -mxl-barrel-shift -mxl-pattern-compare -mcpu=v8.40.b -mno-xl-soft-mul -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o"$@" "$<"
	@echo Finished building: $<
	@echo ' '


