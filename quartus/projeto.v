module projeto(
  clock, start, PG, CH, RO, CQ, EB, IR,

  d0, d1, d2, d3,
  a, b, c, d, e, f, g, dp,

  PG_out, CH_out, RO_out, CQ_out, EB_out, IR_out,
  MOTOR, EV, VE, ALARME
);
  input clock, start, PG, CH, RO, CQ, EB, IR;

  output d0, d1, d2, d3; // display digits
  output a, b, c, d, e, f, g, dp; // display segments
  output PG_out, CH_out, RO_out, CQ_out, EB_out, IR_out;
  output MOTOR, EV, VE, ALARME;

  wire MOTOR_out, EV_out, VE_out, ALARME_out;
  wire [2:0] contador; // contador de 0 a 4
  wire [20:0] clock_out;
  wire [3:0] duzias_dezenas, duzias_unidades;
  wire [3:0] rolhas_dezenas, rolhas_unidades;

  divisor_freq divisor_freq(clock, clock_out);
  contador contador0(clock_out[15], contador);


  // maquina de estados principal
  // responsavel pelo funcionamento
  // da perte principal (producao)
  mef_principal mef_principal(
    clock_out[20], start,
    PG, CH, RO, CQ, EB,
    E2, E1, E0, MOTOR_out, EV_out, VE_out, ALARME_out
  );

  //////////////////////////////////
  // duzias
  //////////////////////////////////
  contador_duzias cd(clock, reset, S3, S2, S1, S0);

  contador_0_99 c_0_99_d(
    clock, i, reset, auto_repor,
    duzias_unidades[3], duzias_unidades[2], duzias_unidades[1], duzias_unidades[0],
    duzias_dezenas[3], duzias_dezenas[2], duzias_dezenas[1], duzias_dezenas[0]
  );

  //////////////////////////////////
  // rolhas
  //////////////////////////////////  
  contador_0_99 c_0_99_r(
    clock, i, reset, auto_repor,
    rolhas_unidades[3], rolhas_unidades[2], rolhas_unidades[1], rolhas_unidades[0],
    rolhas_dezenas[3], rolhas_dezenas[2], rolhas_dezenas[1], rolhas_dezenas[0]
  );

  // display
  display display(
    .contador(contador),
    .a(a), .b(b), .c(c), .d(d), .e(e), .f(f), .g(g), .dp(dp),
    .d0(d0), .d1(d1), .d2(d2), .d3(d3),
    .duzias_dezenas(duzias_dezenas), .duzias_unidades(duzias_unidades),
    .rolhas_dezenas(rolhas_dezenas), .rolhas_unidades(rolhas_unidades)
  );


  // define as saidas para
  // ser usadas posteriormente
  assign MOTOR = MOTOR_out;
  assign EV = EV_out;
  assign VE = VE_out;
  assign ALARME = ALARME_out;

  // define as saidas dos sensores
  // para mostrar nos leds
  assign PG_out = PG;
  assign CH_out = CH;
  assign RO_out = RO;
  assign CQ_out = CQ;
  assign EB_out = EB;
  assign IR_out = IR;
endmodule
