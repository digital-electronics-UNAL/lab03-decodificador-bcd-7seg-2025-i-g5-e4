module Lab3 (
    input        clk,       // reloj FPGA (p.ej. 50 MHz)
    input  [7:0] A,         // dato A (0–255)
    input  [7:0] B,         // dato B (0–255)
    input        Sel,       // 0 = suma, 1 = resta
    output [6:0] SSeg,      // segmentos del display (wire)
    output [3:0] an         // ánodos activos
);

    wire        clk_disp;
    wire [8:0]  resultado;
    wire [1:0]  sel_disp;

    // 1) Divide reloj para multiplexado
    DivFrec u_div (
        .clk    (clk),
        .clk_out(clk_disp)
    );

    // 2) Driver de ánodos
    SelAn u_selan (
        .clk (clk_disp),
        .sel (sel_disp),
        .an  (an)
    );

    // 3) Sumador/restador 9-bit
    Sumador9b u_sum9b (
        .A        (A),
        .B        (B),
        .Sel      (Sel),
        .resultado(resultado)
    );

    // 4) Display: sólo genera SSeg a partir de resultado y sel_disp
    Display u_disp (
        .Sel_op    (Sel),
        .resultado (resultado),
        .sel_disp  (sel_disp),
        .SSeg      (SSeg)
    );

endmodule
