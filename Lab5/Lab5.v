module Lab5p6(CLOCK_50,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5);
	input CLOCK_50;
	output [7:0] HEX0,HEX1,HEX2,HEX3,HEX4,HEX5;
	reg [25:0] Q=26'b00000000000000000000000000;
	reg[3:0] A=4'b0001;
	reg[3:0] B=4'b1110;
	reg[3:0] C=4'b1101;
	reg[3:0] D=4'b0000;
	reg[3:0] E=4'b0000;
	reg[3:0] F=4'b0000;
	always@ (posedge CLOCK_50)
	begin		
		if (Q==26'b11111111111111111111111111)
			begin
			Q<=26'b00000000000000000000000000;
			F<=E;
			E<=D;
			D<=C;
			C<=B;
			B<=A;
			A<=F;
			end
		else
			begin
			Q<=Q+1;
			end
	end
	HexDisp aa(A,HEX0);
	HexDisp bb(B,HEX1);
	HexDisp cc(C,HEX2);
	HexDisp dd(D,HEX3);
	HexDisp ee(E,HEX4);
	HexDisp ff(F,HEX5);
endmodule
