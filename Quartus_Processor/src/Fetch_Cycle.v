module Fetch_Cycle(clk,rst,PCF,InstrD,PCD,PCPlus4D, PCPlus4F_Fed,
en,clr);

input clk,rst;
input [31:0] PCF;
output [31:0] PCPlus4F_Fed;

input en, clr;

output [31:0] PCPlus4D, PCD, InstrD;

wire [31:0] PC_F,PCF;
wire [31:0] InstrF,PCPlus4F;

//REGs
reg [31:0] InstrF_reg, PCF_reg, PCPlus4F_reg;
assign PCPlus4F_Fed=PCPlus4F;

// Mux MUX_FETCH(
//     .a(PCPlus4F),
//     .b(PCTargetE),
//     .s(PCSrcE),
//     .c(PC_F)
// );

// PC_Module Program_Counter(
//     .clk(clk),
//     .rst(rst),
//     .PC(PCF),
//     .PC_Next(PC_F)
// );

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

always @(posedge clk or negedge rst) begin
    if(rst | ~clr | en) begin
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