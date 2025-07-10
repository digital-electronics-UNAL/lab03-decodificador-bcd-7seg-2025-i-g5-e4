`timescale 1ns/1ps

`include "Lab3.v"

module Lab3_tb();

    reg clk_tb = 0;
    reg [7:0] A_tb;
    reg [7:0] B_tb;
    reg Sel_tb;

    wire [6:0] SSeg_tb;
    wire [3:0] an_tb;

    // Instancia del DUT
    Lab3 uut (
        .clk(clk_tb),
        .A(A_tb),
        .B(B_tb),
        .Sel(Sel_tb),
        .SSeg(SSeg_tb),
        .an(an_tb)
    );

    // Reloj de prueba (simula el divisor de frecuencia)
    always #5 clk_tb = ~clk_tb;

    initial begin
        $dumpfile("Lab3_tb.vcd");
        $dumpvars(0, Lab3_tb);

        // Caso 1: A=0, B=255, Sel=0 (Suma) -> Esperado: 255
        A_tb = 8'd0; B_tb = 8'd255; Sel_tb = 1'b0; #40;

        // Caso 2: A=1, B=255, Sel=0 (Suma) -> Esperado: 256
        A_tb = 8'd1; B_tb = 8'd255; Sel_tb = 1'b0; #40;

        // Caso 3: A=1, B=1, Sel=0 (Suma) -> Esperado: 2
        A_tb = 8'd1; B_tb = 8'd1; Sel_tb = 1'b0; #40;

        // Caso 4: A=1, B=1, Sel=1 (Resta) -> Esperado: 0
        A_tb = 8'd1; B_tb = 8'd1; Sel_tb = 1'b1; #40;

        // Caso 5: A=0, B=0, Sel=1 (Resta) -> Esperado: 0
        A_tb = 8'd0; B_tb = 8'd0; Sel_tb = 1'b1; #40;

        // Caso 6: A=2, B=4, Sel=1 (Resta) -> Esperado: -2
        A_tb = 8'd2; B_tb = 8'd4; Sel_tb = 1'b1; #40;

        // Caso 7: A=128, B=128, Sel=0 (Suma) -> Esperado: 256
        A_tb = 8'd128; B_tb = 8'd128; Sel_tb = 1'b0; #40;

        // Caso 8: A=255, B=0, Sel=0 (Suma) -> Esperado: 255
        A_tb = 8'd255; B_tb = 8'd0; Sel_tb = 1'b0; #40;

        // Caso 9: A=0, B=255, Sel=1 (Resta) -> Esperado: -255
        A_tb = 8'd0; B_tb = 8'd255; Sel_tb = 1'b1; #40;

        // Caso 10: A=1, B=255, Sel=1 (Resta) -> Esperado: -254
        A_tb = 8'd1; B_tb = 8'd255; Sel_tb = 1'b1; #40;

        $finish;
    end

endmodule
