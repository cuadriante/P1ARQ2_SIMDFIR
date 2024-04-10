module Pipeline_tb;

reg[4:0] i;
reg rst;
reg clk=0;
reg start_clk=0;

Pipeline_top Test(clk,rst);

initial begin
    rst=0;
    #10;
    rst=1;
	 #10;
	 rst=0;
	 start_clk=1;
    #200 $finish;
end

always @(posedge clk) begin
    $display("[%0t] fetched instruction: %h",$time, Test.Fetch.InstrD);
	 $display("[%0t] fetched ResultW: %h",$time, Test.ResultW);
	 $display("[%0t] fetched ALUResult: %h",$time, Test.Execute.ALU_E.Result);
	 //$display("[%0t] fetched ALUResult: %h",$time, Test.Decode.ALU_E.Result);
end

initial begin
    for (i = 0; i < 4; i = i + 1) begin
		  if (start_clk == 1) begin
				#5 clk = ~clk;
		  end
    end
end


endmodule