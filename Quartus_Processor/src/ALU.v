module ALU(A,B,Result,ALUControl,OverFlow,Zero,Negative);

input  [31:0] A; 
input  [31:0] B;
input [3:0] ALUControl; 
output reg  [31:0] Result;
output wire Zero, Negative;
output reg OverFlow;

wire [31:0] Sum;


assign Sum = A + (ALUControl[0] ? ~B : B) + ALUControl[0];  // sub using 1's complement


assign Zero = (|Result) ? 1'b0:1'b1;
assign Negative = Result[31];


always @ (*) begin
        OverFlow = ~(ALUControl[0] ^ B[31] ^ A[31]) & (A[31] ^ Sum[31]) & (~ALUControl[1]);
		casex (ALUControl)
				4'b0000: Result = Sum;				// sum or diff
				4'b0001: Result = Sum;				// sum or diff
				4'b0010: Result = A & B;	// and
				4'b0011: Result = A | B;	// or
				4'b0100: Result = A << B[4:0];	// sll, slli
				4'b0101: Result = {{30{1'b0}}, OverFlow ^ Sum[31]}; //slt, slti
				4'b0110: Result = A ^ B;   // Xor
				4'b0111: Result = A >> B[4:0];  // shift logic
				4'b1000: Result = ($unsigned(A) < $unsigned(B)); //sltu, stlui
				4'b1111: Result = A >>> B[4:0]; //shift arithmetic
				default: Result = 32'd0;
		endcase
        
end

endmodule