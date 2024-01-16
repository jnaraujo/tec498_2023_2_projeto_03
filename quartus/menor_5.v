module menor_5(a,b,c,d,S);
  input a,b,c,d;
  output S;

  wire not_a, not_b, not_c, w1, w2, w3, w4, w5;

  not not0(not_a, a);
  not not1(not_b, b);
  not not2(not_c, c);

  and and0(w1, not_a, not_b);
  and and1(w2, not_a, not_c);

  or or0(S, w1, w2);

endmodule

module TB_menor_5();
  reg a, b, c, d;
  wire s;

  menor_5 menor_5(a, b, c, d, s);

  initial begin
    a = 0; b = 0; c = 0; d = 0; #10; // S = 1
    a = 0; b = 0; c = 0; d = 1; #10; // S = 1
    a = 0; b = 0; c = 1; d = 0; #10; // S = 1
    a = 0; b = 0; c = 1; d = 1; #10; // S = 1
    a = 0; b = 1; c = 0; d = 0; #10; // S = 1
    a = 0; b = 1; c = 0; d = 1; #10; // S = 1
    a = 0; b = 1; c = 1; d = 0; #10; // S = 0
  end
endmodule
  