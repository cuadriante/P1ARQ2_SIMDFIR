module Register_File(clk,rst,WE3,WD3,A1,A2,A3,RD1,RD2);

    input clk,rst,WE3;
    input [4:0]A1,A2,A3;
    input [255:0]WD3;
    output [255:0]RD1,RD2;

    reg [255:0] Register [31:0];

    always @ (posedge clk)
    begin
        if(WE3 & (A3 != 5'h00))
            Register[A3] <= WD3;
    end

    assign RD1 = (rst==1'b0) ? 256'd0 : Register[A1];
    assign RD2 = (rst==1'b0) ? 256'd0 : Register[A2];

    initial begin
        Register[0] = 256'h00000000;
    end

endmodule