//`include "src/BCD.v"
//`include "src/DivFrec.v"
//`include "src/SelAn.v"
//`include "src/BCDtoSSeg.v"
module Display (
    input clk,
    input signed [8:0] resultado,   // [8]=signo, [7:0]=magnitud
    output [6:0] SSeg,
    output [3:0] an
);
    wire signo = resultado[8];
    wire [8:0] magnitud = signo ? (~resultado + 1'b1) : resultado;
    wire mostrar_signo = signo && (magnitud != 0); // solo muestra guion si magnitud != 0

    wire [3:0] BCD0, BCD1, BCD2;
    wire [1:0] sel_disp;
    reg [3:0] bcd;

    BCD conversor (
        .bin(mag),
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
            2'b00: bcd = BCD0;                      // unidades (derecha)
            2'b11: bcd = BCD1;                      // decenas
            2'b10: bcd = BCD2;                      // centenas
            2'b01: bcd = mostrar_signo ? 4'd10 : 4'd11;     // signo (izquierda)
        endcase
    end

    BCDtoSSeg seg (
        .BCD(bcd),
        .SSeg(SSeg)
    );
endmodule
