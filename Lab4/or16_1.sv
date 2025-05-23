`timescale 1ps/1ps
module or16_1 (out, in);
	output out;
	input [15:0] in;
	
	logic [1:0] or_out;
	
	or8_1 a (or_out[0], in[7:0]);
	or8_1 b (or_out[1], in[15:8]);
	
	or #(50) c (out, or_out[0], or_out[1]);
	
endmodule 