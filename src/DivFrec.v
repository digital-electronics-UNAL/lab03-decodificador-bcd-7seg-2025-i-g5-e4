module DivFrec (
    input  clk,
    output reg clk_out
);
    reg [15:0] cnt = 0;
    always @(posedge clk) begin
        cnt     <= cnt + 1;
        clk_out <= cnt[15];
    end
endmodule