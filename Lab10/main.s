	.include "address_map_arm.s"
/* 
 * This program demonstrates the use of interrupts using the KEY and timer ports. It
 * 	1. displays a sweeping red light on LEDR, which moves left and right
 * 	2. stops/starts the sweeping motion if KEY3 is pressed
 * Both the timer and KEYs are handled via interrupts
*/
			.text
			.global	_start
_start:
			MOV R0,#0b10010//INTERUPT MODE
			MSR CPSR,R0
			LDR SP,=0x20000//CHANGE VALUE OF SP IN INTERUPT MODE
			MOV R0,#0b10011//SUPERVISOR MODE
			MSR CPSR,R0//NOW IN SUPERVISOR MODE
			LDR SP,=0x40000
			LDR R7 = #0 //CHECK IF YOU NEED TO SWITCH DIR
			MOV R8,#1//LEDR[0] ON
			MOV R9,#0b1000000000//LEDR[9] ON
			
			

			BL			CONFIG_GIC				// configure the ARM generic interrupt controller
			BL			CONFIG_PRIV_TIMER		// configure the MPCore private timer
			BL			CONFIG_KEYS				// configure the pushbutton KEYs
			
			//... enable ARM processor interrupts ...
			EOR CPSR,CPSR,#0b1000000

			LDR		R6, =0xFF200000 		// red LED base address
MAIN:
			LDR		R4, LEDR_PATTERN		// LEDR pattern; modified by timer ISR
			STR 		R4, [R6] 				// write to red LEDs
			B 			MAIN

/* Configure the MPCore private timer to create interrupts every 1/10 second */
CONFIG PRIV TIMER:
			LDR		R0, =0xFFFEC600 		// Timer base address
			LDR R1,=0d2000000//TIMER LOAD VALUE
			STR R1,[R0]
			STR #0b111,[R0,#8]
			MOV 		PC, LR 					// return

/* Configure the KEYS to generate an interrupt */
CONFIG KEYS:
			LDR 		R0, =0xFF200050 		// KEYs base address
			STR #0b1000,[R0,#8]//ACTIVATES KEY3 AS INTERUPT
			MOV 		PC, LR 					// return

			.global	LEDR_DIRECTION
LEDR_DIRECTION:
			.word 	0							// 0 means means moving to centre; 1 means moving to outside

			.global	LEDR_PATTERN
LEDR_PATTERN:
			.word 	0x201	// 1000000001
