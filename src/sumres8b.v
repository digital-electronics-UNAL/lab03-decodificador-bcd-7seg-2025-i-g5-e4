module sumres8b (
    input  [7:0] A,
    input  [7:0] B,
    input        Sel,     // 0 = suma, 1 = resta
    output [7:0] S,
    output       Cout
);

    wire [7:0] B_xor_Sel;
    wire [7:0] Sn;
    wire Coutn;

    assign B_xor_Sel = B ^ {8{Sel}};

    sum8b sumador (
        .A(A),
        .B(B_xor_Sel),
        .Sel(Sel),  // Esto se conecta como CarryIn (Ci)
        .S(Sn),
        .Cout(Coutn)
    );

    // ✅ Invertir solo si Sel = 1 (resta), como debe ser
    assign S    = Sel ? ~Sn    : Sn;
    assign Cout = Sel ? ~Coutn : Coutn;

endmodule
