module mef_principal(
  clock, start, PG, CH, RO, CQ, EB,
  E2, E1, E0, MOTOR, EV, VE, ALARME
);
  input clock, start, PG, CH, RO, CQ, EB;
  output E2, E1, E0, MOTOR, EV, VE, ALARME;

  wire j2, k2, j1, k1, j0, k0;
  wire a, b, c, d;

  LEP_E2 LEP_E2(start, RO, CH, a, b, c, j2, k2);
  LEP_E1 LEP_E1(start, RO, CH, CQ, a, b, c, j1, k1);
  LE_E0 LE_E0(start, RO, CQ, PG, EB, a, b, c, j0, k0);

  FF_jk jk0(
    j2, k2, 1'b0, 1'b0, clock, a
  );

  FF_jk jk1(
    j1, k1, 1'b0, 1'b0, clock, b
  );

  FF_jk jk2(
    j0, k0, 1'b0, 1'b0, clock, c
  );


  EQ_Saida EQ_Saida(start, RO, CQ, PG, EB, a, b, c, MOTOR, EV, VE, ALARME);
endmodule

module LEP_E2(start, RO, CH, E2, E1, E0, j2, k2);
  input start, RO, CH, E2, E1, E0;
  output j2, k2;

  wire w0, w1, w2, w3;
  and and0(w0, start, RO, ~E2, E1, E0); // StartROE2'E1E0
  and and1(w1, start, CH, RO, ~E2, E1); // StartCHROE2'E1
  or or0(j2, w0, w1);

  and and2(w2, start, ~E1, E0); // StartE1'E0
  and and3(w3, start, E1, ~E0); // StartE1E0'
  or or1(k2, w2, w3);
endmodule

module LEP_E1(start, RO, CH, CQ, E2, E1, E0, j1, k1);
  input start, RO, CH, CQ, E2, E1, E0;
  output j1, k1;

  wire w0, w1, w2, w3, w4;

  and and0(w0, start, CQ, E2, ~E0); // StartCQE2E0'
  and and1(w1, start, PG, ~E2, E0); // StartPGE2'E0
  or or0(j1, w0, w1);

  and and2(w2, start, E2, ~E0); // StartE2E0'
  and and3(w3, start, RO, ~E2, E0); // StartROE2'E0
  and and4(w4, start, CH, RO, ~E2); // StartCHROE2'
  or or1(k1, w2, w3, w4);
endmodule

module LE_E0(start, RO, CQ, PG, EB, E2, E1, E0, j0, k0);
  input start, RO, CQ, PG, EB, E2, E1, E0;
  output j0, k0;

  wire w0, w1, w2, w3, w4, w5;

  and and0(w0, start, ~CQ, E2, ~E1); // StartCQ'E2E1'
  and and1(w1, start, ~PG, ~EB, ~E2, ~E1); // StartPG'EB'E2'E1'
  and and2(w2, start, CH, ~RO, ~E2, E1); // StartCHRO'E2'E1
  or or0(j0, w0, w1, w2);

  and and3(w3, start, E2, ~E1); // StartE2E1'
  and and4(w4, start, RO, ~E2, E1); // StartROE2'E1
  and and5(w5, start, PG, ~E1); // StartPGE1'
  or or1(k0, w3, w4, w5);
endmodule

module EQ_Saida(start, RO, CQ, PG, EB, E2, E1, E0, motor, ev, ve, alarme);
  input start, RO, CQ, PG, EB, E2, E1, E0;
  output motor, ev, ve, alarme;

  wire w0, w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11;

  and and0(w0, start, ~PG, ~EB, ~E1); // StartPG'EB'E1'
  and and1(w1, start, E2, ~E0); // StartE2E0'
  and and2(w2, start, ~PG, ~E1, E0); // StartPG'E1'E0
  and and3(w3, start, E2, ~E1); // StartE2E1'
  and and4(w4, start, RO, ~E2, E1, E0); // StartROE2'E1E0
  and and5(w5, start, CH, RO, ~E2, E1); // StartCHROE2'E1
  or or0(motor, w0, w1, w2, w3, w4, w5);

  and and6(w6, start, ~CH, ~E2, E1, ~E0); // StartCH'E2'E1E0'
  and and7(w7, start, PG, ~E2, ~E1, E0); // StartPGE2'E1'E0
  or or1(ev, w6, w7);

  and and8(w8, start, RO, ~E2, E1, E0); // StartROE2'E1E0
  and and9(w9, start, CH, RO, ~E2, E1); // StartCHROE2'E1
  or or2(ve, w8, w9);

  and and10(w10, start, ~RO, ~E2, E1, E0); // StartRO'E2'E1E0
  and and11(w11, start, CH, ~RO, ~E2, E1); // StartCHRO'E2'E1
  or or3(alarme, w10, w11);
endmodule