module mux_4x1(a, b, c, d, sel, out);
  input a, b, c, d;
  input [1:0] sel;

  output out;

  wire w0, w1, w2, w3;

  and and0(w0, a, ~sel[1], ~sel[0]);
  and and1(w1, b, ~sel[1], sel[0]);
  and and2(w2, c, sel[1], ~sel[0]);
  and and3(w3, d, sel[1], sel[0]);

  or or0(out, w0, w1, w2, w3);
endmodule

module TB_mux_4x1();
  reg a, b, c, d;
  reg [1:0] sel;

  wire out;

  mux_4x1 mux_4x1(a, b, c, d, sel, out);

  initial begin
    sel = 2'b00; a = 1'b1; b = 1'b0; c = 1'b0; d = 1'b0; #10; // out = 1
    sel = 2'b01; a = 1'b0; b = 1'b1; c = 1'b0; d = 1'b0; #10; // out = 1
    sel = 2'b10; a = 1'b0; b = 1'b0; c = 1'b1; d = 1'b0; #10; // out = 1
    sel = 2'b11; a = 1'b0; b = 1'b0; c = 1'b0; d = 1'b1; #10; // out = 1

    sel = 2'b00; a = 1'b0; b = 1'b0; c = 1'b0; d = 1'b0; #10; // out = 0
    sel = 2'b01; a = 1'b0; b = 1'b0; c = 1'b0; d = 1'b0; #10; // out = 0
    sel = 2'b10; a = 1'b0; b = 1'b0; c = 1'b0; d = 1'b0; #10; // out = 0
    sel = 2'b11; a = 1'b0; b = 1'b0; c = 1'b0; d = 1'b0; #10; // out = 0

    sel = 2'b00; a = 1'b0; b = 1'b1; c = 1'b1; d = 1'b1; #10; // out = 0
    sel = 2'b01; a = 1'b1; b = 1'b0; c = 1'b1; d = 1'b1; #10; // out = 0
    sel = 2'b10; a = 1'b1; b = 1'b1; c = 1'b0; d = 1'b1; #10; // out = 0
    sel = 2'b11; a = 1'b1; b = 1'b1; c = 1'b1; d = 1'b0; #10; // out = 0
  end
 endmodule
 