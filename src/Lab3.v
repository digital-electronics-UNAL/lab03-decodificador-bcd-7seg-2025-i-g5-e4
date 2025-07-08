module Lab3 (
    input clk,
    input [7:0] A,       // Ignorados en esta prueba
    input [7:0] B,
    input Sel,
    output [6:0] SSeg,
    output [3:0] an
);

    wire clk_div;
    wire [1:0] sel_disp;
    wire [3:0] BCD0, BCD1, BCD2;
    reg [3:0] bcd;

    // 🔴 FORZAR número manualmente: 253 → Cout = 1, S = 8'b11111101
    wire [7:0] S = 8'd253;
    wire Cout = 1'b1;

    // Binario a BCD
    BCD conversor (
        .bin({Cout, S}),   // 9 bits: {1, 11111101}
        .BCD0(BCD0),
        .BCD1(BCD1),
        .BCD2(BCD2)
    );

    // Divisor de frecuencia
    DivFrec div_clk (
        .clk(clk),
        .clk_out(clk_div)
    );

    // Selector de display
    SelAn seleccion (
        .clk(clk_div),
        .sel(sel_disp),
        .an(an)
    );

    // Muestra signo a la izquierda si negativo, blanco si positivo
    always @(*) begin
        case (sel_disp)
            2'b00: bcd = BCD0;                           // unidades (3)
            2'b01: bcd = BCD1;                           // decenas (5)
            2'b10: bcd = BCD2;                           // centenas (2)
            2'b11: bcd = (Cout == 1'b0) ? 4'd10 : 4'd11; // signo: '-' o blanco
        endcase
    end

    // Decodificación a display de 7 segmentos
    BCDtoSSeg seg (
        .BCD(bcd),
        .SSeg(SSeg),
        .an()
    );

endmodule
