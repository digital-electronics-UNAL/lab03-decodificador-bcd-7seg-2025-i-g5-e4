module BCD (
    input clk,
    input [4:0] num,        
    output reg [3:0] BCD
);

    reg algo = 0;
              

    always @(posedge clk) begin
        case (algo)
            1'b0: begin
                BCD <= num % 10;  
                algo <= 1'b1;
            end
            1'b1: begin
                BCD <= (num-num%10)/ 10;  
                algo <= 1'b0;
            end
        endcase
    end
endmodule
