module num(SW,HEX0);
input [1:0] SW;
output [6:0] HEX0;
wire c0,c1;
assign c0=SW[0];
assign c1=SW[1];
assign HEX0[0]=c1&c0;
assign HEX0[1]=c0;
assign HEX0[2]=(c1&c0|~c1&~c0);
assign HEX0[3]=c1&c0;
assign HEX0[4]=c1|c0;
assign HEX0[5]=c1|~c0;
assign HEX0[6]=c1&c0;
endmodule 