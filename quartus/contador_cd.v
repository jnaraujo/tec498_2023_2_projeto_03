module contador_cd(clock, i, reset, set_2, set_5, S3, S2, S1, S0);
  input clock, i, reset, set_2, set_5;
  output S3, S2, S1, S0;

  wire a, b, c, d;
  wire j3, k3, j2, k2, j1, k1, j0, k0;

  wire reset_jk3, reset_jk2, reset_jk1, reset_jk0;

  or or0(reset_jk3, reset, set_2, set_5);
  or or1(reset_jk2, reset, set_2);
  or or2(reset_jk1, reset, set_5);
  or or3(reset_jk0, reset, set_2);

  LEP_contador_cd LEP_contador_cd0(
    i, a, b, c, d,
    j3, k3, j2, k2, j1, k1, j0, k0
  );

  FF_jk FF_jk3(
    j3, k3, reset_jk3, 1'b0, clock, a
  );

  FF_jk FF_jk2(
    j2, k2, reset_jk2, set_5, clock, b
  );

  FF_jk FF_jk1(
    j1, k1, reset_jk1, set_2, clock, c
  );

  FF_jk FF_jk0(
    j0, k0, reset_jk0, set_5, clock, d
  );

  assign S3 = a;
  assign S2 = b;
  assign S1 = c;
  assign S0 = d;
endmodule

module LEP_contador_cd(i, a, b, c, d, j3, k3, j2, k2, j1, k1, j0, k0);
  input i, a, b, c, d;
  output j3, k3, j2, k2, j1, k1, j0, k0;

  wire not_i, not_a, not_b, not_c, not_d;
  wire w0, w1, w2, w3, w4, w5, w6, w7, w8, w9;
  wire w10, w11, w12, w13, w14;

  not not0(not_i, i);
  not not1(not_a, a);
  not not2(not_b, b);
  not not3(not_c, c);
  not not4(not_d, d);
  
  // j3 = (i, a, b, c, d) = i'b'c'd' + ia'bcd
  and and0(w0, not_i, not_b, not_c, not_d);
  and and1(w1, i, not_a, b, c, d);
  or or0(j3, w0, w1);

  // k3 = (i, a, b, c, d) = i'b'c'd' + ib'c'd
  and and2(w2, not_i, not_b, not_c, not_d);
  and and3(w3, i, not_b, not_c, d);
  or or1(k3, w2, w3);

  // j2 = (i, a, b, c, d) = i'ab'c'd' + ia'cd
  and and4(w4, not_i, a, not_b, not_c, not_d);
  and and5(w5, i, not_a, c, d);
  or or2(j2, w4, w5);

  // k2 = (i, a, b, c, d) = i'a'c'd' + ia'cd
  and and6(w6, not_i, not_a, not_c, not_d);
  and and7(w7, i, not_a, c, d);
  or or3(k2, w6, w7);

  // j1 = (i, a, b, c, d) = i'a'bd' + i'ab'c'd' + ia'd
  and and8(w8, not_i, not_a, b, not_d);
  and and9(w9, not_i, a, not_b, not_c, not_d);
  and and10(w10, i, not_a, d);
  or or4(j1, w8, w9, w10);

  // k1 = (i, a, b, c, d) = i'a'd' + ia'd
  and and11(w11, not_i, not_a, not_d);
  and and12(w12, i, not_a, d);
  or or5(k1, w11, w12);

  // j0 = (i, a, b, c, d) = a' + b'c'
  and and13(w13, not_b, not_c);
  or or6(j0, not_a, w13);

  // k0 = (i, a, b, c, d) = a' + b'c'
  and and14(w14, not_b, not_c);
  or or7(k0, not_a, w14);
endmodule

module TB_contador_cd();
  reg clock, reset, set_2, set_5, i;
  wire S3, S2, S1, S0;

  contador_cd contador_cd(clock, i, reset, set_2, set_5, S3, S2, S1, S0);

  initial begin
    clock = 1'b0; i = 1'b1; reset = 1'b0; set_2 = 1'b0; set_5 = 1'b0;
    clock = 1'b0; #10; // S = 0000
    clock = 1'b1; #10; // S = 0001
    clock = 1'b0; #10; // S = 0001
    clock = 1'b1; #10; // S = 0010
    clock = 1'b0; #10; // S = 0010
    clock = 1'b1; #10; // S = 0011
    clock = 1'b0; #10; // S = 0011
    clock = 1'b1; #10; // S = 0100
    clock = 1'b0; #10; // S = 0100
    clock = 1'b1; #10; // S = 0101
    clock = 1'b0; #10; // S = 0101
    clock = 1'b1; #10; // S = 0110
    clock = 1'b0; #10; // S = 0110
    clock = 1'b1; #10; // S = 0111
    clock = 1'b0; #10; // S = 0111
    clock = 1'b1; #10; // S = 1000
    clock = 1'b0; #10; // S = 1000
    clock = 1'b1; #10; // S = 1001
    clock = 1'b0; #10; // S = 1001
    clock = 1'b1; #10; // S = 0000
    clock = 1'b0; #10; // S = 0000
    clock = 1'b1; #10; // S = 0001
    clock = 1'b0; #10; // S = 0001

    reset = 1'b1; #10; // S = 0000
    reset = 1'b0; #10; // S = 0000

    clock = 1'b0; #10; // S = 0000
    clock = 1'b1; #10; // S = 0001
    clock = 1'b0; #10; // S = 0001
    clock = 1'b1; #10; // S = 0010

    reset = 1'b1; #10; // S = 0000
    reset = 1'b0; #10; // S = 0000

    set_2 = 1'b1; #10; // S = 0010
    set_2 = 1'b0; #10; // S = 0010
    
    clock = 1'b0; #10; // S = 0010
    clock = 1'b1; #10; // S = 0011

    reset = 1'b1; #10; // S = 0000
    reset = 1'b0; #10; // S = 0000

    set_5 = 1'b1; #10; // S = 0101
    set_5 = 1'b0; #10; // S = 0101

    clock = 1'b0; #10; // S = 0101
    clock = 1'b1; #10; // S = 0110

    // teste decremento
    i = 1'b0; #10; // S = 0110
    clock = 1'b0; #10; // S = 0110
    clock = 1'b1; #10; // S = 0101
    clock = 1'b0; #10; // S = 0101
    clock = 1'b1; #10; // S = 0100
    clock = 1'b0; #10; // S = 0100
    clock = 1'b1; #10; // S = 0011
    clock = 1'b0; #10; // S = 0011
    clock = 1'b1; #10; // S = 0010
  end
endmodule