module ALU(A,B,Result,ALUControl,RegFileSelect,OverFlow,Carry,Zero,Negative);

    input [255:0]A , B;
	 input RegFileSelect;
    input [2:0]ALUControl;
    output Carry,OverFlow,Zero,Negative;
    output [255:0]Result;
	
    wire Cout;
	 wire[255:0] vadd_result;
	 wire[255:0] vmult_result;
	 
	 
	 
	 
	 VAdder VAdd(
	 	.A(A),
	 	.B(B),
	 .Result(vadd_result),
	 .ALUControl(ALUControl));
	
	 
	 VMult VMul(
	 	.A(A),
	 	.B(B),
	 .Result(vmult_result));
	 
	
	 
	
	wire [15:0]Sum;

	assign Sum = (ALUControl[0] == 1'b0) ? A + B : (A + ((~B)+1)) ;
	assign {Cout,Result} = ((ALUControl == 3'b000) & (RegFileSelect == 0)) ? Sum :
									((ALUControl == 3'b001)& (RegFileSelect == 0)) ? Sum :
									((ALUControl == 3'b010) & (RegFileSelect == 0)) ? A & B :
									((ALUControl == 3'b011) & (RegFileSelect == 0)) ? A | B :
									((ALUControl == 3'b101) & (RegFileSelect == 0)) ? {{16{1'b0}},(Sum[15])} :
									((ALUControl == 3'b00?) & (RegFileSelect == 1)) ? {{1'b0},vadd_result} :
									((ALUControl == 3'b011) & (RegFileSelect == 1)) ? {{1'b0}, vmult_result} :
									((ALUControl == 3'b101) & (RegFileSelect == 1)) ? {{1'b0}, A[15:0], A[255:16]}:{255'b0};
									
	assign OverFlow = ((Sum[15] ^ A[15]) & 
							 (~(ALUControl[0] ^ B[15] ^ A[15])) &
							 (~ALUControl[1]));
	assign Carry = ((~ALUControl[1]) & Cout);
	assign Zero = &(~Result);
	assign Negative = Result[15];
	
	
endmodule
