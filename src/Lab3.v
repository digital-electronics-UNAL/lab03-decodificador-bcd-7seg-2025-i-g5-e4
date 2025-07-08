module Lab3 (
    input clk,
    input [7:0] A,
    input [7:0] B,
    input Sel, // Ignorado
    output [6:0] SSeg,
    output [3:0] an
);

    wire clk_div;
    wire [7:0] S;
    wire Cout;

    wire [1:0] sel_disp;
    wire [3:0] BCD0, BCD1, BCD2;
    reg [3:0] bcd;

    // ✅ Lógica negada + relleno manual de MSB (A[7] = 0)
    wire [7:0] A_in = ~{1'b0, A[7:1]};
    wire [7:0] B_in = ~{1'b0, B[7:1]};
    wire Sel_real = 1'b0; // suma forzada

    // ✅ Sumador estructural
    sumres8b sumador (
        .A(A_in),
        .B(B_in),
        .Sel(Sel_real),
        .S(S),
        .Cout(Cout)
    );

    wire [8:0] abs_result = {Cout, S};

    // ✅ Conversión a BCD
    BCD conversor (
        .bin(abs_result),
        .BCD0(BCD0),
        .BCD1(BCD1),
        .BCD2(BCD2)
    );

    // ✅ División de frecuencia
    DivFrec div_clk (
        .clk(clk),
        .clk_out(clk_div)
    );

    // ✅ Rotación de displays
    SelAn seleccion (
        .clk(clk_div),
        .sel(sel_disp),
        .an(an)
    );

    // ✅ Asignación de dígitos por display: [signo][centenas][decenas][unidades]
    always @(*) begin
        case (sel_disp)
            2'b00: bcd = BCD0;
            2'b01: bcd = 4'd11; // blanco
            2'b10: bcd = BCD2;
            2'b11: bcd = BCD1;
        endcase
    end

    // ✅ Decodificador a display 7 segmentos
    BCDtoSSeg seg (
        .BCD(bcd),
        .SSeg(SSeg)
    );

endmodule
