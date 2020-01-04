module Lab5p1(D,Q,Qn,Q1,Q1n,Q2,Q2n,Clk);
	input D,Clk;
	output Q,Qn,Q1,Q1n,Q2,Q2n;
	GatedDLatch p1(D,Q,Qn,Clk);
	PosEdgeDFF p2(D,Q1,Q1n,Clk);
	NegEdgeDFF p3(D,Q2,Q2n,Clk);
	endmodule

module GatedDLatch(D,Q,Qn,Clk);
	input D,Clk;
	output reg Q,Qn;
	always @(D,Clk)
		begin
		if(Clk==1'b1)
			begin
			Q=D;
			Qn=~D;
			end
		end
endmodule

module PosEdgeDFF(D,Q,Qn,Clk);
	input D,Clk;
	output reg Q,Qn;
	always @(posedge Clk)
		begin
			Q<=D;
			Qn<=~D;
		end
endmodule

module NegEdgeDFF(D,Q,Qn,Clk);
	input D,Clk;
	output reg Q,Qn;
	always @(negedge Clk)
		begin
			Q<=D;
			Qn<=~D;
		end
endmodule
