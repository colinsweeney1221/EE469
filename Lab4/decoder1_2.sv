`timescale 1ps/1ps

module decoder1_2 (out, in, enable);
	output [1:0] out;
	input in, enable;
	
	logic notIn;
	
	not #50 a (notIn, in);
	and #50 b (out[0], notIn, enable);
	and #50 c (out[1], in, enable);

endmodule