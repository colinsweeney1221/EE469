`timescale 1ns/1ps

module mux16_1 (out, in, sel);
	output out;
	input [15:0] in;
	input [3:0] sel;
	
	logic [1:0] muxInput;
	
	mux8_1 a (muxInput[0], in[7:0],  sel[2:0]);
	mux8_1 b (muxInput[1], in[15:8], sel[2:0]);
	
	mux2_1 c (out, muxInput, sel[3]);
	
endmodule
