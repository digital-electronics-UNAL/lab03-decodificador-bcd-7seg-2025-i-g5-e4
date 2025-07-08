module BCD (
    input [8:0] bin,
    output reg [3:0] BCD2,
    output reg [3:0] BCD1,
    output reg [3:0] BCD0
);
    integer i;
    reg [19:0] shift;

    always @(*) begin
        shift = 20'd0;
        shift[8:0] = bin;

        for (i = 0; i < 9; i = i + 1) begin
            if (shift[11:8] >= 5)
                shift[11:8] = shift[11:8] + 3;
            if (shift[15:12] >= 5)
                shift[15:12] = shift[15:12] + 3;
            if (shift[19:16] >= 5)
                shift[19:16] = shift[19:16] + 3;

            shift = shift << 1;
        end

        BCD0 = shift[11:8];
        BCD1 = shift[15:12];
        BCD2 = shift[19:16];
    end
endmodule
