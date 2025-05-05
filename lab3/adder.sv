`timescale 1ps/1ps

module adder (out, overflow, carry_out, cntrl, A, B);
	output [63:0] out;
	output overflow, carry_out;
	input [63:0] A, B;
	input [2:0] cntrl;
	
	logic [64:0] carries;
	logic [63:0] muxes, notB;
	assign carries[0] = cntrl[0];
	
	genvar i;
	
	generate
		
		// ~B, muxes, and adders
		for (i = 0; i < 64; i++) begin : stuff
						
			not #(50) complement (notB[i], B[i]);
			
			mux2_1 XDLOL (muxes[i], B[i], notB[i], cntrl[0]);
			
			full_adder c (out[i], carries[i+1], A[i], muxes[i], carries[i]);
		
		end
		
	endgenerate
	
	xor #(50) a (overflow, carries[64], carries[63]);	// Overflow flag
	
	assign carry_out = carries[64];							// Carry Out flag
	
endmodule 


