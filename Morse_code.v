// Implementation strategy: Create a half second counter, a morse code shift register, morse code length counter and a Morse code FSM

module Morse_code(SW,KEY,CLOCK_50,LEDR);
	
	input [2:0] SW;
	input [1:0] KEY;
	input CLOCK_50;
	output [0:0] LEDR;
	
	wire ln,resetn,m,truth,out,light,enable,load;	
	wire [2:0] in,l;
	reg w = 1'b0;
	reg [2:0] length; 
	
	assign ln = ~KEY[1];
	assign resetn = KEY[0];  
	assign in = SW; 
	
	half_counter(CLOCK_50,resetn,out);
	shifter(ln,out,in,resetn,enable,load,m,l);
	length_counter(l,out,resetn,truth,enable,load);
	morse_FSM(KEY[1],m,truth,out,resetn,ln,LEDR[0],enable,load);	
	
endmodule 


module half_counter(clock,resetn,out);
	input clock,resetn;
	output reg out;
	
	reg [24:0]timer = 25'b0;
	
	always @(posedge clock, negedge resetn)
		begin
			if (resetn == 1'b0)
				timer <= 25'b0;
			else if (timer == 25'b1011111010111100001000000)
				begin
					timer <= 25'b0;
					out <= 1'b1;
				end
			else
				begin
					timer <= timer + 1;
					out <= 1'b0;
				end
		end
endmodule 

module muxDFF(ln,D0,D1,clock,resetn,enable,load,Q);
	input ln,D0,D1,clock,resetn,enable,load;
	output reg Q;
	
	wire P;
	
	assign P = (load == 1'b0)?D0:D1;
	always @(posedge clock, negedge resetn)
		begin
		if (resetn == 1'b0)
			Q <= 1'b0;
		else if (enable)
			Q <= P;
		end
endmodule 

module shifter(ln,clock,D,resetn,enable,load,m,l);
	input clock,ln,resetn,enable,load;
	input [2:0] D;
	output m;
	output [2:0] l;
	
	wire [3:0] Q;
	wire [3:0] Morse;
	reg [3:0] morse;
	reg [2:0] length;
	
	parameter J_in = 3'b0, J_Morse = 4'b1000, J_length = 3'd4,
	K_in = 3'b001, K_Morse = 4'b0100, K_length = 3'd3,
	L_in = 3'b010, L_Morse = 4'b1011, L_length = 3'd4,
	M_in = 3'b011, M_Morse = 4'b0, M_length = 3'd2,
	N_in = 3'b100, N_Morse = 4'b0100, N_length = 3'd2,
	O_in = 3'b101, O_Morse = 4'b0, O_length = 3'd3,
	P_in = 3'b110, P_Morse = 4'b1001, P_length = 3'd4,
	Q_in = 3'b111, Q_Morse = 4'b0010, Q_length = 3'd4; 
	
	always @(D)
		begin: state_table
		case (D)
			J_in: begin
					morse = J_Morse; 
					length = J_length;
					end
			K_in: begin
					morse = K_Morse; 
					length = K_length;
					end
			L_in: begin 
					morse = L_Morse; 
					length = L_length;
					end
			M_in: begin
					morse = M_Morse;
					length = M_length;
					end
			N_in: begin
					morse = N_Morse;
					length = N_length;
					end
			O_in: begin
					morse = O_Morse;
					length = O_length;
					end
			P_in: begin
					morse = P_Morse;
					length = P_length;
					end
			Q_in: begin
					morse = Q_Morse;
					length = Q_length;
					end 
			default morse = 4'bxxxx;
		endcase
		end
	
	assign Morse = morse;
	
	muxDFF U0(ln,Morse[0],1'b0,clock,resetn,enable,load,Q[0]);
	muxDFF U1(ln,Morse[1],Q[0],clock,resetn,enable,load,Q[1]);
	muxDFF U2(ln,Morse[2],Q[1],clock,resetn,enable,load,Q[2]);
	muxDFF U3(ln,Morse[3],Q[2],clock,resetn,enable,load,Q[3]);

	assign l = length; 
	assign m = Q[3];
endmodule 

module length_counter(size,clock,resetn,truth,enable,load);
	input clock,resetn,enable,load;
	input [2:0] size;
	output reg truth; 
		
	reg [2:0] count;
	always @(posedge clock, negedge resetn)
		begin
		
		truth = (count == size);
		
		if (resetn == 1'b0)
			count <= 1'b0;
		else if (enable & load)
			count <= count + 1;
		end
endmodule

module morse_FSM(in,dotdash,length,clock,resetn,ln,light,enable,load);
	
	input dotdash,ln,length,clock,resetn;
	input in; 
	output light,enable,load;
	
	parameter Idle=3'b0,Load=3'b001,Dash1=3'b010,Dash2=3'b011,Dash3=3'b100,Dot=3'b101,Delay=3'b110,Done=3'b111; 
	
	reg [2:0] y_c,Y_n;
	
	always @(y_c,dotdash,length,ln)
		begin: Morse_FSM_table
		case(y_c)
			Idle: begin
					if (in == 1'b0)
						Y_n <= Load;
					else
						Y_n <= Idle;
					end
			Load: begin
					if (length == 1'b1)
						Y_n = Done;
					else 
						if (dotdash == 1'b1)
							Y_n <= Dot;
						else
							Y_n <= Dash1;
					end
			Dash1: Y_n <= Dash2;
			Dash2: Y_n <= Dash3;
			Dash3: Y_n <= Delay;
			Dot: Y_n <= Delay;
			Delay: begin
					 if (length == 1'b1)
						Y_n <= Done;
					 else
						if (dotdash == 1'b1)
							Y_n <= Dot;
						else
							Y_n <= Dash1;
					 end
			Done: Y_n <= Idle;
		endcase 
		end 
		
		always @(posedge clock,negedge resetn)
			begin
			if (resetn == 1'b0)
				y_c <= Idle;
			else
				y_c <= Y_n;
		end
		
	assign light = (y_c == Dash1 | y_c == Dash2 | y_c == Dash3 | y_c == Dot);
	assign enable = (y_c == Dash3 | y_c == Dot | y_c == Idle); 
	assign load = ~(y_c == Idle);
	
endmodule
	
/*	
	always @(clock)
	begin
		shifter(ln,clock,morse,w,resetn,light);
		lcounter(length,l_out);
		if (light == 1'b1)
		begin
			if (long_count == 3'b111)
			begin 
				long_count <= 3'b0;
				if (l_out == 1'b1)
				begin
					light_out = 0
					assign LEDR[0] = light_out; 
				end
				else
				begin
					light_out = 0;
					shifter(ln,l_out,morse,w,resetn,light);
					assign LEDR[0] = light_out;
				end
			end
			else
			begin
				assign LEDR[0] = light;
				shifter(ln,clock,long_count,t,resetn,count);
			end
		end
		else
		begin
			if 
			assign LEDR[0] = light;
			counter(CLOCK_50,clock);
			if (clock == 1'b1)
			begin
				light_out = 0;
				assign LEDR[0] = light_out;
*/			
