module PC_Module(clk,rst,PC, PCSrcE,PCTargetE, PCPlus4F, en);
    input clk,rst;
    input en;
    wire [31:0]PC_Next;
    output reg [31:0]PC;
    input PCSrcE;
    input [31:0] PCPlus4F,PCTargetE;

    always @(posedge clk or negedge rst)
    begin
        if(rst == 1'b0)
            PC <= 32'd0;
        else if(!en)
            PC <= PC_Next;
        else
            PC <= 32'd0;
    end

    Mux MUX_FETCH(
        .a(PCPlus4F),
        .b(PCTargetE),
        .s(PCSrcE),
        .c(PC_Next)
    );

endmodule