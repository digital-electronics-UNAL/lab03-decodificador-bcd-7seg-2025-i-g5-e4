module Display (
    input        clk,
    input        Sel_op,         // 0 = suma, 1 = resta
    input  [8:0] resultado,      // [8] = MSB (carry o signo), [7:0] = mag
    output [6:0] SSeg,
    output [3:0] an
);

    // Sólo en resta tomamos el MSB como signo:
    wire signo = Sel_op & resultado[8];

    // Si es negativo, hacer two's-complement; si no, dejamos entero
    wire [8:0] magnitud = signo
        ? (~resultado + 9'b000000001)
        : resultado;

    // el resto igual: convertimos 'magnitud' a BCD y multiplexamos...
    wire [3:0] BCD0, BCD1, BCD2;
    wire [1:0] sel_disp;
    reg  [3:0] bcd;

    // Clock divisor y selectores (divfrecuencia + SelAn)
    DivFrec div ( .clk(clk), .clk_out(clk_disp) );
    SelAn selan ( .clk(clk_disp), .sel(sel_disp), .an(an) );

    // Conversor bin→BCD (hasta 9 bits)
    BCD conversor (
        .bin(magnitud),
        .BCD2(BCD2), .BCD1(BCD1), .BCD0(BCD0)
    );

    // Escoge qué dígito mostr ar
    always @(*) begin
        case (sel_disp)
            2'b00: bcd = BCD0;                        // unidades
            2'b01: bcd = signo ? 4'd10 : 4'd11;       // "-" o blanco
            2'b10: bcd = BCD2;                        // centenas
            2'b11: bcd = BCD1;                        // decenas
        endcase
    end

    // A 7-segmentos
    BCDtoSSeg seg ( .BCD(bcd), .SSeg(SSeg) );

endmodule
