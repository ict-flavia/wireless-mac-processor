################################################################################
# Automatically-generated file. Do not edit!
################################################################################

-include ../makefile.init

RM := rm -rf

# All of the sources participating in the build are defined here
-include sources.mk
-include subdir.mk
-include wmp_common/subdir.mk
-include wlan_mac_high_framework/subdir.mk
-include wlan_mac_common/subdir.mk
-include src/subdir.mk
-include objects.mk

ifneq ($(MAKECMDGOALS),clean)
ifneq ($(strip $(C_DEPS)),)
-include $(C_DEPS)
endif
ifneq ($(strip $(S_UPPER_DEPS)),)
-include $(S_UPPER_DEPS)
endif
endif

-include ../makefile.defs

# Add inputs and outputs from these tool invocations to the build variables 
ELFSIZE += \
wmp_high.elf.size \

ELFCHECK += \
wmp_high.elf.elfcheck \


# All Target
all: wmp_high.elf secondary-outputs

# Tool invocations
wmp_high.elf: $(OBJS) ../src/lscript.ld $(USER_OBJS)
	@echo Building target: $@
	@echo Invoking: MicroBlaze gcc linker
	mb-gcc -Wl,--no-relax -Wl,-T -Wl,../src/lscript.ld -L../../wlan_bsp_cpu_high/mb_high/lib -mlittle-endian -mxl-barrel-shift -mxl-pattern-compare -mcpu=v8.40.b -mno-xl-soft-mul -o"wmp_high.elf" $(OBJS) $(USER_OBJS) $(LIBS)
	@echo Finished building target: $@
	@echo ' '

wmp_high.elf.size: wmp_high.elf
	@echo Invoking: MicroBlaze Print Size
	mb-size wmp_high.elf  |tee "wmp_high.elf.size"
	@echo Finished building: $@
	@echo ' '

wmp_high.elf.elfcheck: wmp_high.elf
	@echo Invoking: Xilinx ELF Check
	elfcheck wmp_high.elf -hw ../../wlan_xps_v32_hw_platform/system.xml -pe mb_high  |tee "wmp_high.elf.elfcheck"
	@echo Finished building: $@
	@echo ' '

# Other Targets
clean:
	-$(RM) $(OBJS)$(C_DEPS)$(EXECUTABLES)$(ELFSIZE)$(ELFCHECK)$(S_UPPER_DEPS) wmp_high.elf
	-@echo ' '

secondary-outputs: $(ELFSIZE) $(ELFCHECK)

.PHONY: all clean dependents
.SECONDARY:

-include ../makefile.targets
