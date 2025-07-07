module SelAn(
    input clk,               
    output reg [1:0] sel,    
    output reg [3:0] an      
);
    always @(posedge clk) begin
        sel <= sel + 1;
    end

    always @(*) begin
        case (sel)
            2'b00: an = 4'b1110; 
            2'b01: an = 4'b1101; 
            default: an = 4'b1111;
        endcase
    end
endmodule
