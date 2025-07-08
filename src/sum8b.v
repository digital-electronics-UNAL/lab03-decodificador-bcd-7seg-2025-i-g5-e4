module sum8b (
    input  [7:0] A,      
    input  [7:0] B,      
    input        Ci,     
    output [7:0] S,      
    output       Cout   
);

    wire [6:0] carry;

    sum1b FA0 (.A(A[0]), .B(B[0]), .Cin(Ci),        .Cout(carry[0]), .S(S[0]));
    sum1b FA1 (.A(A[1]), .B(B[1]), .Cin(carry[0]),  .Cout(carry[1]), .S(S[1]));
    sum1b FA2 (.A(A[2]), .B(B[2]), .Cin(carry[1]),  .Cout(carry[2]), .S(S[2]));
    sum1b FA3 (.A(A[3]), .B(B[3]), .Cin(carry[2]),  .Cout(carry[3]), .S(S[3]));
    sum1b FA4 (.A(A[4]), .B(B[4]), .Cin(carry[3]),  .Cout(carry[4]), .S(S[4]));
    sum1b FA5 (.A(A[5]), .B(B[5]), .Cin(carry[4]),  .Cout(carry[5]), .S(S[5]));
    sum1b FA6 (.A(A[6]), .B(B[6]), .Cin(carry[5]),  .Cout(carry[6]), .S(S[6]));
    sum1b FA7 (.A(A[7]), .B(B[7]), .Cin(carry[6]),  .Cout(Cout),     .S(S[7]));

endmodule
