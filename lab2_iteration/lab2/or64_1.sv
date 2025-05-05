`timescale 1ps/1ps

module or64_1 (out, in);
	output out;
	input [63:0] in;
	
	logic [1:0] or_out;
	
	or32_1 a (or_out[0], in[31:0]);
	or32_1 b (or_out[1], in[63:32]);
	
	nor #(50) c (out, or_out[0], or_out[1]);
	
endmodule 



module or64_1_testbench();
	logic out;
	logic [63:0] in;
	
	or64_1 dut (out, in);
	
	initial begin;
	
		in = 0; 		 #1000
		in = 1; 		 #1000
		in = 0; 		 #1000
		in = 572613; #1000
		
		$stop;
	end
endmodule 