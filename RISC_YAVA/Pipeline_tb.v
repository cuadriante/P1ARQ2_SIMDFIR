module Pipeline_tb;

reg[3:0] i;
reg rst;
reg clk=0;

Pipeline_top Test(clk,rst);

initial begin
    rst=0;
    #20;
    rst=1;
    #630 $finish;
end

always @(posedge clk) begin
    $display("[%0t] fetched instruction: %h",$time, Test.Fetch.InstrD);
end

initial begin
    for (i = 0; i < 10; i = i + 1) begin
        #5 clk = ~clk;
    end
end


endmodule