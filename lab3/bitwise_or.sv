`timescale 1ps/1ps

module bitwise_or (out, A, B);
	output [63:0] out;
	input [63:0] A, B;
	
	genvar i;
	
	generate
		for (i = 0; i < 64; i++) begin : oring
			or #(50) a (out[i], A[i], B[i]);
		end
	endgenerate
endmodule 


module bitwise_or_testbench();
	logic [63:0] out, A, B;
	
	bitwise_or dut (out, A, B);
	
	initial begin;
	
		A = 8324;
		B = 0; 		  #200
		
		B = 7813266;  #200
		
		$stop;
	end
endmodule