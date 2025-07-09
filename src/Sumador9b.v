module Sumador9b (
    input  [7:0] A,
    input  [7:0] B,
    input        Sel,         // 0 = suma, 1 = resta
    output [8:0] resultado
);

    wire [7:0] S;
    wire Cout;

    sumres8b u_sumres (
        .A(A),
        .B(B),
        .Sel(Sel),
        .S(S),
        .Cout(Cout)
    );

    assign resultado = {S[7], S};  // MSB como bit de signo

endmodule
