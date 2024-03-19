
module Hazard_Unit(input  [4:0] Rs1D, Rs2D, Rs1E, Rs2E,
                input  [4:0] RdE, RdM, RdW,
                input  RegWriteM, RegWriteW,
				    input  ResultSrcE0, PCSrcE, rst,
                output reg [1:0] ForwardAE, ForwardBE,
                output StallD, StallF, FlushD, FlushE);
					 


wire lwStall;
always @(*) begin
ForwardAE = 2'b00;
    ForwardBE = 2'b00;
if ((Rs1E == RdM) & (RegWriteM) & (Rs1E != 0)) // higher priority - most recent
    ForwardAE = 2'b10; // for forwarding ALU Result in Memory Stage
else if ((Rs1E == RdW) & (RegWriteW) & (Rs1E != 0))
    ForwardAE = 2'b01; // for forwarding WriteBack Stage Result
            


if ((Rs2E == RdM) & (RegWriteM) & (Rs2E != 0))
    ForwardBE = 2'b10; // for forwarding ALU Result in Memory Stage

else if ((Rs2E == RdW) & (RegWriteW) & (Rs2E != 0))
    ForwardBE = 2'b01; // for forwarding WriteBack Stage Result

end


   assign lwStall = (ResultSrcE0 == 1) & ((RdE == Rs1D) | (RdE == Rs2D));
//   assign FlushE = lwStall;
	assign StallF = lwStall & (rst);
	assign StallD = lwStall & rst;
	
	assign FlushE = (lwStall | PCSrcE) & rst;
	assign FlushD = PCSrcE & rst;

endmodule
