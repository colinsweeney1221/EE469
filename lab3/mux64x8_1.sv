`timescale 1ns/1ps

module mux64x8_1 (out, in, sel);
	output [63:0] out;
	input [7:0][63:0] in;
	input [2:0] sel; //shouldn't this be 3 bits instead of 5?
	
	genvar i, j;
	
	generate
		for (i = 0; i < 64; i++) begin : eachMux
			logic [7:0] bitSlice;
			
			for (j = 0; j < 8; j++) begin : slicing
				assign bitSlice[j] = in[j][i];
			end
			
			mux8_1 a (out[i], bitSlice, sel);
		end
	endgenerate
endmodule 

module mux64x8_1_testbench();
	logic [63:0] out;
	logic [7:0][63:0] in;
	logic [2:0] sel; 
	
	
    // Instantiate the DUT (Device Under Test)
    mux64x8_1 dut (
        .out(out),
        .in(in),
        .sel(sel)
    );

    initial begin
		// Initialize inputs with distinct patterns
      in[0] = 64'h0000000000000000;
      in[1] = 64'h1111111111111111;
      in[2] = 64'h2222222222222222;
      in[3] = 64'h3333333333333333;
      in[4] = 64'h4444444444444444;
      in[5] = 64'h5555555555555555;
      in[6] = 64'h6666666666666666;
      in[7] = 64'h7777777777777777;

      sel = 3'b000; #10;
      $display("sel: %b | out: %h", sel, out);
      sel = 3'b001; #10;
      $display("sel: %b | out: %h", sel, out);
      sel = 3'b010; #10;
      $display("sel: %b | out: %h", sel, out);
      sel = 3'b011; #10;
      $display("sel: %b | out: %h", sel, out);
      sel = 3'b100; #10;
      $display("sel: %b | out: %h", sel, out);
      sel = 3'b101; #10;
      $display("sel: %b | out: %h", sel, out);
      sel = 3'b110; #10;
      $display("sel: %b | out: %h", sel, out);
      sel = 3'b111; #10;
      $display("sel: %b | out: %h", sel, out);
	end
endmodule
	
	