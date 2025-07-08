module Lab3 (
    input clk,
    input [7:0] A,
    input [7:0] B,
    input Sel, // Ignorado
    output [6:0] SSeg,
    output [3:0] an
);

    wire clk_div;
    wire [7:0] A_reord, B_reord;
    wire [7:0] A_in, B_in;
    wire [7:0] S;
    wire Cout;

    wire [8:0] abs_result = {Cout, S};

    wire [1:0] sel_disp;
    wire [3:0] BCD0, BCD1, BCD2;
    reg [3:0] bcd;

    // ✅ Reordenar bits (bit 7 no conectado → se pone en 0)
    reordenar rA (.in(A), .out(A_reord));
    reordenar rB (.in(B), .out(B_reord));

    // ✅ Aplicar lógica negada (switches activos en bajo)
    assign A_in = ~A_reord;
    assign B_in = ~B_reord;

    // ✅ Suma forzada
    wire Sel_real = 1'b0;

    sumres8b sumador (
        .A(A_in),
        .B(B_in),
        .Sel(Sel_real),
        .S(S),
        .Cout(Cout)
    );

    BCD conversor (
        .bin(abs_result),
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

    always @(*) begin
        case (sel_disp)
            2'b00: bcd = BCD0;       // unidades
            2'b01: bcd = 4'd11;      // blanco (sin signo)
            2'b10: bcd = BCD2;       // centenas
            2'b11: bcd = BCD1;       // decenas
        endcase
    end

    BCDtoSSeg seg (
        .BCD(bcd),
        .SSeg(SSeg)
    );

endmodule
