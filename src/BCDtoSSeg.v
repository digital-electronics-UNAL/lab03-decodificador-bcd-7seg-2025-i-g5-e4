module BCDtoSSeg (
    input wire [3:0] BCD,     // Entrada de 4 bits BCD
    output reg [6:0] SSeg,    // Salida de 7 segmentos de visualización de tipo anodo común
    output reg An             // Anodo común
);

always @* begin
    case(~BCD) 
        4'b1111: SSeg = 7'b1111110; // 0
        4'b1110: SSeg = 7'b0110000; // 1
        4'b1101: SSeg = 7'b1101101; // 2
        4'b1100: SSeg = 7'b1111001; // 3
        4'b1011: SSeg = 7'b0110011; // 4
        4'b1010: SSeg = 7'b1011011; // 5
        4'b1001: SSeg = 7'b1011111; // 6
        4'b1000: SSeg = 7'b1110000; // 7
        4'b0111: SSeg = 7'b1111111; // 8
        4'b0110: SSeg = 7'b1111011; // 9
        4'b0101: SSeg = 7'b1110111; // A
        4'b0100: SSeg = 7'b0011111; // B
        4'b0011: SSeg = 7'b1001110; // C
        4'b0010: SSeg = 7'b0111101; // D
        4'b0001: SSeg = 7'b1001111; // E
        4'b0000: SSeg = 7'b1000111; // F
        default: SSeg = 7'bxxxxxxx; // Undefined
    endcase
end

endmodule
