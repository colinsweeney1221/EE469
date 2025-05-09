module cpu (clk, reset);

    input logic clk, reset;

// PARAMETERS: //////////////////////////////////////////////////////////////////////////////////////////////////////

    logic [63:0] pcCurr, pcNext;
    logic [31:0] instruction;
    logic [1:0][4:0] reg2LocIn, reg30In;
    logic [4:0] ReadRegister1, ReadRegister2, WriteRegister;
    logic [63:0] ReadData1, ReadData2, WriteData;
    logic [1:0][63:0] pc2ToRegIn;
    logic [63:0] ALUout;
    logic [63:0] add4;
    logic unused1, unused2;
    logic [63:0] ImmPlusPC, immediate;
    logic unused3, unused4;
    logic zero, overflow, negative, overflowOut, negativeOut;
    logic branchZero, branchLT, branchLT_and, branchType;
    logic branch_control;
    logic [1:0][63:0] branch1In, branch2In;
    logic [63:0] branch1Out;
    logic reg2Loc, reg30, regWrite, ALUSrc, setFlags, memRead, 
          memWrite, mem2Reg, PC2Reg, branch, whichCMP, uncondBranch, reg2PC;
    logic [2:0] ALUOp;
    logic [1:0] extend;
    logic [63:0] Imm12, Imm26, Imm19, Imm9;
    logic [63:0] mem2RegOut;
    logic carry_out;
    logic [1:0][63:0] memory_aluIn;

// Program Count /////////////////////////////////////////////////////////////////////////////////////////////////////
    
    register pc (pcCurr, pcNext, 1'b1, 1'b0, clk);

// Instruction Datapath - RegFile ////////////////////////////////////////////////////////////////////////////////////
    
    instructmem InstructionMemory (pcCurr, instruction, clk);

    assign reg2LocIn[1] = instruction[4:0];
    assign reg2LocIn[0] = instruction[20:16];

    mux5x2_1 regLoc (ReadRegister2, reg2LocIn, reg2Loc);

    assign reg30In[1] = instruction[4:0];
    assign reg30In[0] = 5'd30;

    mux5x2_1 x30    (WriteRegister, reg30In, reg30);

    assign ReadRegister1 = instruction[9:5];

    assign pc2ToRegIn[1] = add4;
    assign pc2ToRegIn[0] = mem2RegOut;
    
    mux64x2_1 pcToReg (WriteData, pc2ToRegIn, PC2Reg);

    regfile registerFile (ReadData1, ReadData2, WriteData, ReadRegister1, ReadRegister2, WriteRegister, regWrite, clk);

// ALU ////////////////////////////////////////////////////////////////////////////////////////////////////////////

    alu arithmetic (ReadData1, ReadData2, ALUOp, ALUout, negative, zero, overflow, carry_out);

// Add4 - Increment PC by one ////////////////////////////////////////////////////////////////////////////////////////
    
    adder nextInstruct (add4, unused1, unused2, 3'b010, pcCurr, 64'd4);

// Add PC + immediate - Branch //////////////////////////////////////////////////////////////////////////////////////
    
    adder branchImm (ImmPlusPC, unused3, unused4, 3'b010, pcCurr, immediate);

// Branching logic //////////////////////////////////////////////////////////////////////////////////////////////////////

    flag_reg flag_register (overflowOut, negativeOut, overflow, negative, setFlags, reset, clk);

    and zero_branch (branchZero, zero, branch);
    xor LT          (branchLT, overflowOut, negativeOut);
    and LT_branch   (branchLT_and, branchLT, branch);

    mux2_1 compare (branch_control, branchZero, branchLT_and, whichCMP);

    assign branch1In[1] = ImmPlusPC;
    assign branch1In[0] = add4;

    mux64x2_1 branch1 (branch1Out, branch1In, branch_control);     // adding 4 or adding immediate

    assign branch2In[1] = ALUout;
    assign branch2In[0] = branch1Out;

    mux64x2_1 branch2 (pcNext, branch2In, reg2PC);          // reg2PC

// Control /////////////////////////////////////////////////////////////////////////////////////////////////////
    
    control control_unit (instruction[31:21], reg2Loc, reg30, regWrite, ALUSrc, ALUOp, setFlags, memRead, 
                memWrite, mem2Reg, PC2Reg, branch, whichCMP, uncondBranch, reg2PC, extend);

    // Sign extend logic ////////////////////////////////////////////////////////////////////////////////////////////
   
    assign Imm12 = {52'b0, instruction[21:10]};
    assign Imm26 = {{36{instruction[25]}}, instruction[25:0], 2'b0}; // shifted left two bits
    assign Imm19 = {{43{instruction[23]}}, instruction[23:5], 2'b0};   // shifted left two bits
    assign Imm9  = {{55{instruction[20]}}, instruction[20:12]};

    mux64x4_1 signExtendChooser (immediate, Imm12, Imm26, Imm19, Imm9);

    // Data Memory //////////////////////////////////////////////////////////////////////////////////////////////////////
    
    datamem DataMemory (ALUout, memWrite, memRead, ReadData2, clk, 4'b1000, read_data);

    assign memory_aluIn[1] = read_data;
    assign memory_aluIn[0] = ALUout;

    mux64x2_1 memory_alu_mux (mem2RegOut, memory_aluIn, mem2Reg);
endmodule



module cpu_testbench();



endmodule