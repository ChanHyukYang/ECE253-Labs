module Lab5p2(SW,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,LEDR,KEY);
	input [7:0]SW;
	input [1:0]KEY;
	output [7:0] HEX0,HEX1,HEX2,HEX3,HEX4,HEX5;
	output LEDR;
	wire[7:0] A,B,F,G;
	reg[8:0] S;
	async k(SW[7:0],KEY[1],KEY[0],A,F);
	async l(SW[7:0],~KEY[1],KEY[0],B,G);
	always @(A,B)
	begin
		S=A+B;
	end
	assign LEDR=S[8];
	HexDisp A1(A[3:0],HEX0);
	HexDisp A2(A[7:4],HEX1);
	HexDisp B1(B[3:0],HEX2);
	HexDisp B2(B[7:4],HEX3);
	HexDisp S1(S[3:0],HEX4);
	HexDisp S2(S[7:4],HEX5);
endmodule
	
module async(In,Clk,Reset,Q,Qn);
	input[7:0]In;
	input Clk,Reset;
	output reg[7:0]Q,Qn;
	always @(posedge Clk, negedge Reset)
	begin
		if (Reset == 1'b0)
		begin
			Q=7'b0000000;
			Qn=7'b1111111;
		end
		else
			begin
				Q<=In;
				Qn<=~In;
			end
	end
endmodule
	
	
module HexDisp(N,o);
	input [3:0]N;
	output reg [6:0]o;
	always @(N)
	begin
		if (N==4'h0)
			o=7'b1000000;
		if (N==4'h1)
			o=7'b1111001;
		if (N==4'h2)
			o=7'b0100100;
		if (N==4'h3)
			o=7'b0110000;
		if (N==4'h4)
			o=7'b0011001;
		if (N==4'h5)
			o=7'b0010010;
		if (N==4'h6)
			o=7'b0000010;
		if (N==4'h7)
			o=7'b1111000;
		if (N==4'h8)
			o=7'b0000000;
		if (N==4'h9)
			o=7'b0011000;
		if (N==4'hA)
			o=7'b0001000;
		if (N==4'hB)
			o=7'b0000011;
		if (N==4'hC)
			o=7'b1000110;
		if (N==4'hD)
			o=7'b0100001;
		if (N==4'hE)
			o=7'b0000110;
		if (N==4'hF)
			o=7'b0001110;
	end
endmodule 