// `include "Control_Unit_Top.v"
// `include "Register_File.v"
// `include "Sign_Extend.v"

module Decode_Cycle(InstrD,PCD,PCPlus4D,clk,rst, RegWriteW, ResultW, RDW, //i/p
RegWriteE, ResultSrcE, MemWriteE, BranchE, ALUSrcAE, ALUSrcBE, JumpE, //o/p
RD1E, RD2E, PCE, Rs1D, clr, Rs2D, RDE, ImmExtE, PCPlus4E, ALUControlE, RS1E, RS2E);

input clk,rst;
input [31:0] InstrD, PCD, PCPlus4D;
input [31:0] ResultW;
input [4:0] RDW;
input RegWriteW;
input clr;

output [31:0] RD1E, RD2E, PCE, ImmExtE, PCPlus4E;
output [4:0] RDE;
output RegWriteE, MemWriteE, BranchE, ALUSrcAE;
output [1:0] ALUSrcBE;
output JumpE;
output [1:0] ResultSrcE;
output [3:0] ALUControlE;
output [4:0] RS1E, RS2E;
output [4:0] Rs1D, Rs2D;
assign Rs1D=RS1D;
assign Rs2D=RS2D;

//internal wires
wire RegWriteD,ALUSrcAD,MemWriteD,BranchD, JumpD;
wire [1:0] ALUSrcBD,ResultSrcD;
wire [2:0]ImmSrcD;
wire [3:0]ALUControlD;
wire [31:0] RD1D,RD2D,ImmExtD;
wire [4:0] RdD;
wire [4:0] RS1D, RS2D;

assign RS1D=InstrD[19:15];
assign RS2D=InstrD[24:20];

assign RdD=InstrD[11:7];

Control_Unit_Top ctrl_unit(
    .Op(InstrD[6:0]),
    .funct7(InstrD[31:25]),
    .funct3(InstrD[14:12]),
    .RegWrite(RegWriteD),
    .ImmSrc(ImmSrcD),
    .ALUSrcA(ALUSrcAD),
    .ALUSrcB(ALUSrcBD),
    .MemWrite(MemWriteD),
    .ResultSrc(ResultSrcD),
    .Branch(BranchD),
    .ALUControl(ALUControlD),
    .Jump(JumpD)
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

Sign_Extend SignExtend(
    .In(InstrD[31:7]),
    .ImmSrc(ImmSrcD),
    .Imm_Ext(ImmExtD)
);

//Registers
reg [31:0] RD1D_reg, RD2D_reg, PCD_reg, ImmExtD_reg, PCPlus4D_reg;
reg [4:0] RDD_reg;
reg RegWriteD_reg, MemWriteD_reg, BranchD_reg, ALUSrcAD_reg;
reg [1:0] ALUSrcBD_reg;
reg [1:0] ResultSrcD_reg;
reg [3:0] ALUControlD_reg;
reg [4:0] RS1D_reg, RS2D_reg;
reg JumpD_reg;


always @(posedge clk or negedge rst) begin
    if(rst | (~clr)) begin
        RD1D_reg<=RD1D;
        RD2D_reg<=RD2D;
        PCD_reg<=PCD;
        ImmExtD_reg<=ImmExtD;
        PCPlus4D_reg<=PCPlus4D;
        RDD_reg<=RdD;
        RegWriteD_reg<=RegWriteD;
        MemWriteD_reg<=MemWriteD;
        BranchD_reg<=BranchD;
        ALUSrcAD_reg<=ALUSrcAD;
        ALUSrcBD_reg<=ALUSrcBD;
        JumpD_reg<=JumpD;
        ResultSrcD_reg<=ResultSrcD;
        ALUControlD_reg<=ALUControlD;
        RS1D_reg<=RS1D;
        RS2D_reg<=RS2D;
    end
    else begin
        RD1D_reg<=32'd0;
        RD2D_reg<=32'd0;
        PCD_reg<=32'd0;
        ImmExtD_reg<=32'd0;
        PCPlus4D_reg<=32'd0;
        RDD_reg<=32'd0;
        RegWriteD_reg<=1'd0;
        MemWriteD_reg<=1'd0;
        BranchD_reg<=1'd0;
        ALUSrcAD_reg<=1'd0;
        ALUSrcBD_reg<=2'd0;
        JumpD_reg<=1'd0;
        ResultSrcD_reg<=2'd0;
        ALUControlD_reg<=4'd0;
        RS1D_reg<=5'd0;
        RS2D_reg<=5'd0;
    end
end

assign RD1E=RD1D_reg;
assign RD2E=RD2D_reg;
assign PCE=PCD_reg;
assign ImmExtE=ImmExtD_reg;
assign PCPlus4E=PCPlus4D_reg;
assign RDE=RDD_reg;
assign RegWriteE=RegWriteD_reg;
assign MemWriteE=MemWriteD_reg;
assign BranchE=BranchD_reg;
assign ALUSrcAE=ALUSrcAD_reg;
assign ALUSrcBE=ALUSrcBD_reg;
assign JumpE=JumpD_reg;
assign ResultSrcE=ResultSrcD_reg;
assign ALUControlE=ALUControlD_reg;
assign RS1E=RS1D_reg;
assign RS2E=RS2D_reg;
// RS2D_reg<=RS2D;


endmodule