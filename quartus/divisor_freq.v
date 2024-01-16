// Divisor de frequência de 50MHz para aproximadamente 1525Hz
module divisor_freq(clock_in, clock_out);
  input clock_in;
  output [15:0] clock_out;

  wire [15:0] clock_out_temp;

  FF_jk FF_jk1(1'b1, 1'b1, 1'b0, clock_in, clock_out_temp[0]);
  FF_jk FF_jk2(1'b1, 1'b1, 1'b0, clock_out_temp[0], clock_out_temp[1]);
  FF_jk FF_jk3(1'b1, 1'b1, 1'b0, clock_out_temp[1], clock_out_temp[2]);
  FF_jk FF_jk4(1'b1, 1'b1, 1'b0, clock_out_temp[2], clock_out_temp[3]);
  FF_jk FF_jk5(1'b1, 1'b1, 1'b0, clock_out_temp[3], clock_out_temp[4]);
  FF_jk FF_jk6(1'b1, 1'b1, 1'b0, clock_out_temp[4], clock_out_temp[5]);
  FF_jk FF_jk7(1'b1, 1'b1, 1'b0, clock_out_temp[5], clock_out_temp[6]);
  FF_jk FF_jk8(1'b1, 1'b1, 1'b0, clock_out_temp[6], clock_out_temp[7]);
  FF_jk FF_jk9(1'b1, 1'b1, 1'b0, clock_out_temp[7], clock_out_temp[8]);
  FF_jk FF_jk10(1'b1, 1'b1, 1'b0, clock_out_temp[8], clock_out_temp[9]);
  FF_jk FF_jk11(1'b1, 1'b1, 1'b0, clock_out_temp[9], clock_out_temp[10]);
  FF_jk FF_jk12(1'b1, 1'b1, 1'b0, clock_out_temp[10], clock_out_temp[11]);
  FF_jk FF_jk13(1'b1, 1'b1, 1'b0, clock_out_temp[11], clock_out_temp[12]);
  FF_jk FF_jk14(1'b1, 1'b1, 1'b0, clock_out_temp[12], clock_out_temp[13]);
  FF_jk FF_jk15(1'b1, 1'b1, 1'b0, clock_out_temp[13], clock_out_temp[14]);
  FF_jk FF_jk16(1'b1, 1'b1, 1'b0, clock_out_temp[14], clock_out_temp[15]);
  
  assign clock_out = clock_out_temp;  
endmodule

`timescale 1ns / 1ps // define a escala de tempo
module TB_DivisorFreq();
  reg clock_in;
  wire [15:0] clock_out;

  divisor_freq divisor_freq(clock_in, clock_out);

  initial begin
    clock_in = 1'b0;
    forever #10 clock_in = ~clock_in;
  end

endmodule