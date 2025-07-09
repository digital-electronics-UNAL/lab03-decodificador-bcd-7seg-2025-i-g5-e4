// Lab3.v (top-level)
module Lab3 (
    input        clk,       // reloj para multiplexar displays si fuera necesario
    input        sel,       // sel = 0 suma, 1 resta
    input  [7:0] SW_A,      // SW[7:0] → A[7:0]
    input  [7:0] SW_B,      // SW[15:8] → B[7:0] (ajusta según tu placa)
    output [6:0] HEX3,      // dígito centena
    output [6:0] HEX2,      // dígito decena
    output [6:0] HEX1,      // dígito unidad
    output [6:0] HEX0       // signo
);

    wire [8:0] S9;
    wire       negative;
    wire [7:0] magnitude;
    wire [3:0] d_hund, d_tens, d_ones;

    // Instancio el sumador/restador
    sum8b U1 (
      .A  (SW_A),
      .B  (SW_B),
      .sel(sel),
      .S  (S9)
    );

    // Determino signo y magnitud absoluta
    assign negative  = S9[8];
    assign magnitude = negative ? (~S9[7:0] + 1) : S9[7:0];

    // BCD de la magnitud (máx 256 → tres dígitos)
    // Asumo que tu BCD.v acepta un vector de hasta 10 bits y sale 4 dígitos:
    BCD #(.WIDTH(8)) U2 (
      .binary_in (magnitude),
      .BCD_hund  (d_hund),
      .BCD_tens  (d_tens),
      .BCD_ones  (d_ones)
    );

    // Convierto cada nibble BCD a segmentos 7-segmentos
    BCDtoSSeg H3 (.BCD(d_hund), .SS(HEX3));
    BCDtoSSeg H2 (.BCD(d_tens), .SS(HEX2));
    BCDtoSSeg H1 (.BCD(d_ones), .SS(HEX1));

    // Para el dígito de signo muestro “–” o en blanco (“ ”)
    // Asumo que BCDtoSSeg acepta un código especial para “–”:
    wire [3:0] sign_code = negative ? 4'hA : 4'hF;  
    // (puedes mapear 0xA=”–” y 0xF=espacio en BCDtoSSeg)
    BCDtoSSeg H0 (.BCD(sign_code), .SS(HEX0));

endmodule
