module VMult(
    input [255:0] A,
    input [255:0] B, 
    output [255:0] Result 
);

    assign Result[15:0]   = A[15:0]  *   B[15:0];
    assign Result[31:16]  = A[31:16] *   B[31:16];
    assign Result[47:32]  = A[47:32] *   B[47:32];
    assign Result[63:48]  = A[63:48] *   B[63:48];
    assign Result[79:64]  = A[79:64] *   B[79:64];
    assign Result[95:80]  = A[95:80] *   B[95:80];
    assign Result[111:96] = A[111:96] *  B[111:96];
    assign Result[127:112]= A[127:112] * B[127:112];
    assign Result[143:128]= A[143:128] * B[143:128];
    assign Result[159:144]= A[159:144] * B[159:144];
    assign Result[175:160]= A[175:160] * B[175:160];
    assign Result[191:176]= A[191:176] * B[191:176];
    assign Result[207:192]= A[207:192] * B[207:192];
    assign Result[223:208]= A[223:208] * B[223:208];
    assign Result[239:224]= A[239:224] * B[239:224];
    assign Result[255:240]= A[255:240] * B[255:240];

endmodule