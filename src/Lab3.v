module Lab3 (
    input clk,
    input [7:0] A,
    input [7:0] B,
    input Sel, // ignorado en esta versión
    output [6:0] SSeg,
    output [3:0] an
);

    wire clk_div;
    wire [7:0] S;
    wire Cout;

    wire [1:0] sel_disp;
    wire [3:0] BCD0, BCD1, BCD2;
    reg [3:0] bcd;

    // ✅ Inversión de bits y lógica negada (switches activos en bajo)
    wire [7:0] A_in = ~{A[0], A[1], A[2], A[3], A[4], A[5], A[6], A[7]};
    wire [7:0] B_in = ~{B[0], B[1], B[2], B[3], B[4], B[5], B[6], B[7]};

    // ✅ Forzar solo suma
    wire Sel_real = 1'b0;

    // ✅ Sumador/restador estructural
    sumres8b sumador (
        .A(A_in),
        .B(B_in),
        .Sel(Sel_real),
        .S(S),
        .Cout(Cout)
    );

    // ✅ Resultado de 9 bits
    wire [8:0] abs_result = {Cout, S};

    // ✅ Conversión binario → BCD
    BCD conversor (
        .bin(abs_result),
        .BCD0(BCD0),
        .BCD1(BCD1),
        .BCD2(BCD2)
    );

    // ✅ Divisor de frecuencia para multiplexación
    DivFrec div_clk (
        .clk(clk),
        .clk_out(clk_div)
    );

    // ✅ Selector de display activo
    SelAn seleccion (
        .clk(clk_div),
        .sel(sel_disp),
        .an(an)
    );

    // ✅ Asignación de dígitos a displays: [signo][centenas][decenas][unidades]
    always @(*) begin
        case (sel_disp)
            2'b00: bcd = BCD0;       // unidades → derecha
            2'b01: bcd = 4'd11;      // blanco (sin signo)
            2'b10: bcd = BCD2;       // centenas
            2'b11: bcd = BCD1;       // decenas
        endcase
    end

    // ✅ Decodificador BCD → 7 segmentos
    BCDtoSSeg seg (
        .BCD(bcd),
        .SSeg(SSeg)
    );

endmodule
