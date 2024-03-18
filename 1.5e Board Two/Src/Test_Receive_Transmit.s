.syntax unified
.thumb


.global main


#include "initialise.s"
#include "transmit.s"
#include "receive.s"
#include "Display_from_Bitmap.s"



.data
@ define variables


.data

@ Preallocate space for the received string, 64 bytes in memory
incoming_buffer: .space 64

@ Counter to ensure we dont exceed buffer
incoming_counter: .byte 64


.text


main:

 	BL initialise_power
	BL enable_peripheral_clocks
	BL initialise_discovery_board
	BL enable_uart
	BL change_clock_speed

loop:

	LDR R1, =incoming_buffer
	LDR R2, =incoming_counter

	LDRB R2, [R2]

	@ Receive from board1
	PUSH {R1}
	LDR R0, =#1
	BL receive_string
	POP {R1}

	PUSH {R1}
	LDR R1, =#0b11111111
	BL display_from_bitmap
	POP {R1}

	@ Transmit to board1
	LDR R0, =#1
	BL transmit_string_button

	PUSH {R1}
	LDR R1, =#0b00000000
	BL display_from_bitmap
	POP {R1}

	B loop

