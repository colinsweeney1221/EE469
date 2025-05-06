`timescale 1ns/1ps

module register (out, writeData, writeEnable, reset, clk);
	output [63:0] out;
	input [63:0] writeData;
	input writeEnable, reset, clk;
	
	genvar i;
	
	generate
		for (i = 0; i < 64; i++) begin : bits
			register_bit a (out[i], writeData[i], writeEnable, reset, clk);
		end
	endgenerate
	
endmodule 

module register_testbench();
	logic [63:0] out;
	logic [63:0] writeData;
	logic writeEnable, reset, CLOCK_50;
	
	parameter CLOCK_PERIOD=100;
	initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50; // Forever toggle the clock
	end
	
	register dut (out, writeData, writeEnable, reset, CLOCK_50);
	
	initial begin
		
		reset <= 1; 																							  @(posedge CLOCK_50);
		reset <= 0; 																							  @(posedge CLOCK_50);
		writeEnable <= 0; 																					  @(posedge CLOCK_50);
		writeData <= 64'b1111111111111111111111111111111111111111111111111111111111111111; @(posedge CLOCK_50);
																													  @(posedge CLOCK_50);
																													  @(posedge CLOCK_50);
																													  @(posedge CLOCK_50);
																													  @(posedge CLOCK_50);
																													  @(posedge CLOCK_50);
																													  @(posedge CLOCK_50);
																													  @(posedge CLOCK_50);
																													  @(posedge CLOCK_50);
		writeEnable <= 1; 																					  @(posedge CLOCK_50);
																													  @(posedge CLOCK_50);
																													  @(posedge CLOCK_50);
																													  @(posedge CLOCK_50);
		writeEnable <= 0; 																				     @(posedge CLOCK_50);
		writeData <= 0;																						  @(posedge CLOCK_50);
																													  @(posedge CLOCK_50);
																													  @(posedge CLOCK_50);
																													  @(posedge CLOCK_50);
																													  @(posedge CLOCK_50);
																													  @(posedge CLOCK_50);
		writeEnable <= 1; @(posedge CLOCK_50);
																													  @(posedge CLOCK_50);
																													  @(posedge CLOCK_50);
																													  @(posedge CLOCK_50);
		
		$stop;
	
	end
	
endmodule 