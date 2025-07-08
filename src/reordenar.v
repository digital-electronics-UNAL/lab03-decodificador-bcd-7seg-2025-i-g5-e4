module reordenar (
    input  [7:0] in,
    output [7:0] out
);
    assign out = {in[0], in[1], in[2], in[3], in[4], in[5], in[6], 1'b0}; // MSB = 0
endmodule
