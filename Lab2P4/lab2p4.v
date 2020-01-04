module lab2p4(SW, LEDR, HEX0,HEX1,HEX2);
input [9:0] SW; // slide switches
output [9:0] LEDR; // red lights
output [6:0] HEX0; // 7-seg display
output [6:0] HEX1;
output [6:0] HEX2;
wire [1:0] M0;
wire [1:0] M1;
wire [1:0] M2;
mux_2bit_3to1 U0 (SW[9:8], SW[1:0], SW[5:4], SW[3:2], M0);
char_7seg H0 (M0, HEX0);

mux_2bit_3to1 U1 (SW[9:8], SW[3:2], SW[1:0], SW[5:4], M1);
char_7seg H1 (M1, HEX1);

mux_2bit_3to1 U2 (SW[9:8], SW[5:4], SW[3:2], SW[1:0], M2);
char_7seg H2 (M2, HEX2);
assign LEDR=SW;

endmodule

// implements a 2-bit wide 3-to-1 multiplexer
module mux_2bit_3to1 (S, U, V, W, M);
input [1:0] S, U, V, W;
output [1:0] M;
assign M[0] = ((~S[0]&~S[1])&U[0]|(~S[0]&S[1])&V[0]|(S[0]&~S[1])&W[0]);
assign M[1] = ((~S[0]&~S[1])&U[1]|(~S[0]&S[1])&V[1]|(S[0]&~S[1])&W[1]);
endmodule

// implements a 7-segment decoder for 2, 5, 3 and ‘blank’
module char_7seg (C, Display);
input [1:0] C; // input code
output [6:0] Display; // output 7-seg code
wire c0,c1;
assign c0=C[0];
assign c1=C[1];
assign Display[0]=c1&c0;
assign Display[1]=c0;
assign Display[2]=(c1&c0|~c1&~c0);
assign Display[3]=c1&c0;
assign Display[4]=c1|c0;
assign Display[5]=c1|(~c0);
assign Display[6]=c1&c0;
endmodule 