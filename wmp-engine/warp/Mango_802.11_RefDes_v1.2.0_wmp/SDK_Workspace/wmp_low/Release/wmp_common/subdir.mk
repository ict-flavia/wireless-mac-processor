################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
C:/Users/Alice/Desktop/wmp4warp/RefDes_v0.6_wmp/SDK_Workspace/wmp_shared/wmp_common/wmp_common_sw_reg.c \
C:/Users/Alice/Desktop/wmp4warp/RefDes_v0.6_wmp/SDK_Workspace/wmp_shared/wmp_common/wmp_fsm.c 

OBJS += \
./wmp_common/wmp_common_sw_reg.o \
./wmp_common/wmp_fsm.o 

C_DEPS += \
./wmp_common/wmp_common_sw_reg.d \
./wmp_common/wmp_fsm.d 


# Each subdirectory must supply rules for building sources it contributes
wmp_common/wmp_common_sw_reg.o: C:/Users/Alice/Desktop/wmp4warp/RefDes_v0.6_wmp/SDK_Workspace/wmp_shared/wmp_common/wmp_common_sw_reg.c
	@echo Building file: $<
	@echo Invoking: MicroBlaze gcc compiler
	mb-gcc -Wall -O3 -I../../wlan_bsp_cpu_low/mb_low/include -I"C:\Users\Alice\Desktop\wmp4warp\RefDes_v0.6_wmp\SDK_Workspace\wmp_low\src\include" -I"C:\Users\Alice\Desktop\wmp4warp\RefDes_v0.6_wmp\SDK_Workspace\wmp_shared\wlan_mac_common\include" -I"C:\Users\Alice\Desktop\wmp4warp\RefDes_v0.6_wmp\SDK_Workspace\wmp_shared\wlan_mac_high_framework\include" -I"C:\Users\Alice\Desktop\wmp4warp\RefDes_v0.6_wmp\SDK_Workspace\wmp_shared\wlan_mac_low\include" -I"C:\Users\Alice\Desktop\wmp4warp\RefDes_v0.6_wmp\SDK_Workspace\wmp_shared\wmp_common\include" -c -fmessage-length=0 -I../../wlan_bsp_cpu_low/mb_low/include -mlittle-endian -mxl-barrel-shift -mxl-pattern-compare -mcpu=v8.40.b -mno-xl-soft-mul -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o"$@" "$<"
	@echo Finished building: $<
	@echo ' '

wmp_common/wmp_fsm.o: C:/Users/Alice/Desktop/wmp4warp/RefDes_v0.6_wmp/SDK_Workspace/wmp_shared/wmp_common/wmp_fsm.c
	@echo Building file: $<
	@echo Invoking: MicroBlaze gcc compiler
	mb-gcc -Wall -O3 -I../../wlan_bsp_cpu_low/mb_low/include -I"C:\Users\Alice\Desktop\wmp4warp\RefDes_v0.6_wmp\SDK_Workspace\wmp_low\src\include" -I"C:\Users\Alice\Desktop\wmp4warp\RefDes_v0.6_wmp\SDK_Workspace\wmp_shared\wlan_mac_common\include" -I"C:\Users\Alice\Desktop\wmp4warp\RefDes_v0.6_wmp\SDK_Workspace\wmp_shared\wlan_mac_high_framework\include" -I"C:\Users\Alice\Desktop\wmp4warp\RefDes_v0.6_wmp\SDK_Workspace\wmp_shared\wlan_mac_low\include" -I"C:\Users\Alice\Desktop\wmp4warp\RefDes_v0.6_wmp\SDK_Workspace\wmp_shared\wmp_common\include" -c -fmessage-length=0 -I../../wlan_bsp_cpu_low/mb_low/include -mlittle-endian -mxl-barrel-shift -mxl-pattern-compare -mcpu=v8.40.b -mno-xl-soft-mul -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o"$@" "$<"
	@echo Finished building: $<
	@echo ' '


