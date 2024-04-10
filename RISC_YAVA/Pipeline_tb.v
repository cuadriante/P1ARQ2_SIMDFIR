module Pipeline_tb;

reg[4:0] i;
reg rst;
reg clk = 0;

Pipeline_top Test(clk, rst);

initial begin
    rst = 1'b0; // Inicialmente, el sistema está en reset
    #20;        // Esperar un poco con reset en alto
    rst = 1'b1; // Liberar el reset
    #10000;       // Ejecutar la simulación por un tiempo
    $finish;    // Finalizar la simulación
end

// Generar la señal de reloj continuamente
always #5 clk = ~clk; // Genera un reloj de 10 unidades de tiempo de período

always @(posedge clk) begin
    $display("[%0t] fetched instruction: %h", $time, Test.Fetch.InstrD);
    $display("[%0t] fetched ResultW: %h", $time, Test.ResultW);
    $display("[%0t] fetched ALUResult: %h", $time, Test.Execute.ALU_E.Result);
    // La siguiente línea está comentada porque parece ser duplicada o incorrecta según el comentario
    //$display("[%0t] fetched ALUResult: %h", $time, Test.Decode.ALU_E.Result);
end

endmodule
