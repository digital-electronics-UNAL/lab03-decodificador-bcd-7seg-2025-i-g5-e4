module SelAn (
    input clk,
    output reg [1:0] sel,
    output reg [3:0] an
);
    always @(posedge clk) begin
        sel <= sel + 1;
        case (sel)
            2'b00: an <= 4'b1110;
            2'b01: an <= 4'b1101;
            2'b10: an <= 4'b1011;
            2'b11: an <= 4'b0111;
        endcase
    end
endmodule