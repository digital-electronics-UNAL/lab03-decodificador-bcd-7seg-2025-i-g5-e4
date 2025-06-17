`timescale 1ns/1ps
`include "src/BCD.v"

module BCD_tb();

    reg clk_tb;
    reg [4:0] num_tb;
    
    wire [3:0] BCD_tb;

    BCD uut(
        .clk(clk_tb),
        .num(num_tb),
        .BCD(BCD_tb)
        
    );

    always #5 clk_tb = ~clk_tb;

    initial begin 
        
        clk_tb = 0; 
        num_tb = 5'd15;
     
    end

    initial begin: TEST_CASE 
        $dumpfile("BCD_tb.vcd");
        $dumpvars(-1, uut);
        #50 $finish;
    end

endmodule