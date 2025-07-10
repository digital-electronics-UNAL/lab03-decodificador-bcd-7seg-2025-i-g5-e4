//`include "src/sumres8b.v"
module Sumador9b (
    input  [7:0] A,
    input  [7:0] B,
    input        Sel,
    output signed [8:0] resultado
);
    sumres8b alu (
        .A(A),
        .B(B),
        .Sel(Sel),
        .resultado(resultado)
    );
endmodule
