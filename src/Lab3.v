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
    reg [8:0] digito;
    wire [3:0] bcd;

    // Inversión de señales por lógica negada (switches activos en 0)
    wire [7:0] A_in = ~A;
    wire [7:0] B_in = ~B;
    wire Sel_real = ~Sel;

    sum8b sumador (
        .A(A_in),
        .B(B_in),
        .Sel(Sel_real),
        .S(S),
        .Cout(Cout)
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
            2'b00: digito = {5'd0, S[3:0]};   // unidades
            2'b01: digito = {5'd0, S[7:4]};   // decenas
            2'b10: digito = {8'd0, Cout};     // carry out
            default: digito = 9'd0;
        endcase
    end

    BCD conversor (
        .bin(digito),
        .BCD0(bcd),
        .BCD1(),
        .BCD2()
    );

    BCDtoSSeg seg (
        .BCD(bcd),
        .SSeg(SSeg),
        .an()
    );

endmodule
