// `include "Control_Unit_Top.v"
// `include "Register_File.v"
// `include "Sign_Extend.v"

module Decode_Cycle(InstrD,PCD,PCPlus4D,clk,rst, RegWriteW, ResultW, RegFileSelect ,RDW, //i/p
RegWriteE, ResultSrcE, MemWriteE, BranchE, ALUSrcE, //o/p
RD1E, RD2E, PCE, RDE, ImmExtE, PCPlus4E, ALUControlE);

input clk,rst;
input [255:0] PCD, PCPlus4D;
input [255:0] ResultW;
input [4:0] RDW;
input RegWriteW;
input [31:0] InstrD;

output RegFileSelect;
output [255:0] RD1E, RD2E, PCE, ImmExtE, PCPlus4E;
output [4:0] RDE;
output RegWriteE, MemWriteE, BranchE, ALUSrcE;
output ResultSrcE;
output [2:0] ALUControlE;


//internal wires
wire RegWriteD,ALUSrcD,MemWriteD,ResultSrcD,BranchD;
wire [1:0]ImmSrcD;
wire [2:0]ALUControlD;
wire [255:0] RD1D,RD2D,ImmExtD, RD1D2, RD2D2;
wire [4:0] RdD;

assign RdD=InstrD[11:7];

Control_Unit_Top ctrl_unit(
    .Op(InstrD[6:0]),
    .funct7(InstrD[31:25]),
    .funct3(InstrD[14:12]),
    .RegWrite(RegWriteD),
    .ImmSrc(ImmSrcD),
    .ALUSrc(ALUSrcD),
    .MemWrite(MemWriteD),
    .ResultSrc(ResultSrcD),
    .Branch(BranchD),
    .ALUControl(ALUControlD)
);

Register_File RegFile(
    .clk(clk),
    .rst(rst),
    .WE3(RegWriteW),
    .WD3(ResultW),
    .A1(InstrD[19:15]),
    .A2(InstrD[24:20]),
    .A3(RDW),
    .RD1(RD1D),
    .RD2(RD2D)
);


Register_File RegFileVec(
    .clk(clk),
    .rst(rst),
    .WE3(RegWriteW),
    .WD3(ResultW),
    .A1(InstrD[19:15]),
    .A2(InstrD[24:20]),
    .A3(RDW),
    .RD1(RD1D2),
    .RD2(RD2D2)
);




Sign_Extend SignExtend(
    .In(InstrD[31:0]),
    .ImmSrc(ImmSrcD),
    .Imm_Ext(ImmExtD)
);

//Registers
reg [255:0] RD1D_reg, RD2D_reg, PCD_reg, ImmExtD_reg, PCPlus4D_reg;
reg [4:0] RDD_reg;
reg RegWriteD_reg, MemWriteD_reg, BranchD_reg, ALUSrcD_reg;
reg [1:0] ResultSrcD_reg;
reg [2:0] ALUControlD_reg;

always @(negedge clk or negedge rst) begin
    if(rst==0) begin
        RD1D_reg<=256'd0;
        RD2D_reg<=256'd0;
        PCD_reg<=256'd0;
        ImmExtD_reg<=256'd0;
        PCPlus4D_reg<=256'd0;
        RDD_reg<=256'd0;
        RegWriteD_reg<=1'd0;
        MemWriteD_reg<=1'd0;
        BranchD_reg<=1'd0;
        ALUSrcD_reg<=1'd0;
        ResultSrcD_reg<=1'd0;
        ALUControlD_reg<=3'd0;

    end
    else begin
        RD1D_reg<=RD1D;
        RD2D_reg<=RD2D;
        PCD_reg<=PCD;
        ImmExtD_reg<=ImmExtD;
        PCPlus4D_reg<=PCPlus4D;
        RDD_reg<=RdD;
        RegWriteD_reg<=RegWriteD;
        MemWriteD_reg<=MemWriteD;
        BranchD_reg<=BranchD;
        ALUSrcD_reg<=ALUSrcD;
        ResultSrcD_reg<=ResultSrcD;
        ALUControlD_reg<=ALUControlD;
    end
end

assign ALUControlE=ALUControlD_reg;
assign RegFileSelect = ((InstrD[6:0] == 7'b1000000) | (InstrD[6:0] == 7'b1000001) | (InstrD[6:0] == 7'b1000011) | (InstrD[6:0] == 7'b1000100) | (InstrD[6:0] == 7'b1000101)) ? 1'b1 : 1'b0;
assign RD1E = (RegFileSelect) ? RD1D2 : RD1D;
assign RD2E = (RegFileSelect) ? RD2D2 : RD2D;
assign PCE=PCD_reg;
assign ImmExtE=ImmExtD_reg;
assign PCPlus4E=PCPlus4D_reg;
assign RDE=RDD_reg;
assign RegWriteE=RegWriteD_reg;
assign MemWriteE=MemWriteD_reg;
assign BranchE=BranchD_reg;
assign ALUSrcE=ALUSrcD_reg;
assign ResultSrcE=ResultSrcD_reg;



endmodule