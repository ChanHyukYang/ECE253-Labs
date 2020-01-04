.text
.global _start
	_start:
	LDR R1,NUM // load the data word into R1 (=NUM vs NUM(latter works))
	MOV R0,#0 // R0 will hold the result
	LOOP: 
    	CMP R1,#0 // loop until the data contains no more 1’s
		BEQ END
		LSR R2,R1,#1 // perform SHIFT, followed by AND
		AND R1,R1,R2//R2 is R1 with a zero added in most sig bit and everything else shifted right
		ADD R0,#1 // count the string lengths so far
		B LOOP
END: 
	B END
NUM: 
	.word 0
.end