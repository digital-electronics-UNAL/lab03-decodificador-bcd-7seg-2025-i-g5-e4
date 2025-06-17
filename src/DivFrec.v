module DivFrec (
    input clk,
    output reg Q
);
    always @(posedge clk) begin
        Q <= ~Q;
    end
endmodule
