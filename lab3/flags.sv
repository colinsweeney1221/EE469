//module flags (negative, zero, overflow, carry_out, result, carry_in);
//	output negative, zero, overflow, carry_out;
//	input [63:0] result;
//	input [1:0] carry_in;
//	
//	assign negative = result[63];								// Negative flag
//	
//	xor #(50) a (overflow, carry_in[1], carry_in[0]);		// Overflow flag
//	
//	assign carry_out = carry_in[1];							// Carry Out flag
//	
//	or64_1 b (zero, result);									// Zero flag
//	
//endmodule 