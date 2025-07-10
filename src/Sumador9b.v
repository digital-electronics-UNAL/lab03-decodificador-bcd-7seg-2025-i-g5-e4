module Sumador9b (
    input  [7:0] A,
    input  [7:0] B,
    input        Sel,         // 0 = suma, 1 = resta
    output [8:0] resultado    // resultado con signo
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
    assign resultado = Sel ? {S[7], S} : {Cout, S}; // en resta S[7]=signo; en suma Cout=carry
endmodule