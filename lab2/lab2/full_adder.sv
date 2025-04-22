`timescale 1ps/1ps

module full_adder(out, carry_out, a, b, carry_in);
	output out, carry_out;
	input a, b, carry_in;
	
	logic half, carry1, carry2, out_and;
	
	half_adder c (half, carry1, a, b);
	half_adder d (out_and, carry2, half, carry_in);
	or #(50) e (carry_out, carry1, carry2);
	and #(50) f (out, out_and, out_and);
	
endmodule

module full_adder_testbench();
	logic out, carry_out, a, b, carry_in;
	
	full_adder dut (out, carry_out, a, b, carry_in);
	
	initial begin;
	
		// a = 0, b = 0, c = 0
		// expected: out = 0, co = 0
		
		a = 0; 
		b = 0; 
		carry_in = 0; #500
		
		// a = 0, b = 0, c = 1
		// expected: out = 1, co = 0
		
		a = 0; 
		b = 0; 
		carry_in = 1; #500
		
		// a = 0, b = 1, c = 0
		// expected: out = 1, co = 0
		
		a = 0; 
		b = 1; 
		carry_in = 0; #500
		
		// a = 0, b = 1, c = 1
		// expected: out = 0, co = 1
		
		a = 0; 
		b = 1; 
		carry_in = 1; #500
		
		// a = 1, b = 0, c = 0
		// expected: out = 1, co = 0
		
		a = 1; 
		b = 0; 
		carry_in = 0; #500
		
		// a = 1, b = 0, c = 1
		// expected: out = 0, co = 1
		
		a = 1; 
		b = 0; 
		carry_in = 1; #500
		
		// a = 1, b = 1, c = 0
		// expected: out = 0, co = 1
		
		a = 1; 
		b = 1; 
		carry_in = 0; #500
		
		// a = 1, b = 1, c = 1
		// expected: out = 1, co = 1
		
		a = 1; 
		b = 1; 
		carry_in = 1; #500
		
		$stop;
	end
endmodule 