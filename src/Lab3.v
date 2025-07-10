module Lab3 (
    input clk,              // Reloj principal
    input [7:0] A,          // Operando A (switches)
    input [7:0] B,          // Operando B (switches)
    input Sel,              // 0 = suma, 1 = resta (switch)
    output [6:0] SSeg,      // Salida display 7 segmentos
    output [3:0] an         // Anodos de displays
);
    wire [8:0] resultado;

    // Cambia esto según si tu switch es activo alto/bajo:
    wire Sel_real = Sel; // (usa ~Sel si tu switch es activo bajo)

    Sumador9b alu (
        .A(A),
        .B(B),
        .Sel(Sel_real),
        .resultado(resultado)
    );

    Display visor (
        .clk(clk),
        .resultado(resultado),
        .SSeg(SSeg),
        .an(an)
    );
endmodule