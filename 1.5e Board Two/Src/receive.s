.syntax unified
.thumb

#include "definitions.s"


.text
@ continue reading forever (NOTE: eventually it will run out of memory as we don't have a big buffer)
receive_string:
	@ R1 = String pointer
	@ R2 = Max string length

	LDR R3, =#0

	@ Use USART if R0 = 0 otherwise use UART
	CMP R0, #0
	LDR R0, =USART
	LDR R6, =#0x30
	BEQ rx_loop
	LDR R0, =UART
	LDR R6, =#0

rx_loop:

	LDR R5, [R0, USART_ISR] @ load the status of the UART

	TST R5, 1 << UART_ORE | 1 << UART_FE  @ 'AND' the current status with the bit mask that we are interested in
						   @ NOTE, the ANDS is used so that if the result is '0' the z register flag is set

	BNE clear_error

	TST R5, 1 << UART_RXNE @ 'AND' the current status with the bit mask that we are interested in
							  @ NOTE, the ANDS is used so that if the result is '0' the z register flag is set

	BEQ rx_loop @ loop back to check status again if the flag indicates there is no byte waiting

	LDRB R4, [R0, USART_RDR] @ load the lowest byte (RDR bits [0:7] for an 8 bit read)
	STRB R4, [R1, R3]
	ADD R3, #1

	@ Check whether max size reached
	CMP R3, R2
	BGT exit

	@ Check for terminating character
	CMP R4, R6
	BEQ exit


no_reset:

	@ load the status of the UART
	LDR R5, [R0, USART_RQR]
	ORR R5, 1 << UART_RXFRQ
	STR R5, [R0, USART_RQR]

	BGT rx_loop


clear_error:

	@ Clear the overrun/frame error flag in the register USART_ICR (see page 897)
	LDR R5, [R0, USART_ICR]
	ORR R5, 1 << UART_ORECF | 1 << UART_FECF @ clear the flags (by setting flags to 1)
	STR R5, [R0, USART_ICR]
	B rx_loop

exit:
	SUB R3, #1
	LDRB R4, =#0
	STRB R4, [R1, R3]
	BX LR
