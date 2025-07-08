module sumres8b (
    input  [7:0] A,
    input  [7:0] B,
    input        Sel,       // 0 = suma, 1 = resta
    output [7:0] S,
    output       Cout
);

    wire [7:0] B_xor_Sel;
    wire [7:0] Sn;
    wire Coutn;

    // ✅ Resta: B ⊕ 1’s → complemento a 1 si Sel = 1
    assign B_xor_Sel = B ^ {8{Sel}};

    // ✅ Usa sumador estructural de 8 bits
    sum8b U1 (
        .A(A),
        .B(B_xor_Sel),
        .Ci(Sel),       // Sel = 1 → suma +1 (complemento a 2)
        .S(Sn),
        .Cout(Coutn)
    );

    // ✅ Invertir resultado si Sel = 1 para visualización con signo
    assign S    = Sel ? ~Sn : Sn;
    assign Cout = Sel ? ~Coutn : Coutn;

endmodule
