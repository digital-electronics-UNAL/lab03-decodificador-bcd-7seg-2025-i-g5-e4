module DivFrec(
    input clk,
    output reg Q
);
    reg [17:0] count = 0;  // 18 bits alcanzan hasta 262143

    always @(posedge clk) begin
        if (count >= 199_999) begin
            count <= 0;
            Q <= ~Q;
        end else begin
            count <= count + 1;
        end
    end
endmodule
