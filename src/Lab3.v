module Lab3 (
    input clk,
    input [7:0] A,
    input [7:0] B,
    input Sel,
    output [6:0] SSeg,
    output [3:0] an
);

    // === Ajuste de entradas (corrección de lógica negada y corrimiento)
    wire [7:0] A_in = ~{A[6:0], 1'b0};
    wire [7:0] B_in = ~{B[6:0], 1'b0};
    wire Sel_real = ~Sel;

    // === Resultado firmado de 9 bits
    wire [8:0] resultado;

    Sumador9b alu (
        .A(A_in),
        .B(B_in),
        .Sel(Sel_real),
        .resultado(resultado)
    );

    // === Mostrar en displays
    Display visor (
        .clk(clk),
        .resultado(resultado),
        .SSeg(SSeg),
        .an(an)
    );

endmodule
