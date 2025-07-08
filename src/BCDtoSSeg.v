module BCDtoSSeg (
    input wire [3:0] BCD,     // Entrada de 4 bits BCD
    output reg [6:0] Sseg,    // Salida de 7 segmentos de visualización de tipo anodo común
    output reg An             // Anodo común
);

always @* begin
    case(~BCD) 
        4'b1111: Sseg = 7'b1111110; // 0
        4'b1110: Sseg = 7'b0110000; // 1
        4'b1101: Sseg = 7'b1101101; // 2
        4'b1100: Sseg = 7'b1111001; // 3
        4'b1011: Sseg = 7'b0110011; // 4
        4'b1010: Sseg = 7'b1011011; // 5
        4'b1001: Sseg = 7'b1011111; // 6
        4'b1000: Sseg = 7'b1110000; // 7
        4'b0111: Sseg = 7'b1111111; // 8
        4'b0110: Sseg = 7'b1111011; // 9
        4'b0101: Sseg = 7'b1110111; // A
        4'b0100: Sseg = 7'b0011111; // B
        4'b0011: Sseg = 7'b1001110; // C
        4'b0010: Sseg = 7'b0111101; // D
        4'b0001: Sseg = 7'b1001111; // E
        4'b0000: Sseg = 7'b1000111; // F
        default: Sseg = 7'bxxxxxxx; // Undefined
    endcase
end

endmodule
