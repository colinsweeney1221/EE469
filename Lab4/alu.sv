`timescale 1ns/1ps

module alu (A, B, cntrl, result, negative, zero, overflow, carry_out);
	output [63:0] result;
	output negative, zero, overflow, carry_out;
	input [63:0] A, B;
	input [2:0] cntrl;
	
	logic [63:0] adderOut, bitwiseOr, bitwiseAnd, bitwiseXor;
	
	adder yur (adderOut, overflow, carry_out, cntrl, A, B);
	
	bitwise_or come  (bitwiseOr, A, B);
	
	bitwise_and to   (bitwiseAnd, A, B);
	
	bitwise_xor papa (bitwiseXor, A, B);
	
	or64_1 beh (zero, result);
	
	assign negative = result[63];
	
	logic [7:0][63:0] muxIn;
	
	assign muxIn[0] = B;
	assign muxIn[1] = 0;
	assign muxIn[2] = adderOut;
	assign muxIn[3] = adderOut;
	assign muxIn[4] = bitwiseAnd;
	assign muxIn[5] = bitwiseOr;
	assign muxIn[6] = bitwiseXor;
	assign muxIn[7] = 0;
	
	mux64x8_1 crodie (result, muxIn, cntrl);
	
endmodule 

// Test bench for ALU

// Meaning of signals in and out of the ALU:

// Flags:
// negative: whether the result output is negative if interpreted as 2's comp.
// zero: whether the result output was a 64-bit zero.
// overflow: on an add or subtract, whether the computation overflowed if the inputs are interpreted as 2's comp.
// carry_out: on an add or subtract, whether the computation produced a carry-out.

// cntrl			Operation						Notes:
// 000:			result = B						value of overflow and carry_out unimportant
// 010:			result = A + B
// 011:			result = A - B
// 100:			result = bitwise A & B		value of overflow and carry_out unimportant
// 101:			result = bitwise A | B		value of overflow and carry_out unimportant
// 110:			result = bitwise A XOR B	value of overflow and carry_out unimportant

module alu_testbench();

	parameter delay = 100000;

	logic		[63:0]	A, B;
	logic		[2:0]		cntrl;
	logic		[63:0]	result;
	logic					negative, zero, overflow, carry_out ;

	parameter ALU_PASS_B=3'b000, ALU_ADD=3'b010, ALU_SUBTRACT=3'b011, ALU_AND=3'b100, ALU_OR=3'b101, ALU_XOR=3'b110;
	

	alu dut (.A, .B, .cntrl, .result, .negative, .zero, .overflow, .carry_out);

	// Force %t's to print in a nice format.
	initial $timeformat(-9, 2, " ns", 10);

	integer i;
	logic [63:0] test_val;
	initial begin
	
		$display("%t testing PASS_A operations", $time);
		cntrl = ALU_PASS_B;
		for (i=0; i<100; i++) begin
			A = $random(); B = $random();
			#(delay);
			assert(result == B && negative == B[63] && zero == (B == '0));
		end
		
		//ADD: simple
		$display("%t testing simple addition", $time);
		cntrl = ALU_ADD;
		A = 64'h0000000000000001; B = 64'h0000000000000001;
		#(delay);
		assert(result == 64'h0000000000000002 && carry_out == 0 && overflow == 0 && negative == 0 && zero == 0);
		
		// ADD: carry out
		$display("%t testing addition with carryout", $time);
		A = 64'hFFFFFFFFFFFFFFFF; B = 64'd1;
		#(delay);
		assert(result == 64'd0 && carry_out == 1 && overflow == 0 && negative == 0 && zero == 1);

		// ADD: overflow
		$display("%t testing addition with overflow", $time);
		A = 64'h7FFFFFFFFFFFFFFF; B = 64'd1;
		#(delay);
		assert(64'h8000000000000000 && overflow == 1 && negative == 1 && zero == 0);
		
		// SUBTRACT — simple
		$display("%t testing SUBTRACT (5 - 3)", $time);
		A = 64'd5; B = 64'd3;
		cntrl = ALU_SUBTRACT;
		#(delay);
		assert(result == 64'd2 && carry_out == 1 && overflow == 0 && negative == 0 && zero == 0);

		// SUBTRACT — (0 - 1)
		$display("%t testing SUBTRACT (0 - 1)", $time);
		A = 64'd0; B = 64'd1;
		#(delay);
		assert(result == 64'hFFFFFFFFFFFFFFFF && carry_out == 0 && overflow == 0 && negative == 1 && zero == 0);

		// SUBTRACT — overflow
		$display("%t testing SUBTRACT overflow", $time);
		A = 64'h8000000000000000; B = 64'd1;
		#(delay);
		assert(result == 64'h7FFFFFFFFFFFFFFF && overflow == 1 && negative == 0 && zero == 0);

		// AND
		$display("%t testing AND", $time);
		A = 64'hFFFF0000FFFF0000; B = 64'h0F0F0F0F0F0F0F0F;
		cntrl = ALU_AND;
		#(delay);
		assert(result == 64'h0F0F00000F0F0000 && negative == result[63] && zero == (result == 64'd0));

		// OR
		$display("%t testing OR", $time);
		cntrl = ALU_OR;
		#(delay);
		assert(result == 64'hFFFF0F0FFFFF0F0F && negative == result[63] && zero == 0);

		// XOR
		$display("%t testing XOR", $time);
		cntrl = ALU_XOR;
		#(delay);
		assert(result == 64'hF0F00F0FF0F00F0F && negative == result[63] && zero == 0);

		// Edge case: zero result
		$display("%t testing XOR (A == B)", $time);
		A = 64'hA5A5A5A5A5A5A5A5;
		B = 64'hA5A5A5A5A5A5A5A5;
		cntrl = ALU_XOR;
		#(delay);
		assert(result == 64'd0 && zero == 1 && negative == 0);
		
		
		// XOR edge: All zeros XOR all ones
		$display("%t testing XOR (0 ^ 1)", $time);
		A = 64'd0;
		B = 64'hFFFFFFFFFFFFFFFF;
		cntrl = ALU_XOR;
		#(delay);
		assert(result == 64'hFFFFFFFFFFFFFFFF && zero == 0 && negative == 1);
		
		// PASS B: edge case with all 1s
		$display("%t testing PASS_B (B = all 1s)", $time);
		A = 64'd0;
		B = 64'hFFFFFFFFFFFFFFFF;
		cntrl = ALU_PASS_B;
		#(delay);
		assert(result == 64'hFFFFFFFFFFFFFFFF && negative == 1 && zero == 0);
		
		// ADD: negative + negative with overflow
		$display("%t testing ADD (negative overflow)", $time);
		A = 64'h8000000000000000; // -2^63
		B = 64'h8000000000000000; // -2^63
		cntrl = ALU_ADD;
		#(delay);
		assert(result == 64'h0000000000000000 &&
		       overflow == 1 && carry_out == 1 && zero == 1 && negative == 0);
		
		$display("%t testing SUBTRACT (A-(-B))", $time);
		A = 64'h0000000000000002;
		B = 64'hFFFFFFFFFFFFFFFE; 
		cntrl = ALU_SUBTRACT;
		#(delay);
		assert(result == 64'h0000000000000004 &&
		       carry_out == 0 && overflow == 0 && zero == 0 && negative == 0);
		
		$display("%t All tests complete.", $time);
		
	end
endmodule 