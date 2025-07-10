module sumres8b (
    input  [7:0] A,
    input  [7:0] B,
    input        Sel,     // 0 = suma, 1 = resta
    output [7:0] S,
    output       Cout
);
    reg [8:0] tmp;
    always @(*) begin
        if (Sel)
            tmp = {1'b0, A} - {1'b0, B}; // resta en 9 bits
        else
            tmp = {1'b0, A} + {1'b0, B}; // suma en 9 bits
    end
    assign S = tmp[7:0];
    assign Cout = tmp[8]; // carry/borrow out
endmodule

