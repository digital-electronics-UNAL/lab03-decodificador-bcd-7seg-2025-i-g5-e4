module Lab3 (
    input clk,
    input [7:0] A,
    input [7:0] B,
    input Sel,
    output [6:0] SSeg,
    output [3:0] an
);

    wire clk_div;
    wire [7:0] S;
    wire Cout;

    wire [1:0] sel_disp;
    wire [3:0] BCD0, BCD1, BCD2;
    reg [3:0] bcd;

    // Inversión por lógica negada
    wire [7:0] A_in = ~A;
    wire [7:0] B_in = ~B;
    wire Sel_real = ~Sel;

    // Sumador/restador
    sum8b sumador (
        .A(A_in),
        .B(B_in),
        .Sel(Sel_real),
        .S(S),
        .Cout(Cout)
    );

    // Binario (9 bits) a BCD
    BCD conversor (
        .bin({Cout, S}),
        .BCD0(BCD0),
        .BCD1(BCD1),
        .BCD2(BCD2)
    );

    // Reloj lento para multiplexar displays
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

    // Selección del dígito BCD según display activo
    always @(*) begin
        case (sel_disp)
            2'b00: bcd = BCD0;
            2'b01: bcd = BCD1;
            2'b10: bcd = BCD2;
            2'b11: bcd = 4'd15;  // Mostrar "F" (opcional: apagar)
        endcase
    end

    // BCD a 7 segmentos
    BCDtoSSeg seg (
        .BCD(bcd),
        .SSeg(SSeg),
        .an()
    );

endmodule
