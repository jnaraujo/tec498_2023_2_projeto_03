module mux_16x8(
  a, b,
  sel,
  out
);
  input [7:0] a, b;
  input  sel;
  output [7:0] out;

  mux_2x1 mux0(a[0], b[0], sel, out[0]);
  mux_2x1 mux1(a[1], b[1], sel, out[1]);
  mux_2x1 mux2(a[2], b[2], sel, out[2]);
  mux_2x1 mux3(a[3], b[3], sel, out[3]);
  mux_2x1 mux4(a[4], b[4], sel, out[4]);
  mux_2x1 mux5(a[5], b[5], sel, out[5]);
  mux_2x1 mux6(a[6], b[6], sel, out[6]);
  mux_2x1 mux7(a[7], b[7], sel, out[7]);
endmodule

module TB_mux_16x8();
  reg sel;
  reg [7:0] a, b;
  wire [7:0] out;

  mux_16x8 mux_16x8(a, b, sel, out);

  initial begin
    a = 8'b10000011;
    b = 8'b11000111;

    sel = 1'b0; #10; // out = b10000011
    sel = 1'b1; #10; // out = b11000111
  end
endmodule