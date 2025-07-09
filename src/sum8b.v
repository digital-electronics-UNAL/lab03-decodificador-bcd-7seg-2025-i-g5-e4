module sum8b (
    input  [7:0] A,
    input  [7:0] B,
    input        Sel,     // 0 = suma, 1 = resta
    output [7:0] S,
    output       Cout
);
    reg [8:0] tmp;

    always @(*) begin
        if (Sel)
            tmp = A - B;
        else
            tmp = A + B;
    end

    assign S = tmp[7:0];
    assign Cout = tmp[8];

endmodule
