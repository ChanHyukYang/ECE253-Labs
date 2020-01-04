module Lab5p4(SW,HEX0,HEX1,HEX2,HEX3,KEY);
	input [1:0] SW;
	input [1:0] KEY;
	output [7:0] HEX0,HEX1,HEX2,HEX3;
	reg [15:0] Q=16'b0000000000000000;
	wire [15:0] Av=16'b0000000000000000;
	wire sig1;
	always@ (posedge KEY[0],negedge SW[0])
	begin
		if (SW[0] == 1'b0)
			begin
			Q=16'b0000000000000000;
			end
		else if (SW[1] == 1'b1)
			begin
			Q<=Q+1;
			end
	end
	HexDisp A1(Q[3:0],HEX0);
	HexDisp A2(Q[7:4],HEX1);
	HexDisp B1(Q[11:8],HEX2);
	HexDisp B2(Q[15:12],HEX3);
endmodule
