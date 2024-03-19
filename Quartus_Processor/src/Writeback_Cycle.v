module Writeback_Cycle(
    clk, rst, ReadDataW, ResultSrcW, ALUResultW, 
    PCPlus4W, ResultW
);

input clk, rst; 
input [1:0] ResultSrcW;
input [31:0] PCPlus4W, ALUResultW, ReadDataW;

output [31:0] ResultW;

Mux_3_by_1 result_mux(    
.a(ALUResultW),
.b(ReadDataW),
.c(PCPlus4W),
.s(ResultSrcW),
.d(ResultW)
);

endmodule
