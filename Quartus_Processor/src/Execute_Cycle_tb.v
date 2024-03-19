`include "execute_cycle.v"

module top;

reg clk, rst, RegWriteE, ResultSrcE, MemWriteE, BranchE;
reg [2:0] ALUControlE;
reg ALUSrcE;
reg [4:0] RdE;
reg [31:0] RD1E,RD2E, PCE, ImmExtE,PCPlus4E;
wire PCSrcE, RegWriteM, ResultSrcM, MemWriteM;
wire [31:0] ALUResultM, WriteDataM, RdM, PCPlus4M, PCTargetE;

execute_cycle ec1 (clk, rst, RegWriteE, ResultSrcE, MemWriteE, BranchE, ALUControlE, ALUSrcE,
RD1E,RD2E, PCE, RdE, ImmExtE,PCPlus4E, PCSrcE, PCTargetE, RegWriteM, ResultSrcM, MemWriteM, ALUResultM, 
WriteDataM, RdM, PCPlus4M);

initial begin
    clk=0;
    rst=0;
    BranchE=0;
    ALUControlE=3'b000;
    ALUSrcE=0;
    #5 rst=1;
end
initial begin
    forever #2 clk=~clk;
end

initial begin
    RD1E=32'd1234;
    RD2E=32'd4321;
    #10
    ALUControlE=3'b001;
    #6;
    ALUControlE=3'b000;
    ALUSrcE=1;
    ImmExtE=32'h6969abcd;
    PCE=32'd7777;
    #10
    $finish;
end

initial begin
    $dumpfile("wave.vcd");
    $dumpvars();
end

endmodule