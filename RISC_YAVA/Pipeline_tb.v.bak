`include "Pipeline_top.v"

module top_tb;

reg rst;
reg clk=0;
integer i;

Pipeline_top TEST(clk,rst);

initial begin
    rst=0;
    #20;
    rst=1;
    #630 $finish;
end

always @(posedge clk) begin
    $display("[%0t] fetched instruction: %h",$time, TEST.Fetch.InstrD);
end

initial begin
    forever #5 clk=~clk;
end



initial begin
    $dumpfile("wave.vcd");
    $dumpvars();
end

endmodule