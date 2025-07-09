// sum8b.v
// Genera un resultado de 9 bits S[8:0]: S[8]=carry-out (signo+overflow), S[7:0]=resultado
module sum8b (
    input  [7:0] A,
    input  [7:0] B,
    input        sel,  // 0 = suma, 1 = resta
    output [8:0] S
);
    wire [7:0] B2;
    wire [7:0] carry;

    // Si sel=1, invierto B para implementar A + (~B) + 1 = A – B
    assign B2 = B ^ {8{sel}};

    // Primer bit con Cin = sel (si resta, el +1)
    sum1b FA0 (
      .A   (A[0]),
      .B   (B2[0]),
      .Cin (sel),
      .S   (S[0]),
      .Cout(carry[0])
    );

    genvar i;
    generate
      for (i = 1; i < 8; i = i + 1) begin
        sum1b FA (
          .A   (A[i]),
          .B   (B2[i]),
          .Cin (carry[i-1]),
          .S   (S[i]),
          .Cout(carry[i])
        );
      end
    endgenerate

    // El noveno bit es el carry-out final
    assign S[8] = carry[7];
endmodule
