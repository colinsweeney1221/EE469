`timescale 1ps/1ps

module mux2_1_v2(out, in, sel);
	output out;
	input [1:0] in;
	input sel;
	
	logic notSel, top, bottom;

	not #(50) a (notSel, sel);
	and #(50) b (top, in[0], notSel);
	and #(50) c (bottom, in[1], sel);
	or  #(50) d (out, top, bottom);

endmodule 