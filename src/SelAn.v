module SelAn (
    input clk,
    output reg [1:0] sel,
    output reg [3:0] an
);

   always @(posedge clk) begin
    sel <= sel + 1;

    case(sel)
        2'b00: an <= 4'b1110; // an[0] activo → display derecho
        2'b01: an <= 4'b1101; // an[1]
        2'b10: an <= 4'b1011; // an[2]
        2'b11: an <= 4'b0111; // an[3] activo → display izquierdo
        default: an <= 4'b1111;
    endcase
end


endmodule
