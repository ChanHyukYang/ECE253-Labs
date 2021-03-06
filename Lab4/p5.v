module p5(SW,HEX0,HEX1,HEX4,HEX5);
	input[8:0]SW;
	output[6:0]HEX0,HEX1,HEX4,HEX5;
	reg c1;
	reg [3:0] Z0,S0,S1;
	reg[4:0]T0;
	
	always@(SW,HEX0,HEX1,HEX4,HEX5)
	begin
		T0 = SW[3:0] + SW[7:4] + SW[8];
		if (T0 > 9)
		begin
			Z0 = 10;
			c1 = 1;
		end
		else
		begin
			Z0 = 0;
			c1 = 0;
		end
		S0 = T0-Z0;
		S1 = c1;
	end
	p1(SW[3:0],HEX4);
	p1(SW[7:4],HEX5);
	p1(S1,HEX1);
	p1(S0,HEX0);
endmodule 