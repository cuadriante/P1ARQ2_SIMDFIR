`include "ALU.v"
`include "Control_Unit_Top.v"
`include "Data_Memory.v"
`include "Decode_Cycle.v"
`include "Execute_Cycle.v"
`include "Fetch_Cycle.v"
`include "Instruction_Memory.v"
`include "Memory_Cycle.v"
`include "Mux.v"
`include "PC_Adder.v"
`include "PC.v"
`include "Register_File.v"
`include "Sign_Extend.v"
`include "Writeback_Cycle.v"
`include "Hazard_unit.v"

module Pipeline_top(clk,rst);
    input clk,rst;

    // Declaration of Interim Wires
    wire PCSrcE, RegWriteW, RegWriteE, ALUSrcAE, MemWriteE, BranchE, RegWriteM, MemWriteM;
    wire [1:0] ResultSrcM, ResultSrcW, ResultSrcE, ALUSrcBE;
    wire JumpE;
    wire [3:0] ALUControlE;
    wire [4:0] RDE, RDM, RDW;
    wire [31:0] PCTargetE, PCPlus4F_Fed,InstrD, PCD, PCPlus4D, ResultW, RD1E, RD2E, ImmExtE, PCE, PCPlus4E, PCPlus4M, WriteDataM, ALUResultM;
    wire [31:0] PCPlus4W, ALUResultW, ReadDataW;
    wire [4:0] RS1_E, RS2_E;
    wire [1:0] ForwardBE, ForwardAE;
    
    wire [31:0] PC;

    wire StallD, StallF, FlushD, FlushE;
    // Module Initiation
    // Fetch Stage

    PC_Module Program_Counter(
        .clk(clk),
        .rst(rst),
        .PC(PC),
        .PCSrcE(PCSrcE),
        .PCTargetE(PCTargetE),
        .PCPlus4F(PCPlus4F_Fed),
        .en(StallF)
    );

    Fetch_Cycle Fetch (
        .clk(clk), 
        .rst(rst), 
        .PCF(PC),
        .InstrD(InstrD), 
        .PCD(PCD), 
        .PCPlus4D(PCPlus4D),
        .PCPlus4F_Fed(PCPlus4F_Fed),
        .en(StallD),
        .clr(FlushD)
    );

    // Decode Stage
    Decode_Cycle Decode (
        .clk(clk), 
        .rst(rst), 
        .InstrD(InstrD), 
        .PCD(PCD), 
        .PCPlus4D(PCPlus4D), 
        .RegWriteW(RegWriteW), 
        .RDW(RDW), 
        .ResultW(ResultW), 
        .RegWriteE(RegWriteE), 
        .ALUSrcAE(ALUSrcAE), 
        .ALUSrcBE(ALUSrcBE), 
        .JumpE(JumpE), 
        .MemWriteE(MemWriteE), 
        .ResultSrcE(ResultSrcE),
        .BranchE(BranchE),  
        .ALUControlE(ALUControlE), 
        .RD1E(RD1E), 
        .RD2E(RD2E), 
        .ImmExtE(ImmExtE), 
        .RDE(RDE), 
        .PCE(PCE), 
        .PCPlus4E(PCPlus4E),
        .RS1E(RS1_E),
        .RS2E(RS2_E),
        .Rs1D(Rs1D),
        .Rs2D(Rs2D),
        .clr(FlushE)
    );

    wire [4:0] Rs1D,Rs2D;

    // Execute Stage
    Execute_Cycle Execute (
            .clk(clk), 
            .rst(rst), 
            .RegWriteE(RegWriteE), 
            .ALUSrcAE(ALUSrcAE), 
            .ALUSrcBE(ALUSrcBE), 
            .JumpE(JumpE),
            .MemWriteE(MemWriteE), 
            .ResultSrcE(ResultSrcE), 
            .BranchE(BranchE), 
            .ALUControlE(ALUControlE), 
            .RD1E(RD1E), 
            .RD2E(RD2E), 
            .ImmExtE(ImmExtE), 
            .RdE(RDE), 
            .PCE(PCE), 
            .PCPlus4E(PCPlus4E), 
            .PCSrcE(PCSrcE), 
            .PCTargetE(PCTargetE), 
            .RegWriteM(RegWriteM), 
            .MemWriteM(MemWriteM), 
            .ResultSrcM(ResultSrcM), 
            .RdM(RDM), 
            .PCPlus4M(PCPlus4M), 
            .WriteDataM(WriteDataM), 
            .ALUResultM(ALUResultM),
            .ResultW(ResultW),
            .ForwardAE(ForwardAE),
            .ForwardBE(ForwardBE)
        );
    
    // Memory Stage
    Memory_Cycle Memory (
        .clk(clk), 
        .rst(rst), 
        .RegWriteM(RegWriteM), 
        .MemWriteM(MemWriteM), 
        .ResultSrcM(ResultSrcM), 
        .RdM(RDM), 
        .PCPlus4M(PCPlus4M), 
        .WriteDataM(WriteDataM), 
        .ALUResultM(ALUResultM), 
        .RegWriteW(RegWriteW), 
        .ResultSrcW(ResultSrcW), 
        .RdW(RDW), 
        .PCPlus4W(PCPlus4W), 
        .ALUResultW(ALUResultW), 
        .ReadDataW(ReadDataW)
    );

    // Write Back Stage
    Writeback_Cycle WriteBack (
        .clk(clk), 
        .rst(rst), 
        .ResultSrcW(ResultSrcW), 
        .PCPlus4W(PCPlus4W), 
        .ALUResultW(ALUResultW), 
        .ReadDataW(ReadDataW), 
        .ResultW(ResultW)
    );

    Hazard_Unit HazardUnit(
        .RegWriteM(RegWriteM), 
        .RegWriteW(RegWriteW), 
        .ResultSrcE0(ResultSrcE[0]),
        .PCSrcE(PCSrcE),
        .RdM(RDM), 
        .RdW(RDW),
        .RdE(RDE), 
        .Rs1E(RS1_E), 
        .Rs2E(RS2_E), 
        .Rs1D(Rs1D),
        .Rs2D(Rs2D),
        .ForwardAE(ForwardAE), 
        .ForwardBE(ForwardBE),
        .StallD(StallD), 
        .StallF(StallF), 
        .FlushD(FlushD), 
        .FlushE(FlushE)
    );



endmodule
