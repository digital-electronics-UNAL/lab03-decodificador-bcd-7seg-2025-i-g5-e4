module Sumador9b (
    input [7:0] A,
    input [7:0] B,
    input Sel,
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

    // ✅ Usar MSB como signo: S[7]
    assign resultado = {S[7], S};

endmodule
