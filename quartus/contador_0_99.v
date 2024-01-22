module contador_0_99(
  clock, i, reset, auto_repor,
  M3, M2, M1, M0, S3, S2, S1, S0
  );
  input clock, reset, auto_repor, i;
  output M3, M2, M1, M0, S3, S2, S1, S0;

  wire clock_ccd, clock_ccd_d;
  wire u_S3, u_S2, u_S1, u_S0;
  wire d_S3, d_S2, d_S1, d_S0;
  wire eh_noventa_nove, repor;
  wire u_menor_5, d_zero;

  and and0(clock_ccd, clock, ~eh_noventa_nove);
  contador_cd ccd_u(clock_ccd, i, reset, 1'b0, repor, u_S3, u_S2, u_S1, u_S0); // unidades

  contador_cd ccd_d(clock_ccd_d, i, reset, repor, 1'b0, d_S3, d_S2, d_S1, d_S0); // dezenas

  mux_2x1 mux_2x1(u_S3, ~u_S3, i, clock_ccd_d);

  eh_nove eh_nove(u_S3 & d_S3, u_S2 & d_S2, u_S1 & d_S1, u_S0 & d_S0, eh_noventa_nove);

  and and1(d_zero, ~d_S3, ~d_S2, ~d_S1, ~d_S0); // dezena eh zero
  menor_5 menor_5(u_S3, u_S2, u_S1, u_S0, u_menor_5); // unidades eh menor que 5

  and and2(repor, d_zero, u_menor_5, auto_repor); // repor = dezena eh zero e unidades eh menor que 5 e auto_repor

  assign M3 = u_S3;
  assign M2 = u_S2;
  assign M1 = u_S1;
  assign M0 = u_S0;

  assign S3 = d_S3;
  assign S2 = d_S2;
  assign S1 = d_S1;
  assign S0 = d_S0;
endmodule

module TB_contador_0_99();
  reg clock, reset, auto_repor, i;
  wire M3, M2, M1, M0, S3, S2, S1, S0;

  contador_0_99 contador_0_99(clock, i, reset, auto_repor, M3, M2, M1, M0, S3, S2, S1, S0);

  initial begin
    i = 1; clock = 0; reset = 0; auto_repor = 0; #10; // M = 0000 S = 0000
    i = 1; clock = 1; reset = 0; auto_repor = 0; #10; // M = 0001 S = 0000
    i = 1; clock = 0; reset = 0; auto_repor = 0; #10; // M = 0001 S = 0000
    i = 1; clock = 1; reset = 0; auto_repor = 0; #10; // M = 0010 S = 0000
    i = 1; clock = 0; reset = 0; auto_repor = 0; #10; // M = 0010 S = 0000
    i = 1; clock = 1; reset = 0; auto_repor = 0; #10; // M = 0011 S = 0000
    i = 1; clock = 0; reset = 0; auto_repor = 0; #10; // M = 0011 S = 0000
    i = 1; clock = 1; reset = 0; auto_repor = 0; #10; // M = 0100 S = 0000
    i = 1; clock = 0; reset = 0; auto_repor = 0; #10; // M = 0100 S = 0000
    i = 1; clock = 1; reset = 0; auto_repor = 0; #10; // M = 0101 S = 0000
    i = 1; clock = 0; reset = 0; auto_repor = 0; #10; // M = 0101 S = 0000
    i = 1; clock = 1; reset = 0; auto_repor = 0; #10; // M = 0110 S = 0000
    i = 1; clock = 0; reset = 0; auto_repor = 0; #10; // M = 0110 S = 0000
    i = 1; clock = 1; reset = 0; auto_repor = 0; #10; // M = 0111 S = 0000
    i = 1; clock = 0; reset = 0; auto_repor = 0; #10; // M = 0111 S = 0000
    i = 1; clock = 1; reset = 0; auto_repor = 0; #10; // M = 1000 S = 0000
    i = 1; clock = 0; reset = 0; auto_repor = 0; #10; // M = 1000 S = 0000
    i = 1; clock = 1; reset = 0; auto_repor = 0; #10; // M = 1001 S = 0000
    i = 1; clock = 0; reset = 0; auto_repor = 0; #10; // M = 1001 S = 0000
    i = 1; clock = 1; reset = 0; auto_repor = 0; #10; // M = 0000 S = 0001
    i = 1; clock = 0; reset = 0; auto_repor = 0; #10; // M = 0000 S = 0001
    i = 1; clock = 1; reset = 0; auto_repor = 0; #10; // M = 0001 S = 0001
    i = 1; clock = 0; reset = 0; auto_repor = 0; #10; // M = 0001 S = 0001
    i = 1; clock = 1; reset = 0; auto_repor = 0; #10; // M = 0010 S = 0001
    // decrementa
    i = 0; clock = 0; reset = 0; auto_repor = 0; #10; // M = 0010 S = 0001
    i = 0; clock = 1; reset = 0; auto_repor = 0; #10; // M = 0001 S = 0001
    i = 0; clock = 0; reset = 0; auto_repor = 0; #10; // M = 0001 S = 0001
    i = 0; clock = 1; reset = 0; auto_repor = 0; #10; // M = 0000 S = 0001
    i = 0; clock = 0; reset = 0; auto_repor = 0; #10; // M = 0000 S = 0001
    i = 0; clock = 1; reset = 0; auto_repor = 0; #10; // M = 1001 S = 0000
    i = 0; clock = 0; reset = 0; auto_repor = 0; #10; // M = 1001 S = 0000
    i = 0; clock = 1; reset = 0; auto_repor = 0; #10; // M = 1000 S = 0000

    // reset
    i = 1; clock = 0; reset = 1; auto_repor = 0; #10; // M = 0000 S = 0000
    i = 1; clock = 1; reset = 0; auto_repor = 0; #10; // M = 0000 S = 0000
    i = 1; clock = 0; reset = 0; auto_repor = 0; #10; // M = 0000 S = 0000
    i = 1; clock = 1; reset = 0; auto_repor = 0; #10; // M = 0001 S = 0000

    // auto_repor

    i = 1; clock = 0; reset = 0; auto_repor = 1; #10; // M = 0001 S = 0000
    i = 1; clock = 1; reset = 0; auto_repor = 1; #10; // M = 0101 S = 0010
  end

endmodule