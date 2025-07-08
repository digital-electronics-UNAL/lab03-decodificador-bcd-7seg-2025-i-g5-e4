module Lab3 (
    input clk,
    input [7:0] A,
    input [7:0] B,
    input Sel,
    output [6:0] SSeg,
    output [3:0] an
);

    wire [8:0] resultado;

    // 🔗 Instanciar sumador con A, B, Sel tal cual entran
    Sumador9b alu (
        .A(A),
        .B(B),
        .Sel(Sel),
        .resultado(resultado)
    );

    // 🔗 Mostrar el resultado
    Display visor (
        .clk(clk),
        .resultado(resultado),
        .SSeg(SSeg),
        .an(an)
    );

endmodule
