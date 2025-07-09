// Display.v — Convierte resultado 9-bit a BCD y muestra con signo (common-anode)
module Display (
    input        Sel_op,        // 0 = suma, 1 = resta
    input  [8:0] resultado,     // [8]=carry/bit signo, [7:0]=magnitud
    input  [1:0] sel_disp,      // selección de dígito (00: U, 01: signo, 10: C, 11: D)
    output [6:0] SSeg           // segmentos del 7-seg (0 = encendido)
);

    // Determina si hay signo negativo (resta con MSB=1)
    wire signo = Sel_op & resultado[8];

    // Calcula magnitud: si negativo, two’s-complement; si no, valor directo
    wire [8:0] mag = signo
        ? (~resultado + 9'd1)
        : resultado;

    // Bin→BCD (3 dígitos: centenas, decenas, unidades)
    wire [3:0] BCD2, BCD1, BCD0;
    BCD u_bcd (
        .bin  (mag),
        .BCD2 (BCD2),
        .BCD1 (BCD1),
        .BCD0 (BCD0)
    );

    // Elige qué muestra cada ciclo de multiplexado
    reg [3:0] bcd;
    always @(*) begin
        case (sel_disp)
            2'b00: bcd = BCD0;                  // U
            2'b01: bcd = signo ? 4'd10 : 4'd11; // '-'(10) o blank(11)
            2'b10: bcd = BCD2;                  // C
            2'b11: bcd = BCD1;                  // D
            default: bcd = 4'd11;
        endcase
    end

    // Mapa BCD→7-Seg (common-anode: 0 enciende)
    BCDtoSSeg u_map (
        .BCD  (bcd),
        .SSeg (SSeg)
    );

endmodule
