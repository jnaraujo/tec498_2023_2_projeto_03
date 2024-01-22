module eh_nove(a, b, c, d, s);
  input a, b, c, d;
  output s;

  and and0(s, a, ~b, ~c, d);
endmodule