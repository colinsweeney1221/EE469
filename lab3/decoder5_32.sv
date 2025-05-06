`timescale 1ns/1ps

module decoder5_32 (out, in, enable);
	output [31:0] out;
	input [4:0] in;
	input enable;
	
	logic [1:0] decodeOut;
	
	decoder1_2 a (decodeOut, in[4], enable);
	
	decoder4_16 b (out[15:0], in[3:0], decodeOut[0]);
	decoder4_16 c (out[31:16], in[3:0], decodeOut[1]);
	
endmodule 




module decoder5_32_testbench();
	logic [31:0] out;
	logic [4:0] in;
	logic enable;
	
	decoder5_32 dut (out, in, enable);
	
	initial begin
		
		enable = 1; #10
		in = 0;		#10
		in = 1;		#10
		in = 2;		#10
		in = 3;		#10
		in = 4;		#10
		enable = 0; #10
		in = 5;		#10
		in = 6;		#10
		in = 7;		#10
		in = 8;		#10
		enable = 1; #10
		in = 9;		#10
		in = 10;		#10
		in = 11;		#10
						#10
		
		
		
		$stop;
	
	end
	
endmodule 