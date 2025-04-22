module register_file (readOut1, readOut2, data1, data2, writeReg, writeData, writeEnable, reset, clk);
	output [63:0] readOut1, readOut2;
	input [4:0] data1, data2, writeReg;
	input [63:0] writeData;
	input writeEnable, reset, clk;
	
	logic [31:0] writeSelect;
	
	decoder5_32 a (wireSelect, writeReg, writeEnable);
	
	logic [31:0][63:0] regArray;
	
	genvar i;
	
	generate
		for (i = 0; i < 32; i++) begin : registers
			register b (regArray[i], writeData, writeEnable, reset, clk);
		end
	endgenerate
	
	mux64 c (data1, regArray, read1);
	mux64 d (data2, regArray, read2);
	
endmodule 


module register_file_testbench();
	logic [63:0] readOut1, readOut2;
	logic [4:0] dat1, data2, writeReg;
	logic [63:0] writeData;
	logic writeEnable, reset, clk;
	
	
	
	
endmodule 