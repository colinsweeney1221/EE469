`timescale 1ns/1ps

module mux64x4_1 (out, in, sel);
	input [3:0][63:0] in;
	input [1:0] sel;
	output [63:0] out;
	
	genvar i;
	
	generate
		for (i = 0; i < 64; i++) begin : slicing
			assign out[i] = in[sel][i];
		end
			
			//mux2_1 a (out[i], bitSlice, sel);
		//end
	endgenerate
endmodule 

module mux64x4_1_testbench();
	logic [3:0][63:0] in;
	logic [1:0] sel;
	logic [63:0] out;
	 
	
	
    // Instantiate the DUT (Device Under Test)
    mux64x4_1 dut (
        .out(out),
        .in(in),
        .sel(sel)
    );

    initial begin
		// Initialize inputs with distinct patterns
      in[0] = 64'h0000000000000000;
      in[1] = 64'h1111111111111111;
		in[2] = 64'hAAAAAAAAAAAAAAAA;
		in[3] = 64'hFFFFFFFFFFFFFFFF;

		sel = 2'b00; #10;
      $display("sel: %b | out: %h", sel, out);
      sel = 2'b01; #10;
      $display("sel: %b | out: %h", sel, out);
		sel = 2'b10; #10;
      $display("sel: %b | out: %h", sel, out);
      sel = 2'b11; #10;
      $display("sel: %b | out: %h", sel, out);
	end
endmodule