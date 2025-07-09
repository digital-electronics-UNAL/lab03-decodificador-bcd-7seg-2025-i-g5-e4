module Display (
    input clk,
    input [8:0] resultado,     // [8] = signo, [7:0] = magnitud
    output [6:0] SSeg,
    output [3:0] an
);

    wire signo = resultado[8];
    wire [8:0] magnitud = signo ? (~resultado + 1'b1) : resultado;

    wire [3:0] BCD0, BCD1, BCD2;
    wire [1:0] sel_disp;
    reg [3:0] bcd;

    // Conversión binario a BCD (usa 9 bits completos)
    BCD conversor (
        .bin(magnitud),
        .BCD0(BCD0),
        .BCD1(BCD1),
        .BCD2(BCD2)
    );

    // Divisor de frecuencia para multiplexación
    wire clk_div;
    DivFrec div_clk (
        .clk(clk),
        .clk_out(clk_div)
    );

    SelAn seleccion (
        .clk(clk_div),
        .sel(sel_disp),
        .an(an)
    );

    always @(*) begin
        case (sel_disp)
            2'b00: bcd = BCD0;                      // unidades
            2'b01: bcd = signo ? 4'd10 : 4'd11;     // 10 = "-", 11 = blanco
            2'b10: bcd = BCD2;                      // centenas
            2'b11: bcd = BCD1;                      // decenas
        endcase
    end

    BCDtoSSeg seg (
        .BCD(bcd),
        .SSeg(SSeg)
    );

endmodule
