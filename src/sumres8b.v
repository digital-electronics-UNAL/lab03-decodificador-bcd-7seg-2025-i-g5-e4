module sumres8b (
    input  [7:0] A,
    input  [7:0] B,
    input        Sel,     // 0 = suma, 1 = resta
    output [7:0] S,
    output       Cout
);

    wire [7:0] result;
    wire carry;

    sum8b u_sum8b (
        .A(A),
        .B(B),
        .Sel(Sel),
        .S(result),
        .Cout(carry)
    );

    assign S = result;
    assign Cout = carry;

endmodule
