module Lab3 (
    input clk,
    input [7:0] A,   // Ignorados en esta prueba
    input [7:0] B,
    input Sel,
    output [6:0] SSeg,
    output [3:0] an
);

    wire clk_div;
    wire [1:0] sel_disp;
    wire [3:0] BCD0, BCD1, BCD2;
    reg [3:0] bcd;

    // 🔴 Forzar resultado binario de -165 (Cout = 0 indica negativo)
    wire [7:0] S = 8'd165;
    wire Cout = 1'b0;

    BCD conversor (
        .bin({Cout, S}),
        .BCD0(BCD0),
        .BCD1(BCD1),
        .BCD2(BCD2)
    );

    DivFrec div_clk (
        .clk(clk),
        .clk_out(clk_div)
    );

    SelAn seleccion (
        .clk(clk_div),
        .sel(sel_disp),
        .an(an)
    );

    // ✅ Ajustado al orden físico real de tus displays: 2 3 4 1
    always @(*) begin
        case (sel_disp)
            2'b00: bcd = BCD0;                           // unidades → display 4
            2'b01: bcd = (Cout == 1'b0) ? 4'd10 : 4'd11; // signo    → display 1
            2'b10: bcd = BCD2;                           // centenas → display 2
            2'b11: bcd = BCD1;                           // decenas  → display 3
        endcase
    end

    BCDtoSSeg seg (
        .BCD(bcd),
        .SSeg(SSeg)
    );

endmodule
