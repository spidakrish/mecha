################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (11.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
S_SRCS += \
../Src/Count_and_Display_Letters.s \
../Src/Display_from_Bitmap.s \
../Src/Substitution_Cipher.s \
../Src/Transmit.s \
../Src/definitions.s \
../Src/initialise.s \
../Src/main.s \
../Src/receive.s 

OBJS += \
./Src/Count_and_Display_Letters.o \
./Src/Display_from_Bitmap.o \
./Src/Substitution_Cipher.o \
./Src/Transmit.o \
./Src/definitions.o \
./Src/initialise.o \
./Src/main.o \
./Src/receive.o 

S_DEPS += \
./Src/Count_and_Display_Letters.d \
./Src/Display_from_Bitmap.d \
./Src/Substitution_Cipher.d \
./Src/Transmit.d \
./Src/definitions.d \
./Src/initialise.d \
./Src/main.d \
./Src/receive.d 


# Each subdirectory must supply rules for building sources it contributes
Src/%.o: ../Src/%.s Src/subdir.mk
	arm-none-eabi-gcc -mcpu=cortex-m4 -g3 -DDEBUG -c -x assembler-with-cpp -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@" "$<"

clean: clean-Src

clean-Src:
	-$(RM) ./Src/Count_and_Display_Letters.d ./Src/Count_and_Display_Letters.o ./Src/Display_from_Bitmap.d ./Src/Display_from_Bitmap.o ./Src/Substitution_Cipher.d ./Src/Substitution_Cipher.o ./Src/Transmit.d ./Src/Transmit.o ./Src/definitions.d ./Src/definitions.o ./Src/initialise.d ./Src/initialise.o ./Src/main.d ./Src/main.o ./Src/receive.d ./Src/receive.o

.PHONY: clean-Src

