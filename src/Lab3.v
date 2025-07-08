module Lab3 (
    input clk,
    input [7:0] A,
    input [7:0] B,
    input Sel,
    output [6:0] SSeg,
    output [3:0] an
);

    wire clk_div;
    wire [7:0] S;
    wire Cout;

    wire [1:0] sel_disp;
    wire [3:0] BCD0, BCD1, BCD2;
    reg [3:0] bcd;

    // ✅ A: solo inversión de orden (sin lógica negada)
    wire [7:0] A_in = {A[7], A[6], A[5], A[4], A[3], A[2], A[1], A[0]};

    // ✅ B: inversión de orden + lógica negada
    wire [7:0] B_in = ~{B[7], B[6], B[5], B[4], B[3], B[2], B[1], B[0]};

    // ✅ Forzado a suma
    wire Sel_real = 1'b0;

    sumres8b sumador (
        .A(A_in),
        .B(B_in),
        .Sel(Sel_real),
        .S(S),
        .Cout(Cout)
    );

    wire [8:0] abs_result = {Cout, S};

    BCD conversor (
        .bin(abs_result),
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
        case (sel_disp)
            2'b00: bcd = BCD0;       // unidades
            2'b01: bcd = 4'd11;      // blanco (sin signo)
            2'b10: bcd = BCD2;       // centenas
            2'b11: bcd = BCD1;       // decenas
        endcase
    end

    BCDtoSSeg seg (
        .BCD(bcd),
        .SSeg(SSeg)
    );

endmodule
