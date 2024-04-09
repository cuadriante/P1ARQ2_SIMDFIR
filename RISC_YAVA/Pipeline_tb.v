module Pipeline_tb;

reg[4:0] i;
reg rst;
reg clk=0;

Pipeline_top Test(clk,rst);

initial begin
    rst=0;
    #10;
    rst=1;
    #200 $finish;
end

always @(posedge clk) begin
    $display("[%0t] fetched instruction: %h",$time, Test.Fetch.InstrD);
	 $display("[%0t] fetched instruction: %h",$time, Test.ResultW);
end

initial begin
    for (i = 0; i < 30; i = i + 1) begin
        #5 clk = ~clk;
    end
end


endmodule