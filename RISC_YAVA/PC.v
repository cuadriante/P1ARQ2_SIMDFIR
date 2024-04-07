module PC_Module(clk,rst,PC,PC_Next);
    input clk,rst;
    input [255:0]PC_Next;
    output reg [255:0]PC;

    always @(negedge clk or negedge rst)
    begin
        if(rst == 1'b0)
            PC <= 256'd0;
        else
            PC <= PC_Next;
    end
endmodule