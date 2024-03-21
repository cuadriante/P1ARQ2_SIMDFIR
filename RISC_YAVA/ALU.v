module ALU(A,B,Result,ALUControl,RegFileSelect,OverFlow,Carry,Zero,Negative);

    input [255:0]A,B;
	 input RegFileSelect;
    input [2:0]ALUControl;
    output Carry,OverFlow,Zero,Negative;
    output [255:0]Result;

    wire Cout;
	 
	 if (RegFileSelect) begin
	 
		case (ALUControl)
			 3'b00?: begin
				
				wire [255:0] B_real = (ALUControl == 3'b001) ? (~B) : B;

				
				wire [16:0] C0 = A[15:0] + B_real[15:0] + ___sub_condition___;
				wire [16:0] C1 = A[31:16] + B_real[31:16] + (C0[16] & (O | H)) + (Q & ___sub_condition___);
				wire [16:0] C2 = A[47:32] + B_real[47:32] + (C1[16] & (H)) + (Q & ___sub_condition___);
				wire [16:0] C3 = A[63:48] + B_real[63:48] + (C2[16] & (O | H)) + (Q & ___sub_condition___);
				wire [16:0] C4 = A[79:64] + B_real[79:64] + (C3[16] & (H)) + (Q & ___sub_condition___);
				wire [16:0] C5 = A[95:80] + B_real[95:80] + (C4[16] & (O | H)) + (Q & ___sub_condition___);
				wire [16:0] C6 = A[111:96] + B_real[111:96] + (C5[16] & (H)) + (Q & ___sub_condition___);
				wire [16:0] C7 = A[127:112] + B_real[127:112] + (C6[16] & (O | H)) + (Q & ___sub_condition___);
				wire [16:0] C8 = A[143:128] + B_real[143:128] + (C7[16] & (H)) + (Q & ___sub_condition___);
				wire [16:0] C9 = A[159:144] + B_real[159:144] + (C8[16] & (O | H)) + (Q & ___sub_condition___);
				wire [16:0] C10 = A[175:160] + B_real[175:160] + (C9[16] & (H)) + (Q & ___sub_condition___);
				wire [16:0] C11 = A[191:176] + B_real[191:176] + (C10[16] & (O | H)) + (Q & ___sub_condition___);
				wire [16:0] C12 = A[207:192] + B_real[207:192] + (C11[16] & (H)) + (Q & ___sub_condition___);
				wire [16:0] C13 = A[223:208] + B_real[223:208] + (C12[16] & (O | H)) + (Q & ___sub_condition___);
				wire [16:0] C14 = A[239:224] + B_real[239:224] + (C13[16] & (H)) + (Q & ___sub_condition___);
				wire [16:0] C15 = A[255:240] + B_real[255:240] + (C14[16] & (O | H)) + (Q & ___sub_condition___);
			end
			
			3'b010: begin
				wire [15:0] R0 = A[15:0] * B_real[15:0];
				wire [15:0] R1 = A[31:16] * B_real[31:16]
				wire [15:0] R2 = A[47:32] * B_real[47:32]
				wire [15:0] R3 = A[63:48] * B_real[63:48]
				wire [15:0] R4 = A[79:64] * B_real[79:64]
				wire [15:0] R5 = A[95:80] * B_real[95:80]
				wire [15:0] R6 = A[111:96] * B_real[111:96]
				wire [15:0] R7 = A[127:112] * B_real[127:112]
				wire [15:0] R8 = A[143:128] * B_real[143:128]
				wire [15:0] R9 = A[159:144] * B_real[159:144]
				wire [15:0] R10 = A[175:160] * B_real[175:160]
				wire [15:0] R11 = A[191:176] * B_real[191:176]
				wire [15:0] R12 = A[207:192] * B_real[207:192]
				wire [15:0] R13 = A[223:208] * B_real[223:208]
				wire [15:0] R14 = A[239:224] * B_real[239:224]
				wire [15:0] R15 = A[255:240] * B_real[255:240]
			end
			
			3'b011: begin
				
			end
			default: begin
			  
			end
		endcase
		
		
	 end
	 
	 else begin
	 
		 wire [15:0]Sum;

		 assign Sum = (ALUControl[0] == 1'b0) ? A + B :
															(A + ((~B)+1)) ;
		 assign {Cout,Result} = (ALUControl == 3'b000) ? Sum :
										(ALUControl == 3'b001) ? Sum :
										(ALUControl == 3'b010) ? A & B :
										(ALUControl == 3'b011) ? A | B :
										(ALUControl == 3'b101) ? {{16{1'b0}},(Sum[15])} :
										{17{1'b0}};
		 assign OverFlow = ((Sum[15] ^ A[15]) & 
								 (~(ALUControl[0] ^ B[15] ^ A[15])) &
								 (~ALUControl[1]));
		 assign Carry = ((~ALUControl[1]) & Cout);
		 assign Zero = &(~Result);
		 assign Negative = Result[15];
			 
	 end
	 



endmodule
