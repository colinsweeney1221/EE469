module MEM_WB_reg (Rd, Rd_out, dataMemRead, dataMemRead_out, ALUResult, ALUResult_out,
						MemtoReg, MemtoReg_out, RegWrite, RegWrite_out, reset, writeEnable, clk);
		
	input clk, reset, writeEnable, MemtoReg, RegWrite;
	input [4:0] Rd;
	input [63:0] dataMemRead, ALUResult;
		
	output MemtoReg_out, RegWrite_out;
	output [4:0] Rd_out;
	output [63:0] dataMemRead_out, ALUResult_out;
		
	genvar i;
	resister_bit mem2reg (MemtoReg_out, MemtoReg, writeEnable, reset, clk);
	register_bit regwrite (RegWrite_out, RegWrite, writeEnable, reset, clk);
		
	
	generate
		for (i = 0; i < 5; i++) begin : instruction
			register_bit rd (Rd_out[i], Rd[i], writeEnable, reset, clk);
		end
	endgenerate
	
	generate
		for (i = 0; i < 64; i++) begin : bit_64
			register_bit dararead (dataMemRead_out[i], dataMemRead[i], writeEnable, reset, clk);
			register_bit aluresult (ALUResult_out[i], ALUResult[i], writeEnable, reset, clk);
		end
	endgenerate
endmodule

