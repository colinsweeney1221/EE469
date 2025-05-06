module flag_reg (overflowOut, negativeOut, overflow, negative, setFlags, reset, clk);
    input overflow, negative, setFlags, reset, clk;
    output overflowOut, negativeOut;

    register_bit overflowReg (overflowOut, overflow, setFlags, reset, clk);
    register_bit negativeReg (negativeOut, negative, setFlags, reset, clk);

endmodule