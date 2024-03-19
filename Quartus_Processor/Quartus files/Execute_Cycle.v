// `include "ALU.v"
// `include "Mux.v"
// `include "PC_Adder.v"

module Execute_Cycle(clk, rst, RegWriteE, ResultSrcE, MemWriteE, BranchE, ALUControlE, ALUSrcE,
RD1E,RD2E, PCE, RdE, ImmExtE,PCPlus4E, PCSrcE, PCTargetE, RegWriteM, ResultSrcM, MemWriteM, ALUResultM, 
WriteDataM, RdM, PCPlus4M);

//IO
input clk, rst, RegWriteE, ResultSrcE, MemWriteE, BranchE;
input [2:0] ALUControlE;
input ALUSrcE;
input [4:0] RdE;
input [31:0] RD1E,RD2E, PCE, ImmExtE,PCPlus4E;
output PCSrcE, RegWriteM, ResultSrcM, MemWriteM;
output [31:0] ALUResultM, WriteDataM, PCPlus4M, PCTargetE;
output [4:0] RdM;

//Internal wires
wire [31:0] SrcBE;
wire [31:0] ALUResultE;
wire ZeroE;

//Regs
reg RegWriteM_reg, ResultSrcM_reg, MemWriteM_reg;
reg [31:0] ALUResultM_reg, WriteDataM_reg, PCPlus4M_reg;
reg [4:0] RdM_reg;

ALU ALU_E (
    .A(RD1E),
    .B(SrcBE),
    .Result(ALUResultE),
    .ALUControl(ALUControlE),
    .OverFlow(),
    .Carry(),
    .Zero(ZeroE),
    .Negative()
);

PC_Adder ADDER_E(
    .a(PCE),
    .b(ImmExtE),
    .c(PCTargetE)
);

Mux MUX_E(
    .a(RD2E),
    .b(ImmExtE),
    .s(ALUSrcE),
    .c(SrcBE)
);

always @(negedge clk or negedge rst) begin
    if (rst==0) begin

		          RegWriteM_reg<=1'b0;
        ResultSrcM_reg<=1'd0;
        MemWriteM_reg<=1'd0;
        ALUResultM_reg<=32'd0;
        WriteDataM_reg<=32'd0;
        RdM_reg<=5'd0;
        PCPlus4M_reg<=32'd0;
    end
    else begin
        RegWriteM_reg<=RegWriteE;
        ResultSrcM_reg<=ResultSrcE;
        MemWriteM_reg<=MemWriteE;
        ALUResultM_reg<=ALUResultE;
        WriteDataM_reg<=RD2E;
        RdM_reg<=RdE;
        PCPlus4M_reg<=PCPlus4E;
    end
end

//Output Assignment
assign PCSrcE=ZeroE&BranchE;
assign RegWriteM=RegWriteM_reg;
assign ResultSrcM=ResultSrcM_reg;
assign MemWriteM=MemWriteM_reg;
assign ALUResultM=ALUResultM_reg;
assign WriteDataM=WriteDataM_reg;
assign RdM=RdM_reg;
assign PCPlus4M=PCPlus4M_reg;


endmodule
