`timescale 1ns/1ps

module mux5x2_1 (out, in, sel);
	input [1:0][4:0] in;
	input sel;
	output [4:0] out;
	
	genvar i;
	
	generate
		for (i = 0; i < 5; i++) begin : slicing
			assign out[i] = in[sel][i];
		end
			
			//mux2_1 a (out[i], bitSlice, sel);
		//end
	endgenerate
endmodule 