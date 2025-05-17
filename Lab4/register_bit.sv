`timescale 1ns/1ps

module register_bit (out, writeData, writeEnable, reset, clk);
	output out;
	input writeData, writeEnable, reset, clk;
	
	logic D;
	
	mux2_1_reg a (D, out, writeData, writeEnable);
	D_FF   b (out, D, reset, clk);
	
endmodule 


module register_bit_testbench();
	logic out;
	logic writeData, writeEnable, reset, CLOCK_50;
	
	parameter CLOCK_PERIOD=100;
	initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50; // Forever toggle the clock
	end
	
	register_bit dut (out, writeData, writeEnable, reset, CLOCK_50);
	
	initial begin
		
		reset <= 1; writeEnable <= 0; writeData <= 1; @(posedge CLOCK_50);
		reset <= 0;												 @(posedge CLOCK_50);
																	 @(posedge CLOCK_50);
		writeEnable <= 1;										 @(posedge CLOCK_50);
																	 @(posedge CLOCK_50);
		writeEnable <= 0;										 @(posedge CLOCK_50);
																	 @(posedge CLOCK_50);
		writeData <= 0;										 @(posedge CLOCK_50);
		writeData <= 1;										 @(posedge CLOCK_50);
																	 @(posedge CLOCK_50);										
		writeEnable <= 1;										 @(posedge CLOCK_50);
																	 @(posedge CLOCK_50);
		$stop;
		
	end
	
endmodule 