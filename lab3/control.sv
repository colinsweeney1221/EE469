module control(opCode, reg2Loc, reg30, regWrite, ALUSrc, ALUOp, setFlags, memRead, 
                memWrite, mem2Reg, PC2Reg, branch, whichCMP, uncondBranch, reg2PC, extend);

    input [10:0] opCode;
    output [2:0] ALUOp;
    output [1:0] extend;
    output reg2Loc, reg30, regWrite, ALUSrc, setFlags, memRead, 
           memWrite, mem2Reg, PC2Reg, branch, whichCMP, uncondBranch, reg2PC;

    always_comb begin
        case (opCode)
            11'h488:11'h489: begin   // ADDI
                             reg2Loc      = 1'bX
                             reg30        = 1'b0
                             regWrire     = 1'b1
                             ALUSrc       = 1'b1
                             ALUOp        = 3'b010
                             setFlags     = 1'b0
                             memRead      = 1'bX
                             memWrite     = 1'b0
                             mem2Reg      = 1'b0
                             PC2Reg       = 1'b0
                             branch       = 1'b0
                             whichCMP     = 1'bX
                             uncondBranch = 1'b0
                             reg2PC       = 1'b0
                             extend       = 2'b0
                             end

            11'h750:         begin  // ADDS
                             reg2Loc      = 1'b0
                             reg30        = 1'b0
                             regWrite     = 1'b1
                             ALUSrc       = 1'b0
                             ALUOp        = 3'b010
                             setFlags     = 1'b1
                             memRead      = 1'bX
                             memWrite     = 1'b0
                             mem2Reg      = 1'b0
                             PC2Reg       = 1'b0
                             branch       = 1'b0
                             whichCMP     = 1'bX
                             uncondBranch = 1'bX
                             reg2PC       = 1'b0
                             extend       = 2'bX
                             end
            
            11'h0A0:11'h0BF: begin  // B
                             reg2Loc      = 1'bX
                             reg30        = 1'bX
                             regWrite     = 1'b0
                             ALUSrc       = 1'bX
                             ALUOp        = 3'bX
                             setFlags     = 1'b0
                             memRead      = 1'bX
                             memWrite     = 1'b0
                             mem2Reg      = 1'bX
                             PC2Reg       = 1'bX
                             branch       = 1'bX
                             whichCMP     = 1'bX
                             uncondBranch = 1'b1
                             reg2PC       = 1'b0
                             extend       = 1'b01
                             end
            
            11'h2A0:11'h2A7: begin  // B.LT
                             reg2Loc      = 1'bX
                             reg30        = 1'bX
                             regWrite     = 1'b0
                             ALUSrc       = 1'bX
                             ALUOp        = 3'bX
                             setFlags     = 1'b0
                             memRead      = 1'bX
                             memWrite     = 1'b0
                             mem2Reg      = 1'bX
                             PC2Reg       = 1'bX
                             branch       = 1'b1
                             whichCMP     = 1'b1
                             uncondBranch = 1'b0
                             reg2PC       = 1'b0
                             extend       = 2'b10
                             end
            
            11'h2A0:11'h4BF: begin  // BL
                             reg2Loc      = 1'bX
                             reg30        = 1'b1
                             regWrite     = 1'b1
                             ALUSrc       = 1'bX
                             ALUOp        = 3'bX
                             setFlags     = 1'b0
                             memRead      = 1'bX
                             memWrite     = 1'b0
                             mem2Reg      = 1'bX
                             PC2Reg       = 1'b1
                             branch       = 1'bX
                             whichCMP     = 1'bX
                             uncondBranch = 1'b1
                             reg2PC       = 1'b0
                             extend       = 2'b01
                             end
            
            11'h6B0:         begin  // BR
                             reg2Loc      = 1'b1
                             reg30        = 1'bX
                             regWrite     = 1'b0
                             ALUSrc       = 1'b0
                             ALUOp        = 3'b000
                             setFlags     = 1'b0
                             memRead      = 1'bX
                             memWrite     = 1'b0
                             mem2Reg      = 1'bX
                             PC2Reg       = 1'bX
                             branch       = 1'bX
                             whichCMP     = 1'bX
                             uncondBranch = 1'bX
                             reg2PC       = 1'b1
                             extend       = 2'bX
                             end
            
            11'h5A0:11'h5A7: begin  // CBZ
                             reg2Loc      = 1'b1
                             reg30        = 1'bX
                             regWrite     = 1'b0
                             ALUSrc       = 1'b0
                             ALUOp        = 3'b000
                             setFlags     = 1'b0
                             memRead      = 1'bX
                             memWrite     = 1'b0
                             mem2Reg      = 1'bX
                             PC2Reg       = 1'bX
                             branch       = 1'b1
                             whichCMP     = 1'b0
                             uncondBranch = 1'b0
                             reg2PC       = 1'b0
                             extend       = 2'b10
                             end
            
            11'h7C2:         begin  // LDUR
                             reg2Loc      = 1'bX
                             reg30        = 1'b0
                             regWrite     = 1'b1
                             ALUSrc       = 1'b1
                             ALUOp        = 3'b010
                             setFlags     = 1'b0
                             memRead      = 1'b1
                             memWrite     = 1'b0
                             mem2Reg      = 1'b1
                             PC2Reg       = 1'b0
                             branch       = 1'b0
                             whichCMP     = 1'bX
                             uncondBranch = 1'b0
                             reg2PC       = 1'b0
                             extend       = 2'b11
                             end
            
            11'h7C0:         begin  // STUR
                             reg2Loc      = 1'b1
                             reg30        = 1'bX
                             regWrite     = 1'b0
                             ALUSrc       = 1'b1
                             ALUOp        = 3'b010
                             setFlags     = 1'b0
                             memRead      = 1'bX
                             memWrite     = 1'b1
                             mem2Reg      = 1'bX
                             PC2Reg       = 1'bX
                             branch       = 1'b0
                             whichCMP     = 1'bX
                             uncondBranch = 1'b0
                             reg2PC       = 1'b0
                             extend       = 2'b11
                             end
            
            11'h758:         begin  // SUBS
                             reg2Loc      = 1'b0
                             reg30        = 1'b0
                             regWrite     = 1'b1
                             ALUSrc       = 1'b0
                             ALUOp        = 3'b011
                             setFlags     = 1'b1
                             memRead      = 1'bX
                             memWrite     = 1'b0
                             mem2Reg      = 1'b0
                             PC2Reg       = 1'b0
                             branch       = 1'b0
                             whichCMP     = 1'bX
                             uncondBranch = 1'b0
                             reg2PC       = 1'b0
                             extend       = 2'bX
                             end

            default:        begin 
                             reg2Loc      = 1'bX
                             reg30        = 1'bX
                             regWrite     = 1'bX
                             ALUSrc       = 1'bX
                             ALUOp        = 1'bX
                             setFlags     = 1'bX
                             memRead      = 1'bX
                             memWrite     = 1'bX
                             mem2Reg      = 1'bX
                             PC2Reg       = 1'bX
                             branch       = 1'bX
                             whichCMP     = 1'bX
                             uncondBranch = 1'bX
                             reg2PC       = 1'bX
                             extend       = 1'bX
                             end
        endcase
    end
endmodule