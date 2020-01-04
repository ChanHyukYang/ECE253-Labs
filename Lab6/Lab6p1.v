module Lab6p1a(SW,KEY,LEDR);
	input[1:0]SW; //SW[0]=reset, SW[1]=w input
	input [1:0]KEY; //KEY=clock input
	output [9:0]LEDR; //LEDR[9]=z, rest are states
	reg [8:0]y; //state outputs
	wire [8:0]Y; //state inputs
	assign Y[0]=SW[0]&(~(Y[8]|Y[7]|Y[6]|Y[5]|Y[4]|Y[3]|Y[2]|Y[1]));
	assign Y[1]=SW[0]&(~SW[1]&y[0]|~SW[1]&y[5]|~SW[1]&y[6]|~SW[1]&y[7]|~SW[1]&y[8]);
	assign Y[2]=(~SW[1]&y[1])&SW[0];
	assign Y[3]=(~SW[1]&y[2])&SW[0];
	assign Y[4]=(~SW[1]&y[4]|~SW[1]&y[3])&SW[0];
	assign Y[5]=(SW[1]&y[0]|SW[1]&y[1]|SW[1]&y[2]|SW[1]&y[3]|SW[1]&y[4])&SW[0];
	assign Y[6]=(SW[1]&y[5])&SW[0];
	assign Y[7]=(SW[1]&y[6])&SW[0];
	assign Y[8]=(SW[1]&y[7]|SW[1]&y[8])&SW[0];
	assign z=y[8]|y[4];
	always @(posedge KEY[0])
		if (!SW[0])
			y <= 9'b000000001;
		else 
			y <= Y;
	assign LEDR[8:0]=y[8:0];
	assign LEDR[9]=z;
endmodule
				
