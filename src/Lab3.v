// Lab3.v completamente funcional con asignación de pines
module Lab3 (
    input clk,                       // PIN_23
    input [7:0] A,                  // A[7:0] ↔ PIN_58 a PIN_68
    input [7:0] B,                  // B[7:0] ↔ PIN_30 a PIN_38
    input Sel,                      // PIN_90
    input test,                     // PIN personalizado si se usa
    output [6:0] SSeg,              // SSeg[6:0] ↔ PIN_119 a PIN_127
    output [3:0] an                 // an[3:0] ↔ PIN_128 a PIN_133
);

    wire clk_div;
    wire [7:0] S;
    wire Cout;
    wire [1:0] sel_disp;
    wire [3:0] BCD0, BCD1, BCD2;
    reg [3:0] bcd;
    wire [6:0] SSeg_raw;

    wire [7:0] A_in = ~A;
    wire [7:0] B_in = ~B;
    wire Sel_real = ~Sel;

    sum8b sumador (
        .A(A_in),
        .B(B_in),
        .Sel(Sel_real),
        .S(S),
        .Cout(Cout)
    );

    BCD conversor (
        .bin({Cout, S}),
        .BCD0(BCD0),
        .BCD1(BCD1),
        .BCD2(BCD2)
    );

    DivFrec div_clk (
        .clk(clk),
        .clk_out(clk_div)
    );

    SelAn seleccion (
        .clk(clk_div),
        .sel(sel_disp),
        .an(an)
    );

    always @(*) begin
        if (test) begin
            case (sel_disp)
                2'b00: bcd = 4'd5;
                2'b01: bcd = 4'd5;
                2'b10: bcd = 4'd2;
                default: bcd = 4'd15;
            endcase
        end else begin
            case (sel_disp)
                2'b00: bcd = BCD0;
                2'b01: bcd = BCD1;
                2'b10: bcd = BCD2;
                default: bcd = 4'd15;
            endcase
        end
    end

    BCDtoSSeg seg (
        .BCD(bcd),
        .SSeg(SSeg_raw)
    );

    assign SSeg = {
        SSeg_raw[6], // A
        SSeg_raw[5], // B
        SSeg_raw[4], // C
        SSeg_raw[3], // D
        SSeg_raw[2], // E
        SSeg_raw[1], // F
        SSeg_raw[0]  // G
    };

endmodule
