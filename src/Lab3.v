module Lab3 (
    input clk,
    input [7:0] A,     // Ignorados para esta prueba
    input [7:0] B,
    input Sel,
    output [6:0] SSeg,
    output [3:0] an
);

    wire clk_div;
    wire [1:0] sel_disp;
    reg [3:0] bcd;

    // ✅ Divisor de frecuencia
    DivFrec div_clk (
        .clk(clk),
        .clk_out(clk_div)
    );

    // ✅ Selector de display
    SelAn seleccion (
        .clk(clk_div),
        .sel(sel_disp),
        .an(an)
    );

    // ✅ Mostrar 1234 de izquierda a derecha
    // sel_disp se asocia a: 00 = unidades, 01 = decenas, 10 = centenas, 11 = signo
    always @(*) begin
    case (sel_disp)
        2'b00: bcd = 4'd1; // signo → display más a la izquierda
        2'b01: bcd = 4'd2; // centenas
        2'b10: bcd = 4'd3; // decenas
        2'b11: bcd = 4'd4; // unidades (display más a la derecha)
    endcase
end

    // ✅ Decodificador BCD a 7 segmentos
    BCDtoSSeg seg (
        .BCD(bcd),
        .SSeg(SSeg)
    );

endmodule
