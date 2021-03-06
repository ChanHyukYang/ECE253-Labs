module Lab2(SW,LEDR);
	//Assigning inputs and outputs
	input [9:0]SW;
	output[9:0]LEDR;
	
	wire [1:0] U,V,W,M;
	wire [7:0] unused;
	wire s0,s1;
	
	//Assigning the select inputs
	assign s0 = SW[8];
	assign s1 = SW[9];
	
	//Assigning the 2-bit variables
	assign U = SW[5:4];
	assign V = SW[3:2];
	assign W = SW[1:0];
	
	//Assigning the two output LEDs to M
	assign LEDR[1:0] = M;
	
	//Turning off all unsued LEDs
	assign LEDR[9:2] = unused;
	assign unused = 8'b0;
	
	//Assigning the output to the operations of the 2-bit 3-to-1 Mux
	assign M[0] = (((U[0] & ~s0) & ~s1) | ((V[0] & s0) & ~s1) | ((W[0]) & s1));
	assign M[1] = (((U[1] & ~s0) & ~s1) | ((V[1] & s0) & ~s1) | ((W[1]) & s1));
	
endmodule 