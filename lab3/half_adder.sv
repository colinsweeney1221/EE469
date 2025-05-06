`timescale 1ps/1ps

module half_adder(out, carry_out, a, b);
	output out, carry_out;
	input a, b;
	
	xor #(50) c (out, a, b);
	and #(50) d (carry_out, a, b);
	
endmodule

module half_adder_testbench();
	logic out, carry_out, a, b;
	
	
	half_adder dut (out, carry_out, a, b);
	
	initial begin;
		
		// a = 0, b = 0
		// excpected: out = 0, carry_out = 0
		
		a = 0; 
		b = 0; #200
		
		// a = 0 b = 1
		// excpected: out = 1, carry_out = 0
		
		a = 0; 
		b = 1; #200
		
		// a = 1 b = 0
		// excpected: out = 1, carry_out = 0
		
		a = 1; 
		b = 0; #200
		
		// a = 1 b = 1
		// excpected: out = 0, carry_out = 1
		
		a = 1; 
		b = 1; #200
		
		$stop;
	end
endmodule
