module decodificador_num(
  sel,
  a, b, c, d, e, f, g, dp
);
  input [3:0] sel;
  output a, b, c, d, e, f, g, dp;

  wire w0, w1, w2, w3, w4, w5, w6, w7;
  wire w8, w9, w10, w11, w12, w13, w14, w15;
  wire w16, w17, w18, w19, w20, w21, w22, w23, w24, w25;

  // A = sel[3]
  // B = sel[2]
  // C = sel[1]
  // D = sel[0]

  // A = (a AND b) OR (a AND c) OR ( NOT a AND NOT b AND NOT c AND d) OR (b AND NOT c AND NOT d)
  and and0(w0, sel[3], sel[2]);
  and and1(w1, sel[3], sel[1]);
  and and2(w2, ~sel[3], ~sel[2], ~sel[1], sel[0]);
  and and3(w3, sel[2], ~sel[1], ~sel[0]);
  or or0(a, w0, w1, w2, w3);

  // B = (a AND b) OR (a AND c) OR (b AND c AND NOT d) OR (b AND NOT c AND d)
  and and4(w4, sel[3], sel[2]);
  and and5(w5, sel[3], sel[1]);
  and and6(w6, sel[2], sel[1], ~sel[0]);
  and and7(w7, sel[2], ~sel[1], sel[0]);
  or or1(b, w4, w5, w6, w7);

  // C = (a AND b) OR (a AND c) OR ( NOT b AND c AND NOT d)
  and and8(w8, sel[3], sel[2]);
  and and9(w9, sel[3], sel[1]);
  and and10(w10, ~sel[2], sel[1], ~sel[0]);
  or or2(c, w8, w9, w10);

  // D = (a AND b) OR (a AND c) OR ( NOT a AND NOT b AND NOT c AND d) OR (b AND c AND d) OR (b AND NOT c AND NOT d)
  and and11(w11, sel[3], sel[2]);
  and and12(w12, sel[3], sel[1]);
  and and13(w13, ~sel[3], ~sel[2], ~sel[1], sel[0]);
  and and14(w14, sel[2], sel[1], sel[0]);
  and and15(w15, sel[2], ~sel[1], ~sel[0]);
  or or3(d, w11, w12, w13, w14, w15);

  // (a AND c) OR (b AND NOT c) OR d
  and and16(w16, sel[3], sel[1]);
  and and17(w17, sel[2], ~sel[1]);
  or or4(e, w16, w17, sel[0]);

  // (a AND b) OR ( NOT a AND NOT b AND d) OR ( NOT b AND c) OR (c AND d)
  and and18(w18, sel[3], sel[2]);
  and and19(w19, ~sel[3], ~sel[2], sel[0]);
  and and20(w20, ~sel[2], sel[1]);
  and and21(w21, sel[1], sel[0]);
  or or5(f, w18, w19, w20, w21);

  // (a AND b) OR (a AND c) OR ( NOT a AND NOT b AND NOT c) OR (b AND c AND d)
  and and22(w22, sel[3], sel[2]);
  and and23(w23, sel[3], sel[1]);
  and and24(w24, ~sel[3], ~sel[2], ~sel[1]);
  and and25(w25, sel[2], sel[1], sel[0]);
  or or6(g, w22, w23, w24, w25);

  // DP = 1
  assign dp = 1'b1;
endmodule

module TB_Decodificador_num();
  reg [3:0] sel;

  wire a, b, c, d, e, f, g, dp;

  decodificador_num decodificador_num(sel, a, b, c, d, e, f, g, dp);

  initial begin
    sel = 4'b0000; #10; // 0	0	0	0	0	0	1	1 - 0
    sel = 4'b0001; #10; // 1	0	0	1	1	1	1	1 - 1
    sel = 4'b0010; #10; // 0	0	1	0	0	1	0	1 - 2
    sel = 4'b0011; #10; // 0	0	0	0	1	1	0	1 - 3
    sel = 4'b0100; #10; // 1	0	0	1	1	0	0	1 - 4
    sel = 4'b0101; #10; // 0	1	0	0	1	0	0	1 - 5
    sel = 4'b0110; #10; // 0	1	0	0	0	0	0	1 - 6
    sel = 4'b0111; #10; // 0	0	0	1	1	1	1	1 - 7
    sel = 4'b1000; #10; // 0	0	0	0	0	0	0	1 - 8
    sel = 4'b1001; #10; // 0	0	0	0	1	0	0	1 - 9
    sel = 4'b1010; #10; // 1	1 1 1	1	1	1	1 - #
    sel = 4'b1011; #10; // 1	1 1 1	1	1	1	1 - #
    sel = 4'b1100; #10; // 1	1 1 1	1	1	1	1 - #
    sel = 4'b1101; #10; // 1	1 1 1	1	1	1	1 - #
    sel = 4'b1110; #10; // 1	1 1 1	1	1	1	1 - #
    sel = 4'b1111; #10; // 1	1 1 1	1	1	1	1 - #

    
  end
endmodule