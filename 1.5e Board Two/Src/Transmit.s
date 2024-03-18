.syntax unified
.thumb


#include "definitions.s"


.text


transmit_string_button:
	LDR R2, =GPIOA	@ port for the input button
	LDR R3, [R2, IDR]
	TST R3, #0x1
	BEQ transmit_string_button


button_up:
	LDR R2, =GPIOA	@ port for the input button
	LDR R3, [R2, IDR]
	TST R3, #0x1
	BNE button_up

transmit_string:
	@ Transmits the string in register R1
	@ R2 = transmit UART setting, 0 for USART1, 1 for UART2
	@ Call transmit_string button to wait for button press


	@ Use USART if R0 = 0 otherwise use UART
	CMP R0, #0
	LDR R0, =USART
	BEQ tx_uart
	LDR R0, =UART

tx_uart:

	LDR R2, [R0, USART_ISR] @ load the status of the UART
	ANDS R2, 1 << UART_TXE  @ 'AND' the current status with the bit mask that we are interested in
						    @ NOTE, the ANDS is used so that if the result is '0' the z register flag is set

	@ loop back to check status again if the flag indicates there is no byte waiting
	BEQ tx_uart

	@ load the next value in the string into the transmit buffer for the specified UART
	LDRB R3, [R1], #1
	STRB R3, [R0, USART_TDR]

	@ note the use of the S on the end of the SUBS, this means that the register flags are set
	@ and this subtraction can be used to make a branch

	CMP R3, #0

	@ keep looping while there are more characters to send
	BNE tx_uart

	@ make a delay before sending again
	BX LR

