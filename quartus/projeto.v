module projeto(
  clock, start, PG, CH, RO, CQ, EB, IR
);
  input clock, start, PG, CH, RO, CQ, EB, IR;

  // duzias
  contador_duzias cd(clock, reset, S3, S2, S1, S0);

  contador_0_99 c_0_99_d(
    clock, i, reset, auto_repor,
    M3, M2, M1, M0, S3, S2, S1, S0
  );

  decodificador_num d_num_u_d(
    sel,
    a, b, c, d, e, f, g, dp
  );

  decodificador_num d_num_d_d(
    sel,
    a, b, c, d, e, f, g, dp
  );

  //////////////////////////////////
  // rolhas

  contador_0_99 c_0_99_r(
    clock, i, reset, auto_repor,
    M3, M2, M1, M0, S3, S2, S1, S0
  );

  decodificador_num d_num_u_r(
    sel,
    a, b, c, d, e, f, g, dp
  );

  decodificador_num d_num_d_r(
    sel,
    a, b, c, d, e, f, g, dp
  );
endmodule
