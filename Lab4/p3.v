module p3(SW,LEDR);
	input [8:0]SW;
	output [4:0]LEDR;
	wire c1, c2, c3;
	FA pa1(SW[0],SW[4],SW[8],LEDR[0],c1);
	FA pa2(SW[1],SW[5],c1,LEDR[1],c2);
	FA pa3(SW[2],SW[6],c2,LEDR[2],c3);
	FA pa4(SW[3],SW[7],c3,LEDR[3],LEDR[4]);
endmodule 

module adder4(A, B, cin, s, cout);
	input [3:0]A,B;
	input cin;
	
	output [3:0]s;
	output cout;
	
	wire c1, c2, c3;
	
	FA f0(A[0], B[0], cin, s[0], c1);
	FA f1(A[1], B[1], c1, s[1], c2);
	FA f2(A[2], B[2], c2, s[2], c3);
	FA f3(A[3], B[3], c3, s[3], cout);
endmodule 
	
module FA(x,y,extra,out,carry);
	input x,y,extra;
	output out,carry;
	assign out = x^y^extra;
	assign carry = (x&y|x&extra|y&extra);
endmodule 