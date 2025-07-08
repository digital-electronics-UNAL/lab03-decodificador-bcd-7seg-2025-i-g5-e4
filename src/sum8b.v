module sum8b (
    input [7:0] A,
    input [7:0] B,
    input Sel,
    output [7:0] S,
    output Cout
);

    wire [7:0] B_mux;
    wire Cin;

    assign B_mux = B ^ {8{Sel}};
    assign Cin = Sel;

    wire [7:0] carry;

    sum1b b0 (A[0], B_mux[0], Cin     , S[0], carry[0]);
    sum1b b1 (A[1], B_mux[1], carry[0], S[1], carry[1]);
    sum1b b2 (A[2], B_mux[2], carry[1], S[2], carry[2]);
    sum1b b3 (A[3], B_mux[3], carry[2], S[3], carry[3]);
    sum1b b4 (A[4], B_mux[4], carry[3], S[4], carry[4]);
    sum1b b5 (A[5], B_mux[5], carry[4], S[5], carry[5]);
    sum1b b6 (A[6], B_mux[6], carry[5], S[6], carry[6]);
    sum1b b7 (A[7], B_mux[7], carry[6], S[7], carry[7]);

    assign Cout = carry[7];

endmodule