`timescale 1ns/1ps
`include "src/BCDtoSSeg.v"

module BCDtoSSeg_tb();

    reg [3:0] BCD_tb;
    wire [6:0] SSeg_tb;

    BCDtoSSeg uut (
        .BCD(BCD_tb),
        .SSeg(SSeg_tb)
    );

    initial begin
        $dumpfile("BCDtoSSeg_tb.vcd");
        $dumpvars(0, BCDtoSSeg_tb);
        BCD_tb = 4'd0;  #10;
        BCD_tb = 4'd1;  #10;
        BCD_tb = 4'd2;  #10;
        BCD_tb = 4'd3;  #10;
        BCD_tb = 4'd4;  #10;
        BCD_tb = 4'd5;  #10;
        BCD_tb = 4'd6;  #10;
        BCD_tb = 4'd7;  #10;
        BCD_tb = 4'd8;  #10;
        BCD_tb = 4'd9;  #10;
        BCD_tb = 4'd10; #10; // Guion
        BCD_tb = 4'd11; #10; // Blanco
        #10 $finish;
    end

endmodule
