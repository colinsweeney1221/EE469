`timescale 1ns/1ps

module decoder4_16 (out, in, enable);
	output [15:0] out;
	input [3:0] in;
	input enable;
	
	logic [1:0] decodeOut;
	
	decoder1_2 a (decodeOut, in[3], enable);
	
	decoder3_8 b (out[7:0], in[2:0], decodeOut[0]);
	decoder3_8 c (out[15:8], in[2:0], decodeOut[1]);
	
endmodule 