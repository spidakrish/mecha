################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (11.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
S_SRCS += \
../Src/Display_from_Bitmap.s \
../Src/Test_Receive_Transmit.s \
../Src/Transmit.s \
../Src/definitions.s \
../Src/initialise.s \
../Src/receive.s 

OBJS += \
./Src/Display_from_Bitmap.o \
./Src/Test_Receive_Transmit.o \
./Src/Transmit.o \
./Src/definitions.o \
./Src/initialise.o \
./Src/receive.o 

S_DEPS += \
./Src/Display_from_Bitmap.d \
./Src/Test_Receive_Transmit.d \
./Src/Transmit.d \
./Src/definitions.d \
./Src/initialise.d \
./Src/receive.d 


# Each subdirectory must supply rules for building sources it contributes
Src/%.o: ../Src/%.s Src/subdir.mk
	arm-none-eabi-gcc -mcpu=cortex-m4 -g3 -DDEBUG -c -x assembler-with-cpp -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@" "$<"

clean: clean-Src

clean-Src:
	-$(RM) ./Src/Display_from_Bitmap.d ./Src/Display_from_Bitmap.o ./Src/Test_Receive_Transmit.d ./Src/Test_Receive_Transmit.o ./Src/Transmit.d ./Src/Transmit.o ./Src/definitions.d ./Src/definitions.o ./Src/initialise.d ./Src/initialise.o ./Src/receive.d ./Src/receive.o

.PHONY: clean-Src

