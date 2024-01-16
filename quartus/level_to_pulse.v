/*
  Módulo para reduzir o ruído de um sinal de entrada.
*/
module level_to_pulse(
    input ruido,
    input clk,
    output sem_ruido
);
  wire FFD1; 
  wire FFD2;
	 
	wire w0;
	 
	and and0(w0, FFD1, ruido);
	 
	FF_d d0(ruido, clk, FFD1);
	FF_d d1(w0, clk, FFD2);
  
  wire aneg;
  not ( aneg, FFD2);
  and (sem_ruido, FFD1, aneg);
endmodule