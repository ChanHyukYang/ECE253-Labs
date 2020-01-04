module p2(V,HEX0,HEX1);
	input [3:0]V;
	output [6:0]HEX1,HEX0;
	wire [3:0]z;
	wire[3:0]A;
	wire[3:0]F;
	VtoA m(V,A);
	comparator comp(V,z[0]);
	Fourto1 mux(V,A,z[0],F);
	assign z[3:1]=3'b0;
	p1 H1(z,HEX1);
	p1 H0(F,HEX0);
endmodule

module Fourto1(V,A,S,Z);//4 bit 2to1 mux
	input [3:0]V,A;
	input S;
	output [3:0]Z;
	assign Z[0]=(~S&V[0]|S&A[0]);
	assign Z[1]=(~S&V[1]|S&A[1]);
	assign Z[2]=(~S&V[2]|S&A[2]);
	assign Z[3]=(~S&V[3]|S&A[3]);
endmodule

module VtoA(V,Z);
	input [2:0]V;
	output [3:0]Z;
	assign Z[3] = 1'b0;
	assign Z[2] = V[2]&V[1];
	assign Z[1] = V[2]&~V[1];
	assign Z[0] = (~V[2]&V[1]&V[0])|(V[2]&~V[1]&V[0])|(V[2]&V[1]&V[0]);
endmodule 

module comparator(V,Z);
	input [3:0]V;
	output Z;
	assign Z=(V[3]&V[2]|V[3]&V[1]);
endmodule 