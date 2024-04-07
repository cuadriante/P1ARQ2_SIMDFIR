module Mux (a,b,s,c);

    input [255:0]a,b;
    input s;
    output [255:0]c;

    assign c = (~s) ? a : b ;
    
endmodule