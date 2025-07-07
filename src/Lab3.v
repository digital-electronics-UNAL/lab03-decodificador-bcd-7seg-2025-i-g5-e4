module lab3 (
    input clk,
    input [7:0] A, B,
    input Cin,
    output [6:0] seg,
    output [3:0] an
);

    wire [7:0] S;
    wire Cout;

    wire [3:0] unidad, decena, centena;
    wire [1:0] sel;
    wire [3:0] bcd_digit;
    wire clk_slow;

    sum8b u_sum8b (
        .A(A),
        .B(B),
        .Cin(Cin),
        .S(S),
        .Cout(Cout)
    );

    BCD u_bcd (
        .bin(S),
        .unidad(unidad),
        .decena(decena),
        .centena(centena)
    );

    DivFrec u_div (
        .clk(clk),
        .clk_out(clk_slow)
    );

    SelAn u_sel (
        .clk(clk_slow),
        .sel(sel),
        .an(an)
    );

    assign bcd_digit = (sel == 2'b00) ? unidad :
                       (sel == 2'b01) ? decena :
                       (sel == 2'b10) ? centena :
                       4'b1111;

    BCDtoSSeg u_disp (
        .BCD(bcd_digit),
        .Sseg(seg)
    );

endmodule