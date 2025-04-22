`timescale 1ns/1ps

module mux4_1 (out, in, sel);
	output out;
	input [3:0] in;
	input [1:0] sel;

	logic [1:0] muxInput;
	
	mux2_1 a (muxInput[0], in[1:0], sel[0]);
	mux2_1 b (muxInput[1], in[3:2], sel[0]); 
	mux2_1 c (out, muxInput, sel[1]);

endmodule
