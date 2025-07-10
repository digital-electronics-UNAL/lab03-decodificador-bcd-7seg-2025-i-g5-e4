module sumres8b (
    input  [7:0] A,
    input  [7:0] B,
    input        Sel,     // 0 = suma, 1 = resta
    output signed [8:0] resultado // 9 bits, firmado
);
    reg signed [8:0] tmp;
    always @(*) begin
        if (Sel)
            tmp = $signed({1'b0, A}) - $signed({1'b0, B}); // resta firmada
        else
            tmp = $signed({1'b0, A}) + $signed({1'b0, B}); // suma firmada
    end
    assign resultado = tmp;
endmodule
