`timescale 1ps/1ps

module mux2_1(out, i0, i1, sel);
	output out;
	input i0, i1, sel;
	
	logic notSel, top, bottom;

	not #(50) a (notSel, sel);
	and #(50) b (top, i0, notSel);
	and #(50) c (bottom, i1, sel);
	or  #(50) d (out, top, bottom);

endmodule 