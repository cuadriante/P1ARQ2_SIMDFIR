module Instruction_Memory(rst,A,RD);

  input rst;
  input [255:0]A;
  output [31:0]RD;

  reg [31:0] mem [0:1023];
  
  assign RD = (rst == 1'b0) ? {32{1'b0}} : mem[A[31:2]];

//  initial begin
//    $readmemh("memfile.hex",mem);
//  end



  initial begin
    //mem[0] = 32'hFFC4A303;
    //mem[1] = 32'h00832383;
    // mem[0] = 32'h0064A423;
    // mem[1] = 32'h00B62423;
    mem[0] = 32'b00000000000000001010000010000011;
    // mem[1] = 32'h00B62423;

  end


endmodule