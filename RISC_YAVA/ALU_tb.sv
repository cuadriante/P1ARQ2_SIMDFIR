`timescale 1 ps / 1 ps

module ALU_tb();

	
	logic [255:0] A, B, Result;
	logic [2:0] ALUControl;
	logic RegFileSelect;
	
	ALU test(A,B,Result,ALUControl,RegFileSelect);
	

	initial begin
		RegFileSelect = 0;
		ALUControl = 3'b000; //Suma
		A = 32'h00010008;		//16 y 8
		B = 32'h00008004;		//8 y 4
		#10
		ALUControl = 3'b001; //Resta
		#10
		ALUControl = 3'b010;	//And 
		#10
		ALUControl = 3'b011; //Or
		#10
	
		//Vectoriales
		
		ALUControl = 3'b000; //Suma
		RegFileSelect = 1;
		#10
		ALUControl = 3'b001; //Resta
		#10
		ALUControl = 3'b011;	//Mult 
		#10
		ALUControl = 3'b101; //Rotación
		#10
		ALUControl = 3'b000;
	end


endmodule