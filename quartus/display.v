module display(
  contador,
  duzias_dezenas, duzias_unidades,
  rolhas_dezenas, rolhas_unidades,
  ligado,

  a, b, c, d, e, f, g, dp,
  d0, d1, d2, d3
);
  input [1:0] contador;
  input [3:0] duzias_dezenas, duzias_unidades;
  input [3:0] rolhas_dezenas, rolhas_unidades;
  input ligado;

  output a, b, c, d, e, f, g, dp;
  output d0, d1, d2, d3;

  wire d0_t, d1_t, d2_t, d3_t;
  wire [8:0] saida_d0, saida_d1, saida_d2, saida_d3; // saida intermediaria
  wire [8:0] saida_d0_f, saida_d1_f, saida_d2_f, saida_d3_f; // saida final

  demux_1x4 demux0(.Sel(contador), .E(ligado), .Out4(d0_t), .Out3(d1_t), .Out2(d2_t), .Out1(d3_t)); // define qual digito sera mostrado

  // a cpld funciona com logica negada para os displays
  assign d0 = ~d0_t;
  assign d1 = ~d1_t;
  assign d2 = ~d2_t;
  assign d3 = ~d3_t;

  decodificador_num dn0(
    {duzias_dezenas[3], duzias_dezenas[2], duzias_dezenas[1], duzias_dezenas[0]},
    saida_d0[7], saida_d0[6], saida_d0[5], saida_d0[4], saida_d0[3], saida_d0[2], saida_d0[1], saida_d0[0],
  );

  decodificador_num dn1(
    {duzias_unidades[3], duzias_unidades[2], duzias_unidades[1], duzias_unidades[0]},
    saida_d1[7], saida_d1[6], saida_d1[5], saida_d1[4], saida_d1[3], saida_d1[2], saida_d1[1], saida_d1[0],
  );

  decodificador_num dn2(
    {rolhas_dezenas[3], rolhas_dezenas[2], rolhas_dezenas[1], rolhas_dezenas[0]},
    saida_d2[7], saida_d2[6], saida_d2[5], saida_d2[4], saida_d2[3], saida_d2[2], saida_d2[1], saida_d2[0],
  );

  decodificador_num dn3(
    {rolhas_unidades[3], rolhas_unidades[2], rolhas_unidades[1], rolhas_unidades[0]},
    saida_d3[7], saida_d3[6], saida_d3[5], saida_d3[4], saida_d3[3], saida_d3[2], saida_d3[1], saida_d3[0],
  );

  mux_16x8 m0(
    8'b11111111,
    saida_d0,
    ligado,
    saida_d0_f
  );

  mux_16x8 m1(
    8'b11111111,
    saida_d1,
    ligado,
    saida_d1_f
  );

  mux_16x8 m2(
    8'b11111111,
    saida_d2,
    ligado,
    saida_d2_f
  );

  mux_16x8 m3(
    8'b11111111,
    saida_d3,
    ligado,
    saida_d3_f
  );

  // mux da saida dos segmentos
  mux_32x8 m4(
    saida_d0_f, saida_d1_f, saida_d2_f, saida_d3_f,
    contador,
    {a, b, c, d, e, f, g, dp}
  );
endmodule