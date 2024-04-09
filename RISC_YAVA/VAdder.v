module VAdder(
    input [255:0] A,
    input [255:0] B, 
    output [255:0] Result,
    input [2:0] ALUControl
);

		

    wire [255:0] _B = (ALUControl[0] == 1'b1)?(~B):B;

    assign Result[15:0]   = A[15:0]  	+ _B[15:0]		+  ALUControl[0];
    assign Result[31:16]  = A[31:16] 	+ _B[31:16]		+  ALUControl[0];
    assign Result[47:32]  = A[47:32] 	+ _B[47:32]		+  ALUControl[0];
    assign Result[63:48]  = A[63:48] 	+ _B[63:48]		+  ALUControl[0];
    assign Result[79:64]  = A[79:64] 	+ _B[79:64] 	+  ALUControl[0];
    assign Result[95:80]  = A[95:80] 	+ _B[95:80]		+  ALUControl[0];
    assign Result[111:96] = A[111:96] 	+ _B[111:96]	+  ALUControl[0];
    assign Result[127:112]= A[127:112] + _B[127:112]	+  ALUControl[0];
    assign Result[143:128]= A[143:128] + _B[143:128]	+  ALUControl[0];
    assign Result[159:144]= A[159:144] + _B[159:144]	+  ALUControl[0];
    assign Result[175:160]= A[175:160] + _B[175:160]	+  ALUControl[0];
    assign Result[191:176]= A[191:176] + _B[191:176]	+  ALUControl[0];
    assign Result[207:192]= A[207:192] + _B[207:192]	+  ALUControl[0];
    assign Result[223:208]= A[223:208] + _B[223:208]	+  ALUControl[0];
    assign Result[239:224]= A[239:224] + _B[239:224]	+  ALUControl[0];
    assign Result[255:240]= A[255:240] + _B[255:240]	+  ALUControl[0];

endmodule

