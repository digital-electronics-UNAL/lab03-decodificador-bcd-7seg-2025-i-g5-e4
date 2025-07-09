module BCD (
    input  [8:0] bin,
    output reg [3:0] BCD2, BCD1, BCD0
);
    integer i;
    reg [19:0] shift;

    always @(*) begin
        shift = 0;
        shift[8:0] = bin;
        for (i = 0; i < 9; i = i + 1) begin
            if (shift[11:8]  >= 4'd5)  shift[11:8]  = shift[11:8]  + 4'd3;
            if (shift[15:12] >= 4'd5)  shift[15:12] = shift[15:12] + 4'd3;
            if (shift[19:16] >= 4'd5)  shift[19:16] = shift[19:16] + 4'd3;
            shift = shift << 1;
        end
        BCD2 = shift[19:16];
        BCD1 = shift[15:12];
        BCD0 = shift[11:8];
    end
endmodule
