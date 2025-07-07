
module sum8b (
    input  [7:0] A,
    input  [7:0] B,
    input        Sel,     // 0 = suma, 1 = resta
    output [7:0] S,
    output       Cout
);

    wire [7:0] carry;
    wire [7:0] B_xor_Sel;

    assign B_xor_Sel = B ^ {8{Sel}};

    sum1b FA0 (.A(A[0]), .B(B_xor_Sel[0]), .Ci(Sel),       .Cout(carry[0]), .S(S[0]));
    sum1b FA1 (.A(A[1]), .B(B_xor_Sel[1]), .Ci(carry[0]),  .Cout(carry[1]), .S(S[1]));
    sum1b FA2 (.A(A[2]), .B(B_xor_Sel[2]), .Ci(carry[1]),  .Cout(carry[2]), .S(S[2]));
    sum1b FA3 (.A(A[3]), .B(B_xor_Sel[3]), .Ci(carry[2]),  .Cout(carry[3]), .S(S[3]));
    sum1b FA4 (.A(A[4]), .B(B_xor_Sel[4]), .Ci(carry[3]),  .Cout(carry[4]), .S(S[4]));
    sum1b FA5 (.A(A[5]), .B(B_xor_Sel[5]), .Ci(carry[4]),  .Cout(carry[5]), .S(S[5]));
    sum1b FA6 (.A(A[6]), .B(B_xor_Sel[6]), .Ci(carry[5]),  .Cout(carry[6]), .S(S[6]));
    sum1b FA7 (.A(A[7]), .B(B_xor_Sel[7]), .Ci(carry[6]),  .Cout(carry[7]), .S(S[7]));

    assign Cout = carry[7];

endmodule
