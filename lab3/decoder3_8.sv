`timescale 1ns/1ps

module decoder3_8 (out, in, enable);
	output [7:0] out;
	input [2:0] in;
	input enable;
	
	logic [1:0] decodeOut;
	
	decoder1_2 a (decodeOut, in[2], enable);
	
	decoder2_4 b (out[3:0], in[1:0], decodeOut[0]);
	decoder2_4 c (out[7:4], in[1:0], decodeOut[1]);
	
endmodule 