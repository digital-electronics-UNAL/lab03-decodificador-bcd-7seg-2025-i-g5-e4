module sumres8b (
    input  [7:0] A,
    input  [7:0] B,
    input        Sel,     // 0 = suma, 1 = resta
    output signed [8:0] resultado // 9 bits, firmado
);
    reg signed [8:0] tmp;
    always @(*) begin
        if (Sel)
            tmp = {1'b0, A} - {1'b0, B}; // opera siempre entre 0 y 255
        else
            tmp = {1'b0, A} + {1'b0, B};
    end
    assign resultado = tmp;
endmodule
