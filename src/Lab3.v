module Lab3 (
    input        clk,       // reloj de la FPGA (50 MHz)
    input  [7:0] A,         // dato A (0–255)
    input  [7:0] B,         // dato B (0–255)
    input        Sel,       // 0 = suma, 1 = resta
    output [6:0] SSeg,      // segmentos del display
    output [3:0] an         // ánodos activos (4 displays)
);

    // Señales internas
    wire       clk_disp;
    wire [8:0] resultado;
    wire [1:0] sel_disp;

    // Divide la frecuencia para multiplexar displays
    DivFrec u_div (
        .clk    (clk),
        .clk_out(clk_disp)
    );

    // Genera sel_disp y an de ánodos
    SelAn u_selan (
        .clk (clk_disp),
        .sel (sel_disp),
        .an  (an)
    );

    // Sumador/restador de 9 bits
    Sumador9b u_sum9b (
        .A        (A),
        .B        (B),
        .Sel      (Sel),
        .resultado(resultado)
    );

    // Módulo de display: interpreta signo y magnitud, sólo genera SSeg
    Display u_disp (
        .Sel_op    (Sel),
        .resultado (resultado),
        .sel_disp  (sel_disp),
        .SSeg      (SSeg)
    );

endmodule