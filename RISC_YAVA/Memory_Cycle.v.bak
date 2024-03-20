// `include "Data_Memory.v"

module Memory_Cycle(
    clk, rst, RegWriteM, ResultSrcM, MemWriteM,
    ALUResultM, WriteDataM, RdM, PCPlus4M, ALUResultW,
    RegWriteW, ResultSrcW, ReadDataW, RdW, PCPlus4W
);

input clk,rst,RegWriteM,ResultSrcM,MemWriteM;
input [31:0] ALUResultM, WriteDataM, PCPlus4M;
input [4:0] RdM;

output [31:0] ReadDataW, PCPlus4W, ALUResultW;
output RegWriteW, ResultSrcW;
output [4:0]RdW;

wire [31:0] ReadDataM;

Data_Memory DataMem(
    .clk(clk),
    .rst(rst),
    .WE(MemWriteM),
    .WD(WriteDataM),
    .A(ALUResultM),
    .RD(ReadDataM)
);

reg [31:0] ReadDataW_reg, RdW_reg, PCPlus4W_reg, ALUResultW_reg;
reg RegWriteW_reg, ResultSrcW_reg;

always @(negedge clk or negedge rst) begin
    if(rst) begin
        ReadDataW_reg<=ReadDataM;
        RdW_reg<=RdM;
        PCPlus4W_reg<=PCPlus4M;
        ALUResultW_reg<=ALUResultM;
        RegWriteW_reg<=RegWriteM;
        ResultSrcW_reg<=ResultSrcM;
    end
    else begin
        ReadDataW_reg<=32'd0;
        RdW_reg<=5'd0;
        PCPlus4W_reg<=32'd0;
        ALUResultW_reg<=32'd0;
        RegWriteW_reg<=1'd0;
        ResultSrcW_reg<=1'd0;
    end
end

assign ReadDataW=ReadDataW_reg;
assign RdW=RdW_reg;
assign PCPlus4W=PCPlus4W_reg;
assign ALUResultW=ALUResultW_reg;
assign RegWriteW=RegWriteW_reg;
assign ResultSrcW=ResultSrcW_reg;

endmodule