`timescale 1ns/1ps

module mux64x2_1 (out, in, sel);
	input [1:0][63:0] in;
	input sel;
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

module mux64x2_1_testbench();
	logic [1:0][63:0] in;
	logic sel;
	logic [63:0] out;
	 
	
	
    // Instantiate the DUT (Device Under Test)
    mux64x2_1 dut (
        .out(out),
        .in(in),
        .sel(sel)
    );

    initial begin
		// Initialize inputs with distinct patterns
      in[0] = 64'h0000000000000000;
      in[1] = 64'h1111111111111111;

		sel = 1'b1; #10;
      $display("sel: %b | out: %h", sel, out);
      sel = 1'b0; #10;
      $display("sel: %b | out: %h", sel, out);
	end
endmodule