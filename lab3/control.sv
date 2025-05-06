module control(opCode, reg2Loc, reg30, regWrite, ALUSrc, ALUOp, setFlags, memRead, 
                memWrite, mem2Reg, PC2Reg, branch, whichCMP, uncondBranch, reg2PC, extend);

    input [10:0] opCode;
    output [2:0] ALUOp;
    output [1:0] extend;
    output reg2Loc, reg30, regWrite, ALUSrc, setFlags, memRead, 
           memWrite, mem2Reg, PC2Reg, branch, whichCMP, uncondBranch, reg2PC;

    always_comb begin
        case (opCode)
            12'h488:12'h489:   // ADDI

            12'h750:           // ADDS
            
            12'h0A0:12'h0BF:   // B
            
            12'h2A0:12'h2A7:   // B.LT
            
            12'h2A0:12'h4BF:   // BL
            
            12'h6B0:           // BR
            
            12'h5A0:12'h5A7:   // CBZ
            
            12'h7C2:           // LDUR
            
            12'h7C0:           // STUR
            
            12'h758:           // SUBS

            default: 


        endcase
    end
endmodule
