`timescale 1ns/1ps

`include "src/Display.v"

module Display_tb();

    reg clk_tb = 0;
    reg [8:0] resultado_tb;
    wire [6:0] SSeg_tb;
    wire [3:0] an_tb;

    Display uut (
        .clk(clk_tb),
        .resultado(resultado_tb),
        .SSeg(SSeg_tb),
        .an(an_tb)
    );

    // Opcional: Forzar el clk si quieres ver el cambio automático de dígitos.
    always #5 clk_tb = ~clk_tb;

    initial begin
        $dumpfile("Display_tb.vcd");
        $dumpvars(0, Display_tb);

        // Caso 1: +2 (esperado: 0002)
        resultado_tb = 9'd2;
        #40;

        // Caso 2: -2 (esperado: -002)
        resultado_tb = -9'sd2;
        #40;

        // Caso 3: +128 (esperado: 0128)
        resultado_tb = 9'd128;
        #40;

        // Caso 4: -127 (esperado: -127)
        resultado_tb = -9'sd127;
        #40;

        // Caso 5: 0 (esperado: 0000)
        resultado_tb = 9'd0;
        #40;

        // Caso 6: 255 (esperado: 0255)
        resultado_tb = 9'd255;
        #40;

        // Caso 7: -255 (esperado: -255)
        resultado_tb = -9'sd255;
        #40;

        // Fin
        $finish;
    end

endmodule
