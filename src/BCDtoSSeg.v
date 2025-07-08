module BCDtoSSeg (
    input [3:0] BCD,
    output reg [6:0] SSeg,
    output [3:0] an
);

    always @(*) begin
        case (BCD)
            4'd0:  SSeg = 7'b1000000;
            4'd1:  SSeg = 7'b1111001;
            4'd2:  SSeg = 7'b0100100;
            4'd3:  SSeg = 7'b0110000;
            4'd4:  SSeg = 7'b0011001;
            4'd5:  SSeg = 7'b0010010;
            4'd6:  SSeg = 7'b0000010;
            4'd7:  SSeg = 7'b1111000;
            4'd8:  SSeg = 7'b0000000;
            4'd9:  SSeg = 7'b0010000;
            4'd10: SSeg = 7'b0111111; // ✅ guion: solo segmento 'g' activo
            4'd11: SSeg = 7'b1111111; // blanco
            default: SSeg = 7'b1111111;
        endcase
    end

endmodule
