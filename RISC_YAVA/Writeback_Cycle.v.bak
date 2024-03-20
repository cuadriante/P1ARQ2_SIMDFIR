module Writeback_Cycle(
    clk, rst, ReadDataW, ResultSrcW, ALUResultW, 
    PCPlus4W, ResultW
);

input clk, rst, ResultSrcW;
input [31:0] PCPlus4W, ALUResultW, ReadDataW;

output [31:0] ResultW;

Mux result_mux(    
.a(ALUResultW),
.b(ReadDataW),
.s(ResultSrcW),
.c(ResultW)
);

endmodule
