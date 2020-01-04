module Lab6d(input [2:0] SW, input [1:0] KEY, input CLOCK_50, output [9:0]LEDR);
	wire Resetn,start;
	assign Resetn = KEY[0];
	assign start = KEY[1];
	reg [3:0] y, y0;
	reg [2:0] z, z0;
	reg [27:0] Q;
	reg L;
	parameter A = 3'b000, B = 3'b001, C = 3'b010, D = 3'b011, E = 3'b100, F = 3'b101, G = 3'b110, H = 3'b111;
	
	always@(SW)
		case (SW)
			A: begin y = 4'b0010;
				z = 3'b010; end
			B: begin y = 4'b0001;
				z = 3'b100; end
			C:	begin y = 4'b0101;
				z = 3'b100; end
			D: begin y = 4'b0001;
				z = 3'b011; end
			E: begin y = 4'b0000;
				z = 3'b001; end
			F: begin y = 4'b0100;
				z = 3'b100; end
			G: begin y = 4'b0011;
				z = 3'b011; end
			H: begin y = 4'b0000;
				z = 3'b100; end
		endcase
		
	always@(posedge CLOCK_50, negedge start, negedge Resetn)
	
	begin
		if (!Resetn) begin
			z0 <= 3'b0;
			Q <= 27'b0;
			end
			
		else if (!start) begin 
			y0 <= y; //store length, signal
			z0 <= z; 
			end
			
		else if (CLOCK_50) begin
		
			if (z0 > 0) begin
			
				//Dot signal
				if (y0[0] == 1'b0) begin 
					if (Q > 50000000) begin
						Q <= 27'b0;
						y0[0] <= y0[1]; //shift register 
						y0[1] <= y0[2];
						y0[2] <= y0[3];
						z0 = z0-1; //decrement the length 
						L <= 0;
						end
					else if (Q < 25000000) begin
						L <= 0; 
						Q <= Q + 1; 
						end
					else
						L = 1;
						Q <= Q + 1;
				end				
				//Dash signal
				else
					if (Q > 100000000) begin
						Q <= 27'b0;
						y0[0] <= y0[1];
						y0[1] <= y0[2];
						y0[2] <= y0[3];
						z0 <= z0-1;
						L <= 0;
						end
					else if (Q < 25000000) begin
						L <= 0; 
						Q <= Q + 1; 
						end
					else 
						begin
						Q <= Q + 1;
						L <= 1; 
						end			
			end
		end
	end
	
	assign LEDR[0] = L;

endmodule



module Lab61(SW, KEY, CLOCK_50, LEDR);

	input [9:0] SW;
	input [3:0] KEY;
	input CLOCK_50;
	output [9:0] LEDR;

	reg [3:0] signal, signal_stored;
	reg [2:0] length, length_stored;
	reg [26:0] Q;
	reg L;
	
	parameter A = 3'b000, B = 3'b001, C = 3'b010, D = 3'b011, E = 3'b100, F = 3'b101, G = 3'b110, H = 3'b111;
	
	wire clk, resetn;
	wire [2:0] letter;
	
	assign clk = CLOCK_50;
	assign letter = SW;
	assign resetn = KEY[0];
	assign display = KEY[1];
	
	always @ (letter)
	
	begin
		case (letter)
			A: begin signal = 4'b0010;
				length = 3'b010; end
			B: begin signal = 4'b0001;
				length = 3'b100; end
			C:	begin signal = 4'b0101;
				length = 3'b100; end
			D: begin signal = 4'b0001;
				length = 3'b011; end
			E: begin signal = 4'b0000;
				length = 3'b001; end
			F: begin signal = 4'b0100;
				length = 3'b100; end
			G: begin signal = 4'b0011;
				length = 3'b011; end
			H: begin signal = 4'b0000;
				length = 3'b100; end
		endcase
	end
	
	always @ (posedge clk, negedge display, negedge resetn)
	
	begin
	
		if(!resetn) begin
		
			Q <= 27'b0;
			signal_stored <= 4'b0;
			length_stored <= 3'b0;
			
		end
		
		else if(!display) begin
		
			signal_stored <= signal;
			length_stored <= length;
		
		end
		
		else if (clk&(length_stored != 0))
		
		begin
		
			Q = Q + 1;
			
			if (signal_stored[0] == 0) begin

				if(Q < 2) begin
				
					L <= 0;
				
				end
				
				else begin
			
					L = 1;
					
					if(Q > 4) begin
					
						Q = 27'b0;
						signal_stored[0] <= signal_stored[1];
						signal_stored[1] <= signal_stored[2];
						signal_stored[2] <= signal_stored[3];
						length_stored <= length_stored - 1;
						L = 0;
					
					end
				end
			end
			
			else 
			
			begin
			
				if(Q < 2) begin
				
					L <= 0;
				
				end
				
				else begin
				
					L = 1;
				
					if(Q > 10) begin
					
						Q = 27'b0;
						signal_stored[0] <= signal_stored[1];
						signal_stored[1] <= signal_stored[2];
						signal_stored[2] <= signal_stored[3];
						length_stored <= length_stored - 1;
						L = 0;
					
					end
				end	
			end	
		end	
	end
	
	assign LEDR[0] = L;

endmodule