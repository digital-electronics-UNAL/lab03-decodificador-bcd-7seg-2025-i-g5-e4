// sum8b_signed.v
module sum8b(
  input  wire [7:0] A,
  input  wire [7:0] B,
  input  wire       sel,     // 0 = A+B, 1 = A–B
  output wire signed [8:0] result
);
  // Extiende a 9 bits e interpreta en two’s-complement
  wire signed [8:0] sA = {1'b0, A};
  wire signed [8:0] sB = {1'b0, B};

  // Suma o resta en 9 bits con signo
  assign result = (sel)
                  ? (sA - sB)
                  : (sA + sB);
endmodule
