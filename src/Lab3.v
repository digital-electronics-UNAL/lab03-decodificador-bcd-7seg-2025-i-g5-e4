module Lab3 (
    input clk,              // Reloj principal
    input [7:0] A,          // Operando A (desde switches)
    input [7:0] B,          // Operando B (desde switches)
    input Sel,              // 0 = suma, 1 = resta (desde switch)
    output [6:0] SSeg,      // Salida para display de 7 segmentos
    output [3:0] an         // Anodos de displays (activo en bajo)
);

    wire [8:0] resultado;

    // === DEBUG: Asegúrate de que los switches están bien cableados ===
    // Puedes usar esta línea con LEDs si tienes:
    // assign debug_leds = A; // o B, o resultado[7:0]

    // === OJO: Si tu switch Sel es ACTIVO EN BAJO, usa esto: ===
    wire Sel_real = ~Sel;

    // === Instanciar el sumador estructural con signo ===
    // Este módulo usa sumres8b y entrega resultado de 9 bits (complemento a 2)
    Sumador9b alu (
        .A(A),               // A entra directamente (sin inversión)
        .B(B),               // B entra directamente (sin inversión)
        .Sel(Sel_real),      // Forzar suma/resta desde switch
        .resultado(resultado)
    );

    // === Display: visualiza el número con signo ===
    // Este módulo toma el resultado, detecta el signo y convierte a BCD
    Display visor (
        .clk(clk),           // reloj para multiplexación
        .resultado(resultado), // número firmado a mostrar
        .SSeg(SSeg),         // salidas para segmentos
        .an(an)              // selección de display activo
    );

endmodule
