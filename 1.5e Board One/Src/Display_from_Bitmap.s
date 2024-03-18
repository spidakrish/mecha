.syntax unified
.thumb

#include "definitions.s"

.text

display_from_bitmap:
	@ "Arguments"
	@ R1 = bitmap
	@ Note: R2 is updated by this function
	
	LDR R2, =GPIOE
	STRB R1, [R2, #ODR + 1]
	
	BX LR
