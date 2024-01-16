module contador_duzias(clock, reset, S3, S2, S1, S0);
  input clock, reset;
  output S3, S2, S1, S0;

  wire a,b,c,d;
  wire j3, k3, j2, k2, j1, k1, j0, k0;

  LEP_contador_duzias LEP_contador_duzias0(
    a,b,c,d,
    j3, k3, j2, k2, j1, k1, j0, k0
  );

  FF_jk FF_jk3(
    j3, k3, reset, 1'b0, clock, a
  );

  FF_jk FF_jk2(
    j2, k2, reset, 1'b0, clock, b
  );

  FF_jk FF_jk1(
    j1, k1, reset, 1'b0, clock, c
  );

  FF_jk FF_jk0(
    j0, k0, reset, 1'b0, clock, d
  );

  assign S3 = a;
  assign S2 = b;
  assign S1 = c;
  assign S0 = d;
endmodule

module LEP_contador_duzias(a,b,c,d, j3, k3, j2, k2, j1, k1, j0, k0);
  input a,b,c,d;
  output j3, k3, j2, k2, j1, k1, j0, k0;

  wire not_a, not_b, not_c, not_d;
  wire w0, w1, w2, w3, w4, w5;

  not not0(not_a, a);
  not not1(not_b, b);
  not not2(not_c, c);
  not not3(not_d, d);

  
  // j3 = (a, b, c, d) = a'bcd
  and and0(j3, not_a, b, c, d);

  // k3 = (a, b, c, d) = bc'd'
  and and1(k3, b, not_c, not_d);

  // j2 = (a, b, c, d) = b'cd
  and and2(j2, not_b, c, d);

  // k2 = (a, b, c, d) = a'cd + ac'd'
  and and3(w0, not_a, c, d);
  and and4(w1, a, not_c, not_d);
  or or0(k2, w0, w1);

  // j1 = (a, b, c, d) = a'd + b'd
  and and5(w2, not_a, d);
  and and6(w3, not_b, d);
  or or1(j1, w2, w3);

  // k1 = (a, b, c, d) = a'd + b'd
  and and7(w4, not_a, d);
  and and8(w5, not_b, d);
  or or2(k1, w4, w5);

  // j0 = (a, b, c, d) = a' + b'
  or or3(j0, not_a, not_b);

  // k0 = (a, b, c, d) = a' + b'
  or or4(k0, not_a, not_b);

endmodule

module TB_contador_duzias();
  reg clock, reset;
  wire S3, S2, S1, S0;

  contador_duzias contador_duzias(clock, reset, S3, S2, S1, S0);

  initial begin
    clock = 1'b0; reset = 1'b0; #10; // S = 0000
    clock = 1'b1; reset = 1'b0; #10; // S = 0001
    clock = 1'b0; reset = 1'b0; #10; // S = 0001
    clock = 1'b1; reset = 1'b0; #10; // S = 0010
    clock = 1'b0; reset = 1'b0; #10; // S = 0010
    clock = 1'b1; reset = 1'b0; #10; // S = 0011
    clock = 1'b0; reset = 1'b0; #10; // S = 0011
    clock = 1'b1; reset = 1'b0; #10; // S = 0100
    clock = 1'b0; reset = 1'b0; #10; // S = 0100
    clock = 1'b1; reset = 1'b0; #10; // S = 0101
    clock = 1'b0; reset = 1'b0; #10; // S = 0101
    clock = 1'b1; reset = 1'b0; #10; // S = 0110
    clock = 1'b0; reset = 1'b0; #10; // S = 0110
    clock = 1'b1; reset = 1'b0; #10; // S = 0111
    clock = 1'b0; reset = 1'b0; #10; // S = 0111
    clock = 1'b1; reset = 1'b0; #10; // S = 1000
    clock = 1'b0; reset = 1'b0; #10; // S = 1000
    clock = 1'b1; reset = 1'b0; #10; // S = 1001
    clock = 1'b0; reset = 1'b0; #10; // S = 1001
    clock = 1'b1; reset = 1'b0; #10; // S = 1010
    clock = 1'b0; reset = 1'b0; #10; // S = 1010
    clock = 1'b1; reset = 1'b0; #10; // S = 1011
    clock = 1'b0; reset = 1'b0; #10; // S = 1011
    clock = 1'b1; reset = 1'b0; #10; // S = 1100
    clock = 1'b0; reset = 1'b0; #10; // S = 1100
    clock = 1'b1; reset = 1'b0; #10; // S = 0000
    clock = 1'b0; reset = 1'b0; #10; // S = 0000
    clock = 1'b1; reset = 1'b0; #10; // S = 0001
    clock = 1'b0; reset = 1'b0; #10; // S = 0001

    reset = 1'b1; #10; // S = 0000
    reset = 1'b0; #10; // S = 0000

    clock = 1'b0; reset = 1'b0; #10; // S = 0000
    clock = 1'b1; reset = 1'b0; #10; // S = 0001
    clock = 1'b0; reset = 1'b0; #10; // S = 0001
    clock = 1'b1; reset = 1'b0; #10; // S = 0010
  end

endmodule