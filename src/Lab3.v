

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
    wire [3:0] bcd;

    wire [3:0] BCD0, BCD1, BCD2;

    sum8b sumador (
        .A(A),
        .B(B),
        .Sel(Sel),
        .S(S),
        .Cout(Cout)
    );

    DivFrec div_clk (
        .clk(clk),
        .Q(clk_div)
    );

    SelAn seleccion (
        .clk(clk_div),
        .sel(sel_disp),
        .an(an)
    );

    BCD conversor (
        .bin(S),
        .BCD0(BCD0),
        .BCD1(BCD1),
        .BCD2(BCD2)
    );

    assign bcd = (sel_disp == 2'b00) ? BCD0 :
                 (sel_disp == 2'b01) ? BCD1 :
                 (sel_disp == 2'b10) ? BCD2 :
                 4'd15;

    BCDtoSSeg seg (
        .BCD(bcd),
        .SSeg(SSeg),
        .an()
    );

endmodule
