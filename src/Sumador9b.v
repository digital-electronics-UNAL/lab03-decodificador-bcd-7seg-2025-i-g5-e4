module Sumador9b (
    input  [7:0] A,
    input  [7:0] B,
    input        Sel,          // 0 = suma, 1 = resta
    output [8:0] resultado     // [8] = signo (0 = positivo, 1 = negativo)
);

    wire [7:0] S_intermedio;
    wire Cout;

    // ✅ Instancia de tu sumador estructural/restador
    sumres8b alu (
        .A(A),
        .B(B),
        .Sel(Sel),
        .S(S_intermedio),
        .Cout(Cout)
    );

    // ✅ Generar resultado de 9 bits con signo
    assign resultado = {~Cout, S_intermedio};  
    // Cout = 1 → resultado positivo → signo = 0
    // Cout = 0 → resultado negativo → signo = 1

endmodule
