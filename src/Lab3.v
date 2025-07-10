// top_mux.v
module Lab3 (
    input  wire       CLK,     // reloj de la FPGA
    input  wire       RSTn,    // reset activo-bajo
    input  wire [7:0] SW_A,    // SW_A = A[7:0]
    input  wire [7:0] SW_B,    // SW_B = B[7:0]
    input  wire       KEY0,    // KEY0 = sel (0=suma, 1=resta)
    output wire [6:0] SEG,     // segmentos comunes
    output wire [3:0] AN       // ánodos multiplexados
);

  // 1) Genera la señal de refresco (~1 kHz) para multiplexar displays
  wire clk_div;
  DivFrec u_div (
    .CLK   (CLK),
    .RSTn  (RSTn),
    .CLKDIV(clk_div)
  );

  // 2) Selector de dígito activo (2 bits) + ánodos
  wire [1:0] SEL;
  SelAn u_sel (
    .CLK (clk_div),
    .AN  (AN),
    .SEL (SEL)
  );

  // 3) Sumador/restador en 9 bits (signed)
  wire signed [8:0] result9;
  sum8b_signed u_sum (
    .A   (SW_A),
    .B   (SW_B),
    .sel (~KEY0),      // ajusta inversión si es necesario
    .result(result9)
  );

  // 4) Separa signo y magnitud absoluta
  wire        sign = result9[8];
  wire [8:0]  mag  = sign ? -result9 : result9;

  // 5) Binario a BCD (hasta 3 dígitos)
  wire [11:0] bcd;
  BCD u_bcd (
    .BIN(mag),
    .BCD(bcd)
  );

  // 6) Mux de los 4 dígitos (3 cifras + signo)
  reg [3:0] digit;
  always @(*) begin
    case (SEL)
      2'b00: digit = bcd[3:0];    // unidades
      2'b01: digit = bcd[7:4];    // decenas
      2'b10: digit = bcd[11:8];   // centenas
      2'b11: digit = 4'hF;        // valor “especial” para signo
      default: digit = 4'h0;
    endcase
  end

  // 7) De BCD (o signo) a 7-segmentos
  wire [6:0] seg_bcd;
  BCDtoSSeg u_ss (
    .BCD(digit),
    .SEG(seg_bcd)
  );

  // Si es el dígito de signo, fuerza “–” o en blanco
  assign SEG = (SEL==2'b11)
               ? (sign ? 7'b1111110    // “–” en segmento g
                       : 7'b1111111)   // todos apagados
               : seg_bcd;

endmodule

