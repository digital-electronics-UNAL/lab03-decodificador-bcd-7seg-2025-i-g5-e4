module DisplayNum (
    input clk,
    input [8:0] valor,
    output [6:0] SSeg,
    output [3:0] an
);
    wire [3:0] BCD0, BCD1, BCD2;
    wire [1:0] sel_disp;
    reg [3:0] bcd;

   
    BCD conversor (
        .bin(valor),
        .BCD2(BCD2),
        .BCD1(BCD1),
        .BCD0(BCD0)
    );

    wire clk_div;
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
            2'b00: bcd = BCD0; // unidades
            2'b11: bcd = BCD1; // decenas
            2'b10: bcd = BCD2; // centenas
            2'b01: bcd = 4'd11; // blanco (sin signo)
        endcase
    end

    BCDtoSSeg seg (
        .BCD(bcd),
        .SSeg(SSeg)
    );
endmodule
