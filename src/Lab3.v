
module Lab3 (
    input  wire       CLK,      // reloj de la FPGA
    input  wire [7:0] SW_A,     // A[7:0]
    input  wire [7:0] SW_B,     // B[7:0]
    input  wire       KEY0,     // sel (0=suma, 1=resta)
    output wire [6:0] SEG,      // segmentos comunes
    output wire [3:0] AN        // ánodos multiplexados
);

  // 1) DIVISOR DE FRECUENCIA
  wire clk_div;
  DivFrec u_div (
    .clk    (CLK),
    .clk_out(clk_div)
  );

  // 2) SELECTOR DE ÁNODOS
  wire [1:0] SEL;
  SelAn u_sel (
    .clk (clk_div),
    .sel (SEL),
    .an  (AN)
  );

  // 3) SUMA/RESTA EN 9 BITS (signed)
  wire signed [8:0] result9;
  sum8b_signed u_sum (
    .A     (SW_A),
    .B     (SW_B),
    .sel   (~KEY0),       // invierte si tu KEY0 es activo-bajo
    .result(result9)
  );

  // 4) SEPARA SIGNO Y MAGNITUD
  wire        sign = result9[8];
  wire [8:0]  mag  = sign ? -result9 : result9;

  // 5) BINARIO A BCD (3 dígitos)
  wire [3:0] BCD2, BCD1, BCD0;
  BCD u_bcd (
    .bin (mag),
    .BCD2(BCD2),
    .BCD1(BCD1),
    .BCD0(BCD0)
  );

  // 6) MUX DIGITOS (0=unidades,1=decenas,2=centenas,3=signo)
  reg [3:0] digit;
  always @(*) begin
    case (SEL)
      2'd0: digit = BCD0;     // unidades
      2'd1: digit = BCD1;     // decenas
      2'd2: digit = BCD2;     // centenas
      2'd3: digit = 4'hF;     // canal de signo
      default: digit = 4'h0;
    endcase
  end

  // 7) BCD A 7-SEG
  wire [6:0] seg_bcd;
  BCDtoSSeg u_ss (
    .BCD (digit),
    .SSeg(seg_bcd)
  );

  // 8) SEGMENTOS FINALES: si es canal signo, dibuja “–” o en blanco
  assign SEG = (SEL == 2'd3)
               ? (sign ? 7'b1111110   // “–” (segmento g)
                       : 7'b1111111)  // en blanco
               : seg_bcd;

endmodule
