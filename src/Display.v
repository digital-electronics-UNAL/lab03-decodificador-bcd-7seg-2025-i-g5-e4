module Display (
    input        Sel_op,        // 0 = suma, 1 = resta
    input  [8:0] resultado,     // [8]=carry/bit signo, [7:0]=magnitud
    input  [1:0] sel_disp,      // selección de dígito
    output [6:0] SSeg           // segmentos del 7-seg (wire)
);

    // Calcula si es negativo (resta con MSB=1)
    wire signo = Sel_op & resultado[8];

    // Magnitud: si es negativo, two’s-complement; si no, valor directo
    wire [8:0] mag = signo
        ? (~resultado + 9'd1)
        : resultado;

    // Conversión bin→BCD (hasta 3 dígitos)
    wire [3:0] BCD2, BCD1, BCD0;
    BCD u_bcd (
        .bin  (mag),
        .BCD2 (BCD2),
        .BCD1 (BCD1),
        .BCD0 (BCD0)
    );

    // Selecciona qué dígito mostrar
    reg [3:0] bcd;
    always @(*) begin
        case (sel_disp)
            2'b00: bcd = BCD0;                    // unidades
            2'b01: bcd = signo ? 4'd10 : 4'd11;   // '-' o blank
            2'b10: bcd = BCD2;                    // centenas
            2'b11: bcd = BCD1;                    // decenas
            default: bcd = 4'd11;
        endcase
    end

    // Instancia el mapa BCD → 7-segmentos, driver único de SSeg
    BCDtoSSeg u_seg (
        .BCD  (bcd),
        .SSeg (SSeg)
    );

endmodule
