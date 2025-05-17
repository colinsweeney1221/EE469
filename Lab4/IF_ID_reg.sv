module IF_ID_reg (instruction, pc_4, instruction_out, pc_4_out, reset, clk, writeEnable);
	input clk, reset, writeEnable;
	input [31:0] instruction; 
	input [63:0] pc_4;
	output [31:0] instruction_out;
	output [63:0] pc_4_out; 
	
	genvar i;
	
	generate
		for (i = 0; i < 32; i++) begin : instruction
			register_bit instruction (instruction_out[i], instruction[i], writeEnable, reset, clk);
		end
	endgenerate
	
	generate 
		for (i = 0; i < 64; i++) begin : program_counter
			register_bit pc (pc_4_out[i], pc_4[i], writeEnable, reset, clk);
		end
	endgenerate
endmodule


		