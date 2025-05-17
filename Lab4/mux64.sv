`timescale 1ns/1ps

module mux64 (out, in, sel);
	output [63:0] out;
	input [31:0][63:0] in;
	input [4:0] sel;
	
	genvar i, j;
	
	generate
		for (i = 0; i < 64; i++) begin : eachMux
			logic [31:0] bitSlice;
			
			for (j = 0; j < 32; j++) begin : slicing
				assign bitSlice[j] = in[j][i];
			end
			
			mux32_1 a (out[i], bitSlice, sel);
		end
	endgenerate
	
endmodule


module mux64_testbench();
	logic [63:0] out;
	logic [31:0][63:0] in;
	logic [4:0] sel;
	
	mux64 dut (out, in, sel);
	
	initial begin
	
		in = 0; 																								#10
		in[0] = 64'b1111111111111111111111111111111111111111111111111111111111111111;
		in[1] = 0;
		in[2] = 64'b1111111111111111111111111111111111111111111111111111111111111111;
		in[3] = 0;
		in[4] = 0;
		in[5] = 64'b1111111111111111111111111111111111111111111111111111111111111111;
		in[6] = 0; 																							#2
		sel = 0; 																							#10
		sel = 1; 																							#10
		sel = 2; 																							#10
		sel = 3; 																							#10
		sel = 4; 																							#10
		sel = 5; 																							#10
		sel = 6; 																							#10
		sel = 7; 																							#10
																												#10
		
		$stop;
		
	end
	
endmodule 