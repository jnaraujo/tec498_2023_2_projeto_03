module mux_32x8(
  a, b, c, d,
  sel,
  out
);
  input [7:0] a, b, c, d;
  input [1:0] sel;
  output [7:0] out;

  mux_4x1 m0(a[0], b[0], c[0], d[0], sel, out[0]);
  mux_4x1 m1(a[1], b[1], c[1], d[1], sel, out[1]);
  mux_4x1 m2(a[2], b[2], c[2], d[2], sel, out[2]);
  mux_4x1 m3(a[3], b[3], c[3], d[3], sel, out[3]);
  mux_4x1 m4(a[4], b[4], c[4], d[4], sel, out[4]);
  mux_4x1 m5(a[5], b[5], c[5], d[5], sel, out[5]);
  mux_4x1 m6(a[6], b[6], c[6], d[6], sel, out[6]);
  mux_4x1 m7(a[7], b[7], c[7], d[7], sel, out[7]);  
endmodule

module TB_Mux32x8();
  reg [1:0] sel;
  wire [7:0] a, b, c, d;
  wire [7:0] out;

  assign a = 8'b10000001;
  assign b = 8'b11000011;
  assign c = 8'b11100111;
  assign d = 8'b11110001;

  mux_32x8 mux_32x8(a, b, c, d, sel, out);

  initial begin
    sel = 2'b00; #10; // out = 10000001
    sel = 2'b01; #10; // out = 11000011
    sel = 2'b10; #10; // out = 11100111
    sel = 2'b11; #10; // out = 11110001
  end
 endmodule
 