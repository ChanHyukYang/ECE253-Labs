module Lab5p5(CLOCK_50,HEX0);
	input CLOCK_50;
	output [7:0] HEX0;
	reg [25:0] Q=26'b00000000000000000000000000;
	reg[3:0] numb=4'b0000;
	always@ (posedge CLOCK_50)
	begin		
		if (Q==26'b11111111111111111111111111)
			begin
			Q<=26'b00000000000000000000000000;
			if (numb>4'b1000)
				begin
				numb<=4'b0000;
				end
			else
				begin
				numb=numb+1;
				end
			end
		else
			begin
			Q<=Q+1;
			end
	end
	HexDisp a(numb,HEX0);
endmodule
