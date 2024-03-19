// `include "ALU.v"
// `include "Mux.v"
// `include "PC_Adder.v"

module Execute_Cycle(clk, rst, RegWriteE, ResultSrcE, MemWriteE, BranchE, ALUControlE, ALUSrcAE, ALUSrcBE, JumpE,
RD1E,RD2E, PCE, RdE, ImmExtE,PCPlus4E, PCSrcE, PCTargetE, RegWriteM, ResultSrcM, MemWriteM, ALUResultM, 
WriteDataM, RdM, PCPlus4M, ResultW, ForwardAE, ForwardBE);

//IO
input clk, rst, RegWriteE, MemWriteE, BranchE;
input [3:0] ALUControlE;
input ALUSrcAE, JumpE;
input [1:0] ALUSrcBE,ResultSrcE;
input [4:0] RdE;
input [31:0] RD1E,RD2E, PCE, ImmExtE,PCPlus4E, ResultW;
input [1:0] ForwardAE, ForwardBE;

output PCSrcE, RegWriteM, MemWriteM;
output [31:0] ALUResultM, WriteDataM, PCPlus4M, PCTargetE;
output [4:0] RdM;
output [1:0] ResultSrcM;

//Internal wires
wire [31:0] SrcAE;
wire [31:0] SrcBE;
wire [31:0] ALUResultE;
wire ZeroE;
wire [31:0]RD2E_Mux;
wire [31:0]SrcAE_Inter;

//Regs
reg RegWriteM_reg, MemWriteM_reg;
reg [31:0] ALUResultM_reg, WriteDataM_reg, PCPlus4M_reg;
reg [4:0] RdM_reg;
reg [1:0] ResultSrcM_reg;

ALU ALU_E (
    .A(SrcAE),
    .B(SrcBE),
    .Result(ALUResultE),
    .ALUControl(ALUControlE),
    .OverFlow(),
    .Zero(ZeroE),
    .Negative()
);

PC_Adder ADDER_E(
    .a(PCE),
    .b(ImmExtE),
    .c(PCTargetE)
);

Mux_3_by_1 MUX3X1_3(
    .a(RD2E_Mux),
    .b(ImmExtE),
    .s(ALUSrcBE),
    .c(PCTargetE),
    .d(SrcBE)
);


Mux_3_by_1 MUX3X1_1(
    .a(RD1E),
    .b(ResultW),
    .c(ALUResultM),
    .s(ForwardAE),
    .d(SrcAE_Inter)
);

assign SrcAE=(ALUSrcAE) ? 32'b0:SrcAE_Inter;

Mux_3_by_1 MUX3X1_2(
    .a(RD2E),
    .b(ResultW),
    .c(ALUResultM),
    .s(ForwardBE),
    .d(RD2E_Mux)
);




always @(posedge clk or negedge rst) begin
    if (rst) begin
        RegWriteM_reg<=RegWriteE;
        ResultSrcM_reg<=ResultSrcE;
        MemWriteM_reg<=MemWriteE;
        ALUResultM_reg<=ALUResultE;
        WriteDataM_reg<=RD2E_Mux;
        RdM_reg<=RdE;
        PCPlus4M_reg<=PCPlus4E;
    end
    else begin
        RegWriteM_reg<=1'b0;
        ResultSrcM_reg<=2'd0;
        MemWriteM_reg<=1'd0;
        ALUResultM_reg<=32'd0;
        WriteDataM_reg<=32'd0;
        RdM_reg<=5'd0;
        PCPlus4M_reg<=32'd0;
    end
end

//Output Assignment
// assign PCSrcE=ZeroE&BranchE;
assign RegWriteM=RegWriteM_reg;
assign ResultSrcM=ResultSrcM_reg;
assign MemWriteM=MemWriteM_reg;
assign ALUResultM=ALUResultM_reg;
assign WriteDataM=WriteDataM_reg;
assign RdM=RdM_reg;
assign PCPlus4M=PCPlus4M_reg;

assign PCSrcE = (JumpE | (BranchE & ZeroE));


endmodule
