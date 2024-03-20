module Fetch_Cycle(clk,rst,PCSrcE,PCTargetE,InstrD,PCD,PCPlus4D);

input clk,rst;
input PCSrcE;
input [31:0] PCTargetE;
output [31:0] PCPlus4D, PCD, InstrD;

wire [31:0] PC_F,PCF;
wire [31:0] InstrF,PCPlus4F;

//REGs
reg [31:0] InstrF_reg, PCF_reg, PCPlus4F_reg;


Mux MUX_FETCH(
    .a(PCPlus4F),
    .b(PCTargetE),
    .s(PCSrcE),
    .c(PC_F)
);

PC_Module Program_Counter(
    .clk(clk),
    .rst(rst),
    .PC(PCF),
    .PC_Next(PC_F)
);

PC_Adder PCAdder(
    .a(PCF),
    .b(32'd4),
    .c(PCPlus4F)
);

Instruction_Memory I_MEM(
    .rst(rst),
    .A(PCF),
    .RD(InstrF)
);

always @(negedge clk or negedge rst) begin
    if(rst) begin
        InstrF_reg<=InstrF;
        PCF_reg<=PCF;
        PCPlus4F_reg<=PCPlus4F;
    end
    else begin
        InstrF_reg<=32'd0;
        PCF_reg<=32'd0;
        PCPlus4F_reg<=32'd0; 
    end
end

assign InstrD=InstrF_reg;
assign PCD=PCF_reg;
assign PCPlus4D=PCPlus4F_reg;

endmodule