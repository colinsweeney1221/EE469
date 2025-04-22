`timescale 1ns/10ps
module or8_1 (out, in);
	output out;
	input [7:0] in;
	
	logic [1:0] or_out;
	
	or4_1 a (or_out[0], in[3:0]);
	or4_1 b (or_out[1], in[7:4]);
	
	or #(50) c (out, or_out[0], or_out[1]);
	
endmodule 