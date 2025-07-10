//`include "src/Display.v"
//`include "src/Sumador9b.v"
module Lab3 (
    input clk,
    input [7:0] A_fpga,
    input [7:0] B_fpga,
    input Sel_fpga,
    output [6:0] SSeg,
    output [3:0] an
);

    wire [7:0] A = ~A_fpga;
    wire [7:0] B = ~B_fpga;
    wire Sel = ~Sel_fpga;
    wire [8:0] resultado;

    Sumador9b alu (
        .A(A),
        .B(B),
        .Sel(Sel),
        .resultado(resultado)
    );

    Display visor (
        .clk(clk),
        .resultado(resultado),
        .SSeg(SSeg),
        .an(an)
    );

endmodule
