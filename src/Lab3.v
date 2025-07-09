module Lab3 (
    input        clk,        // Reloj principal
    input  [7:0] A,          // Operando A (desde switches)
    input  [7:0] B,          // Operando B (desde switches)
    input        Sel,        // 0 = suma, 1 = resta (desde switch)
    output [6:0] SSeg,       // Salida para display de 7 segmentos
    output [3:0] an          // Ánodos de displays (activo en bajo)
);

    // Resultado de 9 bits (incluye carry/borrow)
    wire [8:0] resultado;
    // Reloj dividido para multiplexación de displays
    wire       clk_disp;
    // Selector de dígitos (2 bits para 4 displays)
    wire [1:0] sel_disp;
    // Ajuste de polaridad del switch Sel (comentar o invertir si es activo en bajo)
    wire Sel_real = Sel;    // Si tu switch es activo ALTO. Usa '~Sel' si es activo en BAJO.

    // Instancia del sumador/restador de 9 bits
    Sumador9b u_sum9b (
        .A         (A),
        .B         (B),
        .Sel       (Sel_real),
        .resultado(resultado)
    );

    // Divisor de frecuencia para generar clk_disp
    DivFrec u_div (
        .clk     (clk),
        .clk_out (clk_disp)
    );

    // Selector de ánodos para multiplexación
    SelAn u_selan (
        .clk (clk_disp),
        .sel (sel_disp),
        .an  (an)
    );

    // Módulo display: gestiona signo y conversión a BCD + sseg
    Display visor (
        .clk      (clk_disp),
        .Sel_op   (Sel_real),
        .resultado(resultado),
        .SSeg     (SSeg),
        .an       (an)
    );

endmodule
