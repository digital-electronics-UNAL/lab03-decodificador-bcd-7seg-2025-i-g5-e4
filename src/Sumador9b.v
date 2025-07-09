module Sumador9b (
    input  [7:0] A,
    input  [7:0] B,
    input        Sel,         // 0 = A+B, 1 = A–B
    output reg [8:0] resultado
);
    always @(*) begin
        if (Sel)
            resultado = A - B;  // resta (two’s-complement implícito)
        else
            resultado = A + B;  // suma completa con carry
    end
endmodule