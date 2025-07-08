module sum1b (
    input A,
    input B,
    input Ci,
    output S,
    output Cout
);
    wire ab_xor, ab_and, carry_aux;

    xor (ab_xor, A, B);
    xor (S, ab_xor, Ci);
    and (ab_and, A, B);
    and (carry_aux, ab_xor, Ci);
    or  (Cout, ab_and, carry_aux);
endmodule
