`timescale 1ns/1ps

module mux8_1 (out, in, sel);
	output out;
	input [7:0] in;
	input [2:0] sel;
	
	logic [1:0] muxInput;
	
	mux4_1 a (muxInput[0], in[3:0], sel[1:0]);
	mux4_1 b (muxInput[1], in[7:4], sel[1:0]);
	
	mux2_1 c (out, muxInput, sel[2]);
	
endmodule
