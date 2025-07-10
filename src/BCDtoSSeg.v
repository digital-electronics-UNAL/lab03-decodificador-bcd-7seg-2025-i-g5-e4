module BCDtoSSeg (
    input [3:0] BCD,
    output reg [6:0] SSeg
);
    always @(*) begin
        case (BCD)
            4'd0:  SSeg = 7'b0000001; // 0
            4'd1:  SSeg = 7'b1001111; // 1
            4'd2:  SSeg = 7'b0010010; // 2
            4'd3:  SSeg = 7'b0000110; // 3
            4'd4:  SSeg = 7'b1001100; // 4
            4'd5:  SSeg = 7'b0100100; // 5
            4'd6:  SSeg = 7'b0100000; // 6
            4'd7:  SSeg = 7'b0001111; // 7
            4'd8:  SSeg = 7'b0000000; // 8
            4'd9:  SSeg = 7'b0000100; // 9
            4'd10: SSeg = 7'b1111110; // "-" (signo negativo)
            4'd11: SSeg = 7'b1111111; // blanco
            default: SSeg = 7'b1111111;
        endcase
    end
endmodule