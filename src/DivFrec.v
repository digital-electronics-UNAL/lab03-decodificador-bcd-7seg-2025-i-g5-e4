module DivFrec(
    input clk,
    output reg clk_out
);

    reg [19:0] count = 0;

    always @(posedge clk) begin
        count <= count + 1;
        clk_out <= count[16];
    end

endmodule
