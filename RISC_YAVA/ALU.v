module ALU(A,B,Result,ALUControl,RegFileSelect,OverFlow,Carry,Zero,Negative);

    input [255:0]A,B;
	 input RegFileSelect;
    input [2:0]ALUControl;
    output Carry,OverFlow,Zero,Negative;
    output [255:0]Result;

    wire Cout;
	 
	 //wire [255:0] B_real = sub ? (~B) : B;
	 
/* //Colocar condicion apara que eliga el Cout escalar o vectorial (ambos mapeados a la misma salida)
wire [16:0] C0 = A[15:0] + B_real[15:0] + sub;
wire [16:0] C1 = A[31:16] + B_real[31:16] + (C0[16] & (O | H)) + (Q & sub);
wire [16:0] C2 = A[47:32] + B_real[47:32] + (C1[16] & (H)) + (Q & sub);
wire [16:0] C3 = A[63:48] + B_real[63:48] + (C2[16] & (O | H)) + (Q & sub);
wire [16:0] C4 = A[79:64] + B_real[79:64] + (C3[16] & (H)) + (Q & sub);
wire [16:0] C5 = A[95:80] + B_real[95:80] + (C4[16] & (O | H)) + (Q & sub);
wire [16:0] C6 = A[111:96] + B_real[111:96] + (C5[16] & (H)) + (Q & sub);
wire [16:0] C7 = A[127:112] + B_real[127:112] + (C6[16] & (O | H)) + (Q & sub);
wire [16:0] C8 = A[143:128] + B_real[143:128] + (C7[16] & (H)) + (Q & sub);
wire [16:0] C9 = A[159:144] + B_real[159:144] + (C8[16] & (O | H)) + (Q & sub);
wire [16:0] C10 = A[175:160] + B_real[175:160] + (C9[16] & (H)) + (Q & sub);
wire [16:0] C11 = A[191:176] + B_real[191:176] + (C10[16] & (O | H)) + (Q & sub);
wire [16:0] C12 = A[207:192] + B_real[207:192] + (C11[16] & (H)) + (Q & sub);
wire [16:0] C13 = A[223:208] + B_real[223:208] + (C12[16] & (O | H)) + (Q & sub);
wire [16:0] C14 = A[239:224] + B_real[239:224] + (C13[16] & (H)) + (Q & sub);
wire [16:0] C15 = A[255:240] + B_real[255:240] + (C14[16] & (O | H)) + (Q & sub);
	 */
	 
	 
    wire [31:0]Sum;

    assign Sum = (ALUControl[0] == 1'b0) ? A + B :
                                          (A + ((~B)+1)) ;
    assign {Cout,Result} = (ALUControl == 3'b000) ? Sum :
                           (ALUControl == 3'b001) ? Sum :
                           (ALUControl == 3'b010) ? A & B :
                           (ALUControl == 3'b011) ? A | B :
                           (ALUControl == 3'b101) ? {{32{1'b0}},(Sum[31])} :
                           {33{1'b0}};
    assign OverFlow = ((Sum[31] ^ A[31]) & 
                      (~(ALUControl[0] ^ B[31] ^ A[31])) &
                      (~ALUControl[1]));
    assign Carry = ((~ALUControl[1]) & Cout);
    assign Zero = &(~Result);
    assign Negative = Result[31];

endmodule