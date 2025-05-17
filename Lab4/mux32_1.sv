`timescale 1ns/1ps

module mux32_1 (out, in, sel);
	output out;
	input [31:0] in;
	input [4:0] sel;
	
	logic [1:0] muxInput;
	
	mux16_1 a (muxInput[0], in[15:0],  sel[3:0]);
	mux16_1 b (muxInput[1], in[31:16], sel[3:0]);
	
	mux2_1_v2  c (out, muxInput, sel[4]);
	
endmodule



module mux32_1_testbench();
	logic out;
	logic [31:0] in;
	logic [4:0] sel;

	
	
	mux32_1 dut (out, in, sel);
	
	initial begin
	
		in = 20; #10
		sel = 0; #10
		sel = 1; #10
		sel = 2; #10
		sel = 3; #10
		sel = 4; #10
		sel = 5; #10
		sel = 6; #10
					#10
	
		$stop;
	
	end
	
	// make input equal to 00010000...
	// increment sel from 0 to 31, hopeing that out will only equal 1 when sel = 3
	
endmodule 