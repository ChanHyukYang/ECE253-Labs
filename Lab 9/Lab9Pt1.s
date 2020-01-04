//Pseudo C code
#include <stdio.h>

int swap(int *x, int *y)
{
	int temp= *x;//value of what x points to  assigned to temp
	*x=*y;//value x points to is now what y points to(in mem)
	*y=temp;
	return 0;
}
int main()
{
	int i,j,temp;
	int A[5]={4,1,2,8,4};
	for(i=0;i<=5;i++)
	{
		for(j=0;j<5;j++)
		{
			if (A[j]>A[j+1])
			{
				swap(&A[j],&A[j+1]);
			}
		}
	}
	printf("%d, %d, %d, %d, %d \n", A[0], A[1], A[2],A[3],A[4]);
	return 0;
}

//ARM Code
.text
.global _start
	_start:
	LDR R3,=NUM // load the data ADDRESS into R3(address of first val)
    LDR R1,[R3]//First val in list, also size of list
	LDR R2,[R3]//store first value in list and size, change this
	MOV R0,R3//store original value of R0 to R3 (address of first value)
	MUL R5,R1,R1//number of iterations needed
	MOV R6,#0//track number of iterations of sort
	MOV R7,#1//track iterations within sort
	MAIN:
		BL SWAP
		MOV R0,R3
		MOV R7,#1
		ADD R6,#1
		CMP R5,R6
		BEQ END
		B MAIN
	END:
		B END
	SWAP:
		LDR R2,[R0]
		LDR R4,[R0,#4]
		CMP R2,R4
		BLT BUBBLE
		ADD R7,R7,#1
		CMP R1,R7
		BEQ BACK
		ADD R0,R0,#4
		B SWAP
	BUBBLE:
		MOV R8,R2
		MOV R2,R4
		MOV R4,R8
		STR R2,[R0]
		STR R4,[R0,#4]
		ADD R7,R7,#1
		CMP R1,R7
		BEQ BACK
		ADD R0,R0,#4
		B SWAP
	BACK:
		MOV PC,LR
	NUM:
		.word 7,1,3,9,4,5,6