//`include "src/Display.v"
//`include "src/Sumador9b.v"
module Lab3 (
    input clk,
    input [7:0] A_fpga,
    output [6:0] SSeg,
    output [3:0] an
);

    // Cambia el orden o la negación según cómo estén tus switches físicos:
    // Ejemplo 1: Switch derecho = A_fpga[0]
    wire [7:0] A = {~A_fpga[7], ~A_fpga[6], ~A_fpga[5], ~A_fpga[4], ~A_fpga[3], ~A_fpga[2], ~A_fpga[1], ~A_fpga[0]};
    // Ejemplo 2: Si el derecho es A_fpga[7], usa {~A_fpga[0], ..., ~A_fpga[7]}

    wire [8:0] valor = {1'b0, A}; // siempre positivo

    DisplayNum visor (
        .clk(clk),
        .valor(valor),
        .SSeg(SSeg),
        .an(an)
    );

endmodule
-





