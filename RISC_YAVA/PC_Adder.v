module PC_Adder (a,b,c);

    input [255:0]a,b;
    output [255:0]c;

    assign c = a + b;
    
endmodule