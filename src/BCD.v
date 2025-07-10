module BCD (
    input [8:0] bin,
    output reg [3:0] BCD2,
    output reg [3:0] BCD1,
    output reg [3:0] BCD0
);
    integer i;
    reg [19:0] shift_reg;
    always @(*) begin
        shift_reg = 0;
        shift_reg[8:0] = bin;
        for (i = 0; i < 9; i = i + 1) begin
            if (shift_reg[11:8] >= 5)
                shift_reg[11:8] = shift_reg[11:8] + 3;
            if (shift_reg[15:12] >= 5)
                shift_reg[15:12] = shift_reg[15:12] + 3;
            if (shift_reg[19:16] >= 5)
                shift_reg[19:16] = shift_reg[19:16] + 3;
            shift_reg = shift_reg << 1;
        end
        BCD0 = shift_reg[11:8];
        BCD1 = shift_reg[15:12];
        BCD2 = shift_reg[19:16];
    end
endmodule