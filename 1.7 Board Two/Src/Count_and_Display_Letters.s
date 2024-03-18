.syntax unified
.thumb

#include "definitions.s"
#include "Display_from_Bitmap.s"

.data
	alphabet: .asciz "ABCDEFGHIJKLMNOPQRSTUVWXYZ\0"
	stored_link_register: .byte 0

.text
	
count_and_display_letters:
	@ "Arguments"
	@ R0 = 0 for delay, 1 for button
	@ R1 = Input string to count and display
	@ Modifies registers R1 - R7
	
	
	LDR R2, =alphabet

alphabet_loop:
	LDRB R3, [R2], #1
	
	CMP R3, #0 
	BEQ alphabet_loop_end
	
	LDR R4, =#0
	LDR R5, =#0
	
count_string_loop:
	LDRB R6, [R1, R4]
	CMP R6, #0
	BEQ string_loop_end
	CMP R3, R6
	BNE skip_count_increment
	ADD R5, #1
skip_count_increment:
	ADD R4, #1
	B count_string_loop
	
string_loop_end:
	PUSH {R0-R12, lr}
	LDRB R1, =#0

led_bitmat_loop:
	SUBS R5, #1
	BLT led_bitmat_loop_end
	LSL R1, #1
	ADD R1, #1
	B led_bitmat_loop
led_bitmat_loop_end:
	AND R1, #0b11111111
	BL display_from_bitmap
	POP {R0-R12, lr}

	CMP R0, #1
	BNE delay500

wait_for_button_loop:
	LDR R7, =GPIOA
	LDR R7, [R7, IDR]
	TST R7, #0x01
	BEQ wait_for_button_loop
wait_for_not_button_loop:
	LDR R7, =GPIOA
	LDR R7, [R7, IDR]
	TST R7, #0x01
	BNE wait_for_not_button_loop

	B alphabet_loop

delay500:
	@ IMPLEMENT THIS
	B alphabet_loop

alphabet_loop_end:
	PUSH {R1, lr}
	LDR R1, =#0
	BL display_from_bitmap
	POP {R1, lr}
	BX LR
