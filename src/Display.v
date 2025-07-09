module Display (
    input        Sel_op,        // 0 = suma, 1 = resta
    input  [8:0] resultado,     // [8]=carry/bit signo, [7:0]=magnitud
    input  [1:0] sel_disp,      // selección de dígito
    output [6:0] SSeg           // segmentos del 7-seg (invertidos)
);

    wire signo = Sel_op & resultado[8];
    wire [8:0] mag = signo
        ? (~resultado + 9'd1)
        : resultado;

    // Conversión bin→BCD
    wire [3:0] BCD2, BCD1, BCD0;
    BCD u_bcd (
        .bin  (mag),
        .BCD2 (BCD2),
        .BCD1 (BCD1),
        .BCD0 (BCD0)
    );

    // selector de dígito
    reg [3:0] bcd;
    always @(*) begin
        case(sel_disp)
            2'b00: bcd = BCD0;
            2'b01: bcd = signo ? 4'd10 : 4'd11;
            2'b10: bcd = BCD2;
            2'b11: bcd = BCD1;
            default: bcd = 4'd11;
        endcase
    end

    // patrón ANTES de invertir
    wire [6:0] seg_pat;
    BCDtoSSeg u_map (
        .BCD  (bcd),
        .SSeg (seg_pat)
    );

    // AHORA invertimos para common-cathode
    assign SSeg = ~seg_pat;

endmodule
