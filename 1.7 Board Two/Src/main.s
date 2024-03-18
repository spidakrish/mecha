.syntax unified
.thumb


.global main


#include "initialise.s"
#include "transmit.s"
#include "receive.s"
#include "Substitution_Cipher.s"
#include "Count_and_Display_Letters.s"



.data
@ define variables


.align

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
	LDR R0, =#1
	BL receive_string

	@ Decode the cipher
	LDR R0, =#1				@ Decode mode
	BL substitution_cipher

	@ Count and display the letters
	BL count_and_display_letters

	B loop

