				.include "address_map_arm.s"
				.extern	LEDR_DIRECTION
				.extern	LEDR_PATTERN

/*****************************************************************************
 * MPCORE Private Timer - Interrupt Service Routine                                
 *                                                                          
 * Shifts the pattern being displayed on the LEDR
 * 
******************************************************************************/
				.global PRIV_TIMER_ISR
PRIV_TIMER_ISR:	
				LDR		R0, =MPCORE_PRIV_TIMER	// base address of timer
				MOV		R1, #1
				STR		R1, [R0, #0xC]				// write 1 to F bit to reset it
															// and clear the interrupt

/* Move the two LEDS to the centre or away from the centre to the outside. */
SWEEP:		LDR		R0, =LEDR_DIRECTION	// put shifting direction into R2
				LDR		R2, [R0]
				LDR		R1, =LEDR_PATTERN		// put LEDR pattern into R3
				LDR		R3, [R1]
				CMP 	R3,#0
				BEQ 	TOCENTRE
				B TOOUTSIDE
				...
TOOUTSIDE:		LSR R8,R8,#1//SHIFT R6 RIGHT 1 BIT
				LSL R9,R9,#1//SHIFT R5 LEFT 1 BIT
				ORR R10, R8, R9//NEW DISPLAY
				STR R10,[LEDR_PATTERN]
				ADD R7,R7,#1
				CMP R7,#4// CHECK IF SWITCH IN DIRECTION IS NEEDED
				BEQ C_0
				B DONE_SWEEP
				

C_O:			MOV		R2, #1					// change direction to outside
				B DONE_SWEEP
				

TOCENTRE:		LSL R8,R8,#1//SHIFT R6 RIGHT 1 BIT
				LSR R9,R9,#1//SHIFT R5 LEFT 1 BIT
				ORR R10, R8, R9//NEW DISPLAY
				STR R10,[LEDR_PATTERN]
				SUB R7,R7,#1
				CMP R7,#0// CHECK IF SWITCH IN DIRECTION IS NEEDED
				BEQ O_C
				B DONE_SWEEP
				

O_C:			MOV		R2, #0					// change direction to centre
				B DONE_SWEEP
				

DONE_SWEEP:
				STR		R2, [R0]					// put shifting direction back into memory
				STR		R3, [R1]					// put LEDR pattern back onto stack
	
END_TIMER_ISR:
				MOV		PC, LR
