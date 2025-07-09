module Sumador9b (
    input  [7:0] A,
    input  [7:0] B,
    input        Sel,         // 0 = suma, 1 = resta
    output reg [8:0] resultado
);

    always @(*) begin
        if (Sel)
            resultado = A - B;  // resta como 9-bit unsigned → two’s-complement
        else
            resultado = A + B;  // suma completa de 9 bits (incluye carry)
    end

endmodule
