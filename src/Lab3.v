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

    // ✅ Lógica negada sin invertir el orden de los bits
    wire [7:0] A_in = ~A;
    wire [7:0] B_in = ~B;
    wire Sel_real = ~Sel;

    sumres8b sumador (
        .A(A_in),
        .B(B_in),
        .Sel(Sel_real),
        .S(S),
        .Cout(Cout)
    );

    wire [8:0] abs_result = {Cout, S};

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
            2'b00: bcd = BCD0;                           // unidades
            2'b01: bcd = (Cout == 1'b0) ? 4'd10 : 4'd11; // signo
            2'b10: bcd = BCD2;                           // centenas
            2'b11: bcd = BCD1;                           // decenas
        endcase
    end

    BCDtoSSeg seg (
        .BCD(bcd),
        .SSeg(SSeg)
    );

endmodule
