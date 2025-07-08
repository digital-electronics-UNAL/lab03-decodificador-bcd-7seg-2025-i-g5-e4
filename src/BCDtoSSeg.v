module BCDtoSSeg (
    input [3:0] BCD,
    output reg [6:0] SSeg
);

    always @(*) begin
        case (BCD)
            4'd0: SSeg = 7'b1000000; // 0
            4'd1: SSeg = 7'b1111001; // 1
            4'd2: SSeg = 7'b0100100; // 2
            4'd3: SSeg = 7'b0110000; // 3
            4'd4: SSeg = 7'b0011001; // 4
            4'd5: SSeg = 7'b0010010; // 5
            4'd6: SSeg = 7'b0000010; // 6
            4'd7: SSeg = 7'b1111000; // 7
            4'd8: SSeg = 7'b0000000; // 8
            4'd9: SSeg = 7'b0010000; // 9
            4'd10: SSeg = 7'b0001000; // A
            4'd11: SSeg = 7'b0000011; // b
            4'd12: SSeg = 7'b1000110; // C
            4'd13: SSeg = 7'b0100001; // d
            4'd14: SSeg = 7'b0000110; // E
            4'd15: SSeg = 7'b0001110; // F / apagado
            default: SSeg = 7'b1111111; // apagado
        endcase
    end
endmodule
