module sumres8b (
    input  [7:0] A,
    input  [7:0] B,
    input        Sel,     // 0 = suma, 1 = resta
    output [8:0] resultado // 9 bits, firmado
);
    reg [8:0] tmp;
    always @(*) begin
        if (Sel)
            tmp = {1'b0, A} - {1'b0, B}; // resta en 9 bits (con signo)
        else
            tmp = {1'b0, A} + {1'b0, B}; // suma en 9 bits
    end
    assign resultado = tmp;
endmodule
