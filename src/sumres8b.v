module sumres8b (
    input  [7:0] A,
    input  [7:0] B,
    input        Sel,     // 0 = suma, 1 = resta
    output signed [8:0] resultado
);
    reg signed [8:0] tmp;
    always @(*) begin
        if (Sel)
            tmp = A - B; 
        else
            tmp = A + B;
    end
    assign resultado = tmp;
endmodule
