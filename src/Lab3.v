module Lab3 (
    input clk,
    input [7:0] A,
    input [7:0] B,
    input Sel,                // Switch de suma/resta
    output [6:0] SSeg,
    output [3:0] an
);

    wire [8:0] resultado;

    // ✅ Inversión opcional de Sel (activo en bajo si es necesario)
    wire Sel_real = ~Sel;  // Cambia a "Sel" si tu switch ya es activo en alto

    // ✅ Instanciar sumador
    Sumador9b alu (
        .A(A),
        .B(B),
        .Sel(Sel_real),
        .resultado(resultado)
    );

    // ✅ Visualización
    Display visor (
        .clk(clk),
        .resultado(resultado),
        .SSeg(SSeg),
        .an(an)
    );

endmodule
