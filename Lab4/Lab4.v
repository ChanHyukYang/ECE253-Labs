module Lab4(SW,LEDR,HEX0,HEX1,HEX4,HEX5);
	input [8:0]SW;
	output [6:0]HEX5,HEX4,HEX1,HEX0;
	output[9:0]LEDR;
	wire z;//OG greater than 9
	wire [3:0]znew;//HEX1 input
	wire[3:0]A,B;//10-15 and 16-19 checkers, respectively
	wire[3:0]F;//output of first mux
	wire[3:0]True0;//output of second mux
	wire[4:0]V;//Sum of X Y and Cin
	p1 X(SW[3:0],HEX4);//Display X on HEX4
	p1 Y(SW[7:4],HEX5);//Display Y on HEX%
	fiveadd Vtot(SW[3:0],SW[7:4],SW[8],V[3:0],V[4]);//Add X Y and Cin
	
	VtoA m(V[2:0],A);//Turn V's 3 least sigbits to 0-5
	comparator comp(V[3:0],z);//is sum greater than 9 (fails if 16-19, remedied later)
	compress5(V[1:0],B);//turns 16-19 into 6-9 for ones value
	Fourto1 mux1(V[3:0],A,z,F);//pass A if S between 10-15, V[3:0] otherwise
	Fourto1 mux2(F,B,V[4],True0);//pass B if S between 16-19, F otherwise
	
	assign znew[0] = V[4]|z;//if sum between 16-19, assigns 1 to HEX1 input val
	assign znew[3:1]=3'b0;
	
	assign LEDR[4:0]=V;
	assign LEDR[9]=(SW[3]&SW[1]|SW[3]&SW[2]|SW[7]&SW[5]|SW[7]&SW[6]);
	p1 H1(znew,HEX1);
	p1 H0(True0,HEX0);
endmodule

module fiveadd(A, B, cin, s, cout);
	input [3:0] A, B;
	input cin;
	
	output [3:0] s;
	output cout;
	
	wire c1, c2, c3;
	
	FA f0(A[0], B[0], cin, s[0], c1);
	FA f1(A[1], B[1], c1, s[1], c2);
	FA f2(A[2], B[2], c2, s[2], c3);
	FA f3(A[3], B[3], c3, s[3], cout);
endmodule


module compress5(In,Out);
	input [1:0]In;
	output [3:0]Out;
	assign Out[3]=In[1];
	assign Out[2]=~In[1];
	assign Out[1]=~In[1];
	assign Out[0]=In[0];
endmodule 