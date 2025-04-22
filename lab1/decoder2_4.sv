`timescale 1ns/1ps

module decoder2_4 (out, in, enable);
	output [3:0] out;
	input [1:0] in;
	input enable;
	
	logic [1:0] out1_2;
	
	decoder1_2 a (out1_2, in[1], enable);
	
	decoder1_2 top    (out[1:0], in[0], out1_2[0]);
	decoder1_2 bottom (out[3:2], in[0], out1_2[1]);
	
endmodule 