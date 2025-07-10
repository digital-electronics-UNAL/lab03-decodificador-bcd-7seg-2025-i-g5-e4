`timescale 1ns/1ps

`include "src/Sumador9b.v"

module Sumador9b_tb();

    reg [7:0] A_tb;
    reg [7:0] B_tb;
    reg Sel_tb;

    wire [8:0] resultado_tb;

    Sumador9b uut (
        .A(A_tb),
        .B(B_tb),
        .Sel(Sel_tb),
        .resultado(resultado_tb)
    );

    initial begin
        // Caso 1: 0 + 255
        A_tb = 8'd0;   B_tb = 8'd255; Sel_tb = 1'b0; #10;
        // Caso 2: 1 + 255
        A_tb = 8'd1;   B_tb = 8'd255; Sel_tb = 1'b0; #10;
        // Caso 3: 1 + 1
        A_tb = 8'd1;   B_tb = 8'd1;   Sel_tb = 1'b0; #10;
        // Caso 4: 1 - 1
        A_tb = 8'd1;   B_tb = 8'd1;   Sel_tb = 1'b1; #10;
        // Caso 5: 0 - 0
        A_tb = 8'd0;   B_tb = 8'd0;   Sel_tb = 1'b1; #10;
        // Caso 6: 2 - 4
        A_tb = 8'd2;   B_tb = 8'd4;   Sel_tb = 1'b1; #10;
        // Caso 7: 128 + 128
        A_tb = 8'd128; B_tb = 8'd128; Sel_tb = 1'b0; #10;
        // Caso 8: 255 + 0
        A_tb = 8'd255; B_tb = 8'd0;   Sel_tb = 1'b0; #10;
        // Caso 9: 0 - 255
        A_tb = 8'd0;   B_tb = 8'd255; Sel_tb = 1'b1; #10;
        // Caso 10: 1 - 255
        A_tb = 8'd1;   B_tb = 8'd255; Sel_tb = 1'b1; #10;
    end

    initial begin: TEST_CASE
        $dumpfile("Sumador9b_tb.vcd");
        $dumpvars(0, Sumador9b_tb);
        #200 $finish;
    end

endmodule
