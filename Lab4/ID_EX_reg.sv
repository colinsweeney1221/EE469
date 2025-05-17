module ID_EX_reg (Rd, Rd_out, Rn, Rn_out, Rm_or_Rt, Rm_or_Rt_out, 
						Immediate12, Immediate12_out, Immediate9, Immediate9_out, 
						readData1, readData1_out, readData2, readData2_out, ALUOp, ALUOp_out, 
						ALUSrc, ALUSrc_out, branch, branch_out, MemRead, MemRead_out, 
						MemWrite,MemWrite_out, MemtoReg, MemtoReg_out, RegWrite, RegWrite_out, reset, writeEnable, clk);
		
		input clk, reset, writeEnable,s ALUSrc , branch, MemRead, MemWrite, MemtoReg, RegWrite;
		input [2:0] ALUOp;
		input [4:0] Rd, Rn, Rm_or_Rt;
		input [63:0] Immediate12, Immediate9, readData1, readData2;
		
		output ALUSrc_out, branch_out, MemRead_out, MemWrite_out, MemtoReg_out, RegWrite_out;
		output [2:0] ALUOp_out;
		output [4:0] Rd_out, Rn_out, Rm_or_Rt_out;
		output [63:0] Immediate12_out, Immediate9_out, readData1_out, readData2_out;
		
		genvar i;
		
		register_bit alusrc (ALUSrc_out, ALUSrc, writeEnable, reset, clk);
		register_bit branch_bit(branch_out, branch, writeEnable, reset, clk);
		register_bit memread (MemRead_out, MemRead, writeEnable, reset, clk);
		register_bit memwrite(MemWrite_out, MemWrite, writeEnable, reset, clk);
		resister_bit mem2reg (MemtoReg_out, MemtoReg, writeEnable, reset, clk);
		register_bit regwrite (RegWrite_out, RegWrite, writeEnable, reset, clk);
		
		generate
		for (i = 0; i < 3; i++) begin : ALUcode
			register_bit alucode (ALUOp_out[i], ALUOp[i], writeEnable, reset, clk);
		end
	endgenerate 
	
	generate
		for (i = 0; i < 5; i++) begin : instruction
			register_bit rd (Rd_out[i], Rd[i], writeEnable, reset, clk);
			register_bit rn (Rn_out[i], Rn[i], writeEnable, reset, clk);
			register_bit rm/rt (Rm_or_Rt_out[i], Rm_or_Rt[i], writeEnable, reset, clk);
		end
	endgenerate
	
	generate
		for (i = 0; i < 64; i++) begin : bit_64
			register_bit imm12 (Immediate12_out[i], Immediate12[i], writeEnable, reset, clk);
			register_bit imm9 (Immediate9_out[i], Immediate9[i], writeEnable, reset, clk);
			register_bit read1 (readData1_out[i], readData1[i], writeEnable, reset, clk);
			register_bit read2 (readData2_out[i], readData2[i], writeEnable, reset, clk);
		end
	endgenerate
endmodule

