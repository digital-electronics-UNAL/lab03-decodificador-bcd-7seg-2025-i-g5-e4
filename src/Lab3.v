module Lab3 (
    input clk,
    input [7:0] A,
    input [7:0] B,
    input Sel,
    output [6:0] SSeg,
    output [3:0] an
);

    wire clk_div;
    wire [1:0] sel_disp;
    reg [3:0] bcd;

    // ✅ Divisor de frecuencia
    DivFrec div_clk (
        .clk(clk),
        .clk_out(clk_div)
    );

    // ✅ Multiplexor de displays
    SelAn seleccion (
        .clk(clk_div),
        .sel(sel_disp),
        .an(an)
    );

    // ✅ Mostrar 1, 2, 3, 4 según el display
    always @(*) begin
        case (sel_disp)
            2'b00: bcd = 4'd1; // Display A
            2'b01: bcd = 4'd2; // Display B
            2'b10: bcd = 4'd3; // Display C
            2'b11: bcd = 4'd4; // Display D
        endcase
    end

    // ✅ Decodificador 7 segmentos
    BCDtoSSeg seg (
        .BCD(bcd),
        .SSeg(SSeg)
    );

endmodule
