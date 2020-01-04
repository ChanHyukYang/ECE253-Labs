.text
.global _start
	_start:
    MOV R0,#0 // R0 will hold the result
	LDR R3,=NUM // load the data ADDRESS into R3 (=NUM vs NUM(latter gives 1st val?, first gives address?))
    LDR R2,SIZE//ADDRESS IN MEMORY TO VALUE OF LENGTH OF LIST
	MOV R4,#0//TRACK WORDS ANALYZED
	MOV R5,#0//longest R0 value
    LDR R1,[R3]// load data word into R1, increment for address to next (WHY NOT LDR)
	ONES: //R1 datainput, R0 output
    	CMP R1,#0 // loop until the data contains no more 1’s
		BEQ CHECK1
		LSR R12,R1,#1 // perform SHIFT, followed by AND
		AND R1,R1,R12//R2 is R1 with a zero added in most sig bit and everything else shifted right
		ADD R0,#1 // count the string lengths so far
		CMP R0,R5
		MOVGT R5,R0
		B ONES
	CHECK1:
		ADD R4,R4,#1
		CMP R4,R2
		BEQ END
		ADD R3,R3,#4
		LDR R1,[R3]
        MOV R0,#0
		B ONES
END: 
	B END
NUM: 
	.word 0,1,2,3,4,5,6,7,8,0xe
SIZE:
	.word 10
.end