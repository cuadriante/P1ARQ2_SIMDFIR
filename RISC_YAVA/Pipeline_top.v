module Pipeline_top(clk,rst, o_txd);
    input clk,rst;
	 output o_txd;

    // Declaration of Interim Wires
    wire PCSrcE, RegWriteW, RegFileSelect, RegWriteE, ALUSrcE, MemWriteE, ResultSrcE, BranchE, RegWriteM, MemWriteM, ResultSrcM, ResultSrcW;
    wire JumpE;
    wire [2:0] ALUControlE;
    wire [4:0] RDE, RDM, RDW;
    wire [255:0] PCTargetE, PCD, PCPlus4D, ResultW, RD1E, RD2E, ImmExtE, PCE, PCPlus4E, PCPlus4M, WriteDataM, ALUResultM;
    wire [255:0] PCPlus4W, ALUResultW, ReadDataW;
    wire [4:0] RS1_E, RS2_E;
    wire [1:0] ForwardBE, ForwardAE;
    wire [1:0] VForwardBE, VForwardAE;
	 reg r_tx_dv;
	wire w_tx_done;
    
    wire [31:0] PC;
	 
	 wire [31:0]InstrD;

    wire StallD, StallF, FlushD, FlushE;
    wire VStallD, VStallF, VFlushD, VFlushE;
    
    // Module Initiation

    // Fetch Stage

    Fetch_Cycle Fetch (
        .clk(clk), 
        .rst(rst), 
        .PCSrcE(PCSrcE), 
        .PCTargetE(PCTargetE), 
        .InstrD(InstrD), 
        .PCD(PCD), 
        .PCPlus4D(PCPlus4D)
    );

    // Decode Stage
    wire [4:0] Rs1D,Rs2D;
    
    Decode_Cycle Decode (
        .clk(clk), 
        .rst(rst), 
        .InstrD(InstrD), 
        .PCD(PCD), 
        .PCPlus4D(PCPlus4D), 
        .RegWriteW(RegWriteW), 
		  .RegFileSelect(RegFileSelect),
        .RDW(RDW), 
        .ResultW(ResultW), 
        .RegWriteE(RegWriteE), 
        .ALUSrcE(ALUSrcE), 
        .MemWriteE(MemWriteE), 
        .ResultSrcE(ResultSrcE),
        .BranchE(BranchE),  
        .ALUControlE(ALUControlE), 
        .RD1E(RD1E), 
        .RD2E(RD2E), 
        .ImmExtE(ImmExtE), 
        .RDE(RDE), 
        .PCE(PCE), 
        .PCPlus4E(PCPlus4E)
    );

    // Execute Stage
    Execute_Cycle Execute (
        .clk(clk), 
        .rst(rst), 
        .RegWriteE(RegWriteE), 
        .ALUSrcE(ALUSrcE), 
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
        .RegFileSelect(RegFileSelect),
        .RdM(RDM), 
        .PCPlus4M(PCPlus4M), 
        .WriteDataM(WriteDataM), 
        .ALUResultM(ALUResultM)
        //.ResultW(ResultW)
        //.ForwardA_E(ForwardAE),
        //.ForwardB_E(ForwardBE)
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
        .ResultSrcE0(ResultSrcE),
        .PCSrcE(PCSrcE),
        .rst(rst),
        .InstrD(InstrD),
        .RdM(RDM), 
        .RdW(RDW),
        .RdE(RDE), 
        .Rs1E(RS1_E), 
        .Rs2E(RS2_E), 
        .Rs1D(Rs1D),
        .Rs2D(Rs2D),
        .ForwardAE(ForwardAE), 
        .ForwardBE(ForwardBE),
        .VForwardAE(VForwardAE),
        .VForwardBE(VForwardBE),
        .StallD(StallD), 
        .StallF(StallF), 
        .FlushD(FlushD), 
        .FlushE(FlushE),
        .VStallD(VStallD),
        .VStallF(VStallF),
        .VFlushD(VFlushD),
        .VFlushE(VFlushE)
    );
	 
	 uart_tx #(.CLKS_PER_BIT(5208)) uart_tx (
    .i_Clock(clk),
    .i_Tx_DV(r_tx_dv),
    .i_Tx_Byte(ResultW), 
    .o_Tx_Active(),
    .o_Tx_Done(w_tx_done),
    .o_Tx_Serial(o_txd)
);

always @(posedge clk or posedge rst) begin
    if (rst) begin
        r_tx_dv <= 1'b0;
    end else if (!r_tx_dv) begin

        r_tx_dv <= 1'b1;
    end else if (w_tx_done) begin

        r_tx_dv <= 1'b0;
    end
end

endmodule
