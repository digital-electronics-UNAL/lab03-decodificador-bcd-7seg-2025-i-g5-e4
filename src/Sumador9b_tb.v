`timescale 1ns / 1ps

module tb_Sumador9b;
    reg [7:0] A;
    reg [7:0] B;
    reg Sel;          // 0 = suma, 1 = resta
    wire [8:0] resultado;

  
    Sumador9b dut (
        .A(A),
        .B(B),
        .Sel(Sel),
        .resultado(resultado)
    );

    task show_result;
        input [7:0] a, b;
        input s;
        input [8:0] r;
        begin
            $display("A=%0d, B=%0d, Sel=%0d -> resultado(bin)=%b resultado(dec signed)=%0d", a, b, s, r, $signed(r));
        end
    endtask

    initial begin
        $dumpfile("Sumador9b.vcd");
        $dumpvars(0, tb_Sumador9b);
        // Caso 1: 0 + 255
        A = 0; B = 8'b11111111; Sel = 0; #10;
        show_result(A, B, Sel, resultado); // Esperado: 255

        // Caso 2: 1 + 255
        A = 1; B = 8'b11111111; Sel = 0; #10;
        show_result(A, B, Sel, resultado); // Esperado: 256

        // Caso 3: 1 + 1
        A = 1; B = 1; Sel = 0; #10;
        show_result(A, B, Sel, resultado); // Esperado: 2

        // Caso 4: 1 - 1
        A = 1; B = 1; Sel = 1; #10;
        show_result(A, B, Sel, resultado); // Esperado: 0

        // Caso 5: 0 - 0
        A = 0; B = 0; Sel = 1; #10;
        show_result(A, B, Sel, resultado); // Esperado: 0

        // Caso 6: 2 - 4
        A = 2; B = 4; Sel = 1; #10;
        show_result(A, B, Sel, resultado); // Esperado: -2

        // Caso 7: 128 + 128
        A = 128; B = 128; Sel = 0; #10;
        show_result(A, B, Sel, resultado); // Esperado: 256

        // Caso 8: 255 + 0
        A = 255; B = 0; Sel = 0; #10;
        show_result(A, B, Sel, resultado); // Esperado: 255

        // Caso 9: 0 - 255
        A = 0; B = 255; Sel = 1; #10;
        show_result(A, B, Sel, resultado); // Esperado: -255

        // Caso 10: 1 - 255
        A = 1; B = 255; Sel = 1; #10;
        show_result(A, B, Sel, resultado); // Esperado: -254

        $finish;
    end
endmodule
