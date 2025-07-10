`timescale 1ns/1ps
`include "src/BCD.v"

module BCD_tb();

    reg [8:0] bin_tb;
    wire [3:0] BCD2_tb, BCD1_tb, BCD0_tb;

    BCD uut (
        .bin(bin_tb),
        .BCD2(BCD2_tb),
        .BCD1(BCD1_tb),
        .BCD0(BCD0_tb)
    );

    initial begin
        $dumpfile("BCD_tb.vcd");
        $dumpvars(0, BCD_tb);

        // Casos de prueba
        bin_tb = 9'd0;    #10;  // 0   → 0 0 0
        bin_tb = 9'd2;    #10;  // 2   → 0 0 2
        bin_tb = 9'd12;   #10;  // 12  → 0 1 2
        bin_tb = 9'd128;  #10;  // 128 → 1 2 8
        bin_tb = 9'd255;  #10;  // 255 → 2 5 5
        bin_tb = 9'd256;  #10;  // 256 → 2 5 6
        bin_tb = 9'd510;  #10;  // 510 → 5 1 0
        bin_tb = 9'd2;    #10;  // -2 (magnitud) → 0 0 2
        bin_tb = 9'd127;  #10;  // -127 (magnitud) → 1 2 7

        #10 $finish;
    end

endmodule