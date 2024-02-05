module projeto(
  clock, start, PG, CH, RO, CQ, EB, IR,

  d0, d1, d2, d3,
  a, b, c, d, e, f, g, dp,

  start_out, PG_out, CH_out, RO_out, CQ_out, EB_out, IR_out,
  ir_clock,
  btn_1,
  col_out,
  MOTOR, EV, VE, ALARME,
  
  e2_out, e1_out, e0_out
);
  input clock, start, PG, CH, RO, CQ, EB, IR;
  input btn_1, ir_clock;

  output d0, d1, d2, d3; // display digits
  output a, b, c, d, e, f, g, dp; // display segments
  output PG_out, CH_out, RO_out, CQ_out, EB_out, IR_out;
  output MOTOR, EV, VE, ALARME;
  output start_out, col_out;
  output e2_out, e1_out, e0_out;

  wire MOTOR_out, EV_out, VE_out, ALARME_out;
  wire [2:0] contador; // contador de 0 a 4
  wire [20:0] clock_out;
  wire [3:0] duzias_dezenas, duzias_unidades;
  wire [3:0] rolhas_dezenas, rolhas_unidades;
  wire [3:0] cont_duzias;
  wire enabled, start_ltp;
  wire cont_duzias_eh_12, cont_tem_10_duzias;
  wire reset_contador_duzias, incrementar_cont_rolhas;
  wire incrementar, clock_cont_rolhas;
  wire E2, E1, E0;
  wire clock_btn;

  divisor_freq divisor_freq(clock, clock_out);
  contador contador0(clock_out[15], contador);

  level_to_pulse ltp(~ir_clock, clock_out[15], incrementar); // remove o ruido do botao
  level_to_pulse ltp_start(~start, clock_out[15], start_ltp); // remove o ruido do botao
  level_to_pulse(~btn_1, clock_out[15], clock_btn);

  // inverte o enabled sempre que o botao de start for pressionado
  FF_jk FF_jk_enable(
    1'b1, 1'b1, 1'b0, 1'b0, start_ltp, enabled
  );

  // maquina de estados principal
  // responsavel pelo funcionamento
  // da perte principal (producao)
  mef_principal mef_principal(
    clock_btn, start,
    PG, CH, RO, CQ, EB,
    E2, E1, E0, MOTOR_out, EV_out, VE_out, ALARME_out
  );

  //////////////////////////////////
  // duzias
  //////////////////////////////////
  contador_duzias cd(VE_out, cont_duzias_eh_12, cont_duzias[3], cont_duzias[2], cont_duzias[1], cont_duzias[0]);

  and and_duzias(cont_duzias_eh_12, cont_duzias[3], cont_duzias[2], ~cont_duzias[1], ~cont_duzias[0]); // eh 12

  contador_0_99 c_0_99_d(
    .clock(cont_duzias_eh_12), .inc(1'b1),
    .reset(reset_contador_duzias), .auto_repor(1'b0),
    .reset_no_99(1'b0),
    .M3(duzias_unidades[3]), .M2(duzias_unidades[2]), .M1(duzias_unidades[1]), .M0(duzias_unidades[0]),
    .S3(duzias_dezenas[3]), .S2(duzias_dezenas[2]), .S1(duzias_dezenas[1]), .S0(duzias_dezenas[0])
  );

  and and_tem_10_duzias(cont_tem_10_duzias, ~duzias_dezenas[3], ~duzias_dezenas[2], ~duzias_dezenas[1], duzias_dezenas[0], ~duzias_unidades[3], ~duzias_unidades[2], ~duzias_unidades[1], duzias_unidades[0]); // tem 10 duzias

  or or_reset_contador_duzias(reset_contador_duzias, cont_tem_10_duzias); // reset contador duzias 

  //////////////////////////////////
  // rolhas
  //////////////////////////////////

  contador_0_99 c_0_99_r(
  .clock((incrementar && IR) || VE_out), .inc(IR),
  .reset(1'b0), .auto_repor(1'b1),
  .reset_no_99(1'b0),
  .M3(rolhas_unidades[3]), .M2(rolhas_unidades[2]), .M1(rolhas_unidades[1]), .M0(rolhas_unidades[0]),
  .S3(rolhas_dezenas[3]), .S2(rolhas_dezenas[2]), .S1(rolhas_dezenas[1]), .S0(rolhas_dezenas[0])
  );

  // display
  display display(
    .contador(contador),
    .duzias_dezenas(duzias_dezenas), .duzias_unidades(duzias_unidades),
    .rolhas_dezenas(rolhas_dezenas), .rolhas_unidades(rolhas_unidades),
    .ligado(enabled),
    .a(a), .b(b), .c(c), .d(d), .e(e), .f(f), .g(g), .dp(dp),
    .d0(d0), .d1(d1), .d2(d2), .d3(d3)
  );

  // define as saidas para
  // ser usadas posteriormente
  assign MOTOR = MOTOR_out;
  assign EV = EV_out;
  assign VE = VE_out;
  assign ALARME = ALARME_out;

  // define as saidas dos sensores
  // para mostrar nos leds
  assign PG_out = ~PG;
  assign CH_out = ~CH;
  assign RO_out = ~RO;
  assign CQ_out = ~CQ;
  assign EB_out = ~EB;
  assign IR_out = ~IR;
  assign start_out = ~enabled;
  assign col_out = 1'b1;
  
  assign e2_out = E2;
  assign e1_out = E1;
  assign e0_out = E0;
endmodule
