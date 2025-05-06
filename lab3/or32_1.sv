`timescale 1ps/1ps
module or32_1 (out, in);
	output out;
	input [31:0] in;
	
	logic [1:0] or_out;
	
	or16_1 a (or_out[0], in[15:0]);
	or16_1 b (or_out[1], in[31:16]);
	
	or #(50) c (out, or_out[0], or_out[1]);
	
endmodule 