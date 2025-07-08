module Lab3 (
    input clk,
    input [7:0] A,    // Ignorados en esta prueba
    input [7:0] B,    // Ignorados en esta prueba
    input Sel,        // Ignorado en esta prueba
    output [6:0] SSeg,
    output [3:0] an
);

    wire [8:0] resultado;

    // ✅ Fuerza A, B y Sel a valores de prueba
    wire [7:0] A_in = 8'b00000000;
    wire [7:0] B_in = 8'b00000000;
    wire Sel_in = 1'b0; // suma

    // ✅ Calcula resultado real (con sumador corregido)
    Sumador9b alu (
        .A(A_in),
        .B(B_in),
        .Sel(Sel_in),
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
