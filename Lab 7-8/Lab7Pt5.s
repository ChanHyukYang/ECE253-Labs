.text
.global _start
	_start:
	LDR R0,=NUM // load the data ADDRESS into R0 (=NUM vs NUM(latter gives 1st val?, first gives address?))
    LDR R4,SIZE//ADDRESS IN MEMORY TO VALUE OF LENGTH OF LIST
    LDR R1,[R0]// load data word into R1, increment for address to next (WHY NOT LDR)
	MOV R3,#0
	MOV R5,#0
	MOV R6,#0
	MOV R7,#0
	MOV R8,#0
	MOV R9,#0
	MOV R10,#0
	TRAILING:
		AND R2,R1,#1
		CMP R2,#0
		BGT RESET1
        CMP R1,#0
        BEQ RESET11
		ADD R7,#1
		CMP R7,R10
		MOVGT R10,R7
		LSR R1,R1,#1//SHIFT R1 BY 1 BIT RIGHT
		B TRAILING
    RESET11:
    	MOV R10,#32
	RESET1:
		LDR R1,[R0]
	LEADING:
		AND R2,R1,#0x80000000
		CMP R2,#0
		BGT RESET2
        CMP R1,#0
        BEQ RESET22
		ADD R6,#1
		CMP R6,R9
		MOVGT R9,R6
		LSL R1,R1,#1//SHIFT R1 BY 1 BIT LEFT
		B LEADING
    RESET22:
    	MOV R9,#32
	RESET2:
		LDR R1,[R0]
	ONES: 
		CMP R1,#0
		BEQ INC
		AND R2,R1,#1
		CMP R2,#0
		ADDGT R5,#1
		CMP R5,R8
		MOVGT R8,R5
		LSR R1,R1,#1//LOGICAL SHIFT R1 BY 1 BIT RIGHT
		B ONES
	INC:
		ADD R3,R3,#1
		CMP R3,R4
		BEQ END
		ADD R0,R0,#4
		LDR R1,[R0]
        MOV R5,#0
        MOV R6,#0
        MOV R7,#0
		B TRAILING
END: 
	B END
NUM: 
	.word 0x80000000,6,5,15,15,15,15,15,15,0xe
SIZE:
	.word 10
.end