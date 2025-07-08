module sum1b (
    input A, 
    input B, 
    input Cin,
    output Cout,
    output S
  );
  
    wire a_ab;
    wire x_ab;
    wire cout_t;
  
    and(a_ab,A,B); 
    xor(S,x_ab,Cin);
    xor(x_ab,A,B);
    and(cout_t,x_ab,Cin);
    or (Cout,cout_t,a_ab);
  
  endmodule