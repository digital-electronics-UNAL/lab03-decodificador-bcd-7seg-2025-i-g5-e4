module SelBCD(
    input [3:0] DIP_BCD,
    input [1:0] DIP_SEL,
    output [0:6] SSeg,
    output reg [3:0] an
);

  wire [3:0] an_bcd;

  BCDtoSSeg bcd_display (
    .BCD(DIP_BCD),
    .SSeg(SSeg),
    .an(an_bcd)
  );

  always @(*) begin
    case (DIP_SEL)
      2'b00: an = 4'b1110;
      2'b01: an = 4'b1101;
      2'b10: an = 4'b1011;
      2'b11: an = 4'b0111;
      default: an = 4'b1111;
    endcase
  end

endmodule
