`timescale 1ns / 1ps
module Lab3 (
    input        Sel,
    input  [7:0] A,
    input  [7:0] B,
    output [6:0] HEX3,
    output [6:0] HEX2,
    output [6:0] HEX1,
    output [6:0] HEX0
);
    wire [8:0] S9;
    sum8b U1 (
        .A   (A),
        .B   (B),
        .sel (Sel),
        .S   (S9)
    );
    wire        negative;
    wire [8:0]  magnitude9;
    assign negative   = Sel && S9[7];
    assign magnitude9 = Sel ? {1'b0, (~S9[7:0] + 1'b1)} : S9;
    wire [3:0] d_hund, d_tens, d_ones;
    BCD U2 (
        .bin  (magnitude9),
        .BCD2 (d_hund),
        .BCD1 (d_tens),
        .BCD0 (d_ones)
    );
    BCDtoSSeg H3 (
        .BCD  (d_hund),
        .SSeg (HEX3)
    );
    BCDtoSSeg H2 (
        .BCD  (d_tens),
        .SSeg (HEX2)
    );
    BCDtoSSeg H1 (
        .BCD  (d_ones),
        .SSeg (HEX1)
    );
    wire [3:0] sign_code = negative ? 4'd10 : 4'd11;
    BCDtoSSeg H0 (
        .BCD  (sign_code),
        .SSeg (HEX0)
    );
endmodule
