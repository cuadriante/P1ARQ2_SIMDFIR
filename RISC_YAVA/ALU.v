module ALU(A,B,Result,ALUControl,RegFileSelect,OverFlow,Carry,Zero,Negative);

    input [255:0]A,B;
	 input RegFileSelect;
    input [2:0]ALUControl;
    output Carry,OverFlow,Zero,Negative;
    output [255:0]Result;
	
    wire Cout;
	 reg [16:0] C0, C1, C2, C3 , C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15;
	 reg [255:0] B_real;
	 
	 always @(*) begin
	 if (RegFileSelect) begin
	 
		case (ALUControl)
			 3'b000: begin
				
				B_real = (ALUControl == 3'b001) ? (~B) : B;

				
				C0 = A[15:0] + B_real[15:0];
				C1 = A[31:16] + B_real[31:16];
				C2 = A[47:32] + B_real[47:32];
				C3 = A[63:48] + B_real[63:48];
				C4 = A[79:64] + B_real[79:64];
				C5 = A[95:80] + B_real[95:80];
				C6 = A[111:96] + B_real[111:96];
				C7 = A[127:112] + B_real[127:112];
				C8 = A[143:128] + B_real[143:128];
				C9 = A[159:144] + B_real[159:144];
				C10 = A[175:160] + B_real[175:160];
				C11 = A[191:176] + B_real[191:176];
				C12 = A[207:192] + B_real[207:192];
				C13 = A[223:208] + B_real[223:208];
				C14 = A[239:224] + B_real[239:224];
				C15 = A[255:240] + B_real[255:240];
			
			end
			
			3'b00?: begin
				
				B_real = (ALUControl == 3'b001) ? (~B) : B;

				
				C0 = A[15:0] + B_real[15:0] + 1;
				C1 = A[31:16] + B_real[31:16] + 1;
				C2 = A[47:32] + B_real[47:32] + 1;
				C3 = A[63:48] + B_real[63:48] + 1;
				C4 = A[79:64] + B_real[79:64] + 1;
				C5 = A[95:80] + B_real[95:80] + 1;
				C6 = A[111:96] + B_real[111:96] + 1;
				C7 = A[127:112] + B_real[127:112] + 1;
				C8 = A[143:128] + B_real[143:128] + 1;
				C9 = A[159:144] + B_real[159:144] + 1;
				C10 = A[175:160] + B_real[175:160] + 1;
				C11 = A[191:176] + B_real[191:176] + 1;
				C12 = A[207:192] + B_real[207:192] + 1;
				C13 = A[223:208] + B_real[223:208] + 1;
				C14 = A[239:224] + B_real[239:224] + 1;
				C15 = A[255:240] + B_real[255:240] + 1;
			
			end
			
			3'b010: begin
				C0 = A[15:0] * B_real[15:0];
				C1 = A[31:16] * B_real[31:16];
				C2 = A[47:32] * B_real[47:32];
				C3 = A[63:48] * B_real[63:48];
				C4 = A[79:64] * B_real[79:64];
				C5 = A[95:80] * B_real[95:80];
				C6 = A[111:96] * B_real[111:96];
				C7 = A[127:112] * B_real[127:112];
				C8 = A[143:128] * B_real[143:128];
				C9 = A[159:144] * B_real[159:144];
				C10 = A[175:160] * B_real[175:160];
				C11 = A[191:176] * B_real[191:176];
				C12 = A[207:192] * B_real[207:192];
				C13 = A[223:208] * B_real[223:208];
				C14 = A[239:224] * B_real[239:224];
				C15 = A[255:240] * B_real[255:240];
				
			end
			
			default: begin
			  
			end
		endcase
		
		
		
	 end
	end
	 
	
	wire [15:0]Sum;

	assign Sum = (ALUControl[0] == 1'b0) ? A + B :
														(A + ((~B)+1)) ;
	assign {Cout,Result} = ((ALUControl == 3'b000) & (RegFileSelect == 0)) ? Sum :
									((ALUControl == 3'b001)& (RegFileSelect == 0)) ? Sum :
									((ALUControl == 3'b010) & (RegFileSelect == 0)) ? A & B :
									((ALUControl == 3'b011) & (RegFileSelect == 0)) ? A | B :
									((ALUControl == 3'b101) & (RegFileSelect == 0)) ? {{16{1'b0}},(Sum[15])} :
									((ALUControl == 3'b000) & (RegFileSelect == 1)) ? {C15, C14, C13, C12, C11, C10, C9, C8, C7, C6, C5, C4, C3, C2, C1, C0} :
									((ALUControl == 3'b001) & (RegFileSelect == 1)) ? {C15, C14, C13, C12, C11, C10, C9, C8, C7, C6, C5, C4, C3, C2, C1, C0} :
									((ALUControl == 3'b011) & (RegFileSelect == 1)) ? {C15, C14, C13, C12, C11, C10, C9, C8, C7, C6, C5, C4, C3, C2, C1, C0} :
									((ALUControl == 3'b101) & (RegFileSelect == 1)) ? {A[239:0], A[255:240]} :
									{17{1'b0}};
	assign OverFlow = ((Sum[15] ^ A[15]) & 
							 (~(ALUControl[0] ^ B[15] ^ A[15])) &
							 (~ALUControl[1]));
	assign Carry = ((~ALUControl[1]) & Cout);
	assign Zero = &(~Result);
	assign Negative = Result[15];
	
	
endmodule
