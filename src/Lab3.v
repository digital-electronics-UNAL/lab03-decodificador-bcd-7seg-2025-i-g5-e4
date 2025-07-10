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

    wire [7:0] A = {~A_fpga[7], ~A_fpga[6], ~A_fpga[5], ~A_fpga[4], ~A_fpga[3], ~A_fpga[2], ~A_fpga[1], ~A_fpga[0]};
    wire [7:0] B = {~B_fpga[7], ~B_fpga[6], ~B_fpga[5], ~B_fpga[4], ~B_fpga[3], ~B_fpga[2], ~B_fpga[1], ~B_fpga[0]};
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
