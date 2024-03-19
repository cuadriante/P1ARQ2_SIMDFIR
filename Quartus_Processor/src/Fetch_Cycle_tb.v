`include "PC.v"
`include "Mux.v"
`include "fetch_cycle.v"
`include "PC_Adder.v"
`include "Instruction_Memory.v"

module top;

reg clk,rst,PCSrcE;

reg [31:0]PCTargetE;
wire [31:0] PCPlus4D, PCD, InstrD;

fetch_cycle TB(
    clk,rst,PCSrcE,PCTargetE,InstrD,PCD,PCPlus4D
);

initial begin
    clk=0;
    forever #2 clk=~clk;
end

initial begin
    rst=0;
    #5 rst=1;
end

initial begin
    PCSrcE=0;
    #30 $finish;
end

initial begin
    $dumpfile("wave.vcd");
    $dumpvars();
end



endmodule

