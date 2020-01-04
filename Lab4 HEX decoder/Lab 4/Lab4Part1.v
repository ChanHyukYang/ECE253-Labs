module hexDecoder(disp, Switch);
	input [3:0] Switch;
	output [6:0] disp;
	
	wire [3:0] x;
	wire [6:0] H;
	
	assign x = Switch;
	assign disp = H;
	
	assign H[0] = ((~x[1]) & x[0] & (~x[3]) & (~x[2])) | ((~x[0]) & x[2]);
	assign H[1] = ((~x[3]) & (x[2]))	& ((~x[1]) & x[0] | (x[1] & (~x[0])));
	assign H[2] = (x[1] & (~x[0]) & (~x[3]) & (~x[2]));
	assign H[3] = (~x[2]) &  (~x[1]) & x[0] | (((~x[3]) & x[2]) & (~(x[1] ^ x[0])));
	assign H[4] = ((~x[3]) & x[2] & (~x[1]) & (~x[0])) | x[0];
	assign H[5] = (~x[3]) & ((~x[2]) & (x[0] | x[1]) + x[1] & x[0]);
	assign H[6] = (~x[3]) & (((~x[2]) & (~x[1])) | (x[2] & x[1] & x[1]));
	
endmodule

module Lab4Part1(SW, HEX1, HEX0);

	input [7:0]SW;
	output [6:0]HEX0, HEX1;
	
	wire [3:0] A,B;
	
	assign A = SW[7:4];
	assign B = SW[3:0];
	
	hexDecoder hex0(HEX0,B);
	hexDecoder hex1(HEX1,A);
endmodule
