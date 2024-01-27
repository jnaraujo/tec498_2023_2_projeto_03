module projeto(
  clock, start, PG, CH, RO, CQ, EB, IR,
  incrementar_btn,

  d0, d1, d2, d3,
  a, b, c, d, e, f, g, dp,

  PG_out, CH_out, RO_out, CQ_out, EB_out, IR_out,
  MOTOR, EV, VE, ALARME
);
  input clock, start, PG, CH, RO, CQ, EB, IR;
  input incrementar_btn;

  output d0, d1, d2, d3; // display digits
  output a, b, c, d, e, f, g, dp; // display segments
  output PG_out, CH_out, RO_out, CQ_out, EB_out, IR_out;
  output MOTOR, EV, VE, ALARME;

  wire MOTOR_out, EV_out, VE_out, ALARME_out;
  wire [2:0] contador; // contador de 0 a 4
  wire [20:0] clock_out;
  wire [3:0] duzias_dezenas, duzias_unidades;
  wire [3:0] rolhas_dezenas, rolhas_unidades;
  wire [3:0] cont_duzias;
  wire cont_duzias_eh_12, cont_tem_10_duzias;
  wire reset_contador_duzias, incrementar_cont_rolhas;
  wire incrementar, clock_cont_rolhas;
  wire E2, E1, E0;

  divisor_freq divisor_freq(clock, clock_out);
  contador contador0(clock_out[15], contador);

  level_to_pulse ltp(~incrementar_btn, clock_out[15], incrementar); // remove o ruido do botao

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
  contador_duzias cd(clock, cont_duzias_eh_12, cont_duzias[3], cont_duzias[2], cont_duzias[1], cont_duzias[0]);

  and and_duzias(cont_duzias_eh_12, cont_duzias[3], cont_duzias[2], ~cont_duzias[1], ~cont_duzias[0]); // eh 12

  contador_0_99 c_0_99_d(
    cont_duzias_eh_12, // clock
    1'b1, // incrementar
    reset_contador_duzias, // reset
    1'b0, // auto_repor
    duzias_unidades[3], duzias_unidades[2], duzias_unidades[1], duzias_unidades[0],
    duzias_dezenas[3], duzias_dezenas[2], duzias_dezenas[1], duzias_dezenas[0]
  );

  and and_tem_10_duzias(cont_tem_10_duzias, ~duzias_dezenas[3], ~duzias_dezenas[2], ~duzias_dezenas[1], duzias_dezenas[0], ~duzias_unidades[3], ~duzias_unidades[2], ~duzias_unidades[1], duzias_unidades[0]); // tem 10 duzias

  or or_reset_contador_duzias(reset_contador_duzias, cont_tem_10_duzias); // reset contador duzias 

  //////////////////////////////////
  // rolhas
  //////////////////////////////////  

  or or_clock_cont_rolhas(clock_cont_rolhas, VE_out, incrementar);
  or or_incrementar_cont_rolhas(incrementar_cont_rolhas, incrementar, VE_out); // incrementar contador rolhas

  contador_0_99 c_0_99_r(
    clock_cont_rolhas, // clock
    incrementar_cont_rolhas, // incrementar
    1'b0, // reset
    1'b1, // auto_repor
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
