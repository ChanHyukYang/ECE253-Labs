module Lab5p3(SW,HEX0,HEX1,HEX2,HEX3,KEY);
	input [1:0] SW;
	input [1:0] KEY;
	output [7:0] HEX0,HEX1,HEX2,HEX3;
	wire [15:0] Q;
	wire [15:0] Av;
	wire sig1;
	assign sig1 = 1'b1;
	
		t_fasd a(sig1,SW[1],KEY[0],SW[0],Q[0],Av[0]);
	
		t_fasd b(Av[0],Q[0],KEY[0],SW[0],Q[1],Av[1]);	
	
		t_fasd c(Av[1],Q[1],KEY[0],SW[0],Q[2],Av[2]);
	
		t_fasd d(Av[2],Q[2],KEY[0],SW[0],Q[3],Av[3]);
	
		t_fasd e(Av[3],Q[3],KEY[0],SW[0],Q[4],Av[4]);
	
		t_fasd f(Av[4],Q[4],KEY[0],SW[0],Q[5],Av[5]);
	
		t_fasd g(Av[5],Q[5],KEY[0],SW[0],Q[6],Av[6]);
	
		t_fasd h(Av[6],Q[6],KEY[0],SW[0],Q[7],Av[7]);
	
		t_fasd i(Av[7],Q[7],KEY[0],SW[0],Q[8],Av[8]);
	
		t_fasd j(Av[8],Q[8],KEY[0],SW[0],Q[9],Av[9]);
	
		t_fasd k(Av[9],Q[9],KEY[0],SW[0],Q[10],Av[10]);
	
		t_fasd l(Av[10],Q[10],KEY[0],SW[0],Q[11],Av[11]);
	
		t_fasd m(Av[11],Q[11],KEY[0],SW[0],Q[12],Av[12]);
	
		t_fasd n(Av[12],Q[12],KEY[0],SW[0],Q[13],Av[13]);
	
		t_fasd o(Av[13],Q[13],KEY[0],SW[0],Q[14],Av[14]);
	
		t_fasd p(Av[14],Q[14],KEY[0],SW[0],Q[15],Av[15]);
	
	HexDisp A1(Q[3:0],HEX0);
	HexDisp A2(Q[7:4],HEX1);
	HexDisp B1(Q[11:8],HEX2);
	HexDisp B2(Q[15:12],HEX3);
endmodule
	
module t_fasd(In,Enable,Clk,Reset,Q,Aval);
	input In,Clk,Reset,Enable;
	output reg Q;
	output Aval;
	assign Aval=In&Enable;
	always @(posedge Clk, negedge Reset)
	begin
		if (Reset == 1'b0)
		begin
			Q=1'b0;
		end
		else if (In&Enable == 1'b1)
		begin	
			Q<=~Q;
		end
	end
endmodule