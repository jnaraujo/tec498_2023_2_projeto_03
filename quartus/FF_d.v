module FF_d(D,clk,Q);
  input D; // Data input 
  input clk; // clock input 
  output reg Q; // output Q 

  initial begin
    Q = 1'b0;
  end

  always @(posedge clk) begin
    Q <= D; 
  end 
endmodule 

module TB_FF_d();
  reg D;
  reg clk;

  wire Q;

  FF_d FF_d0(D,clk,Q);

  initial begin
    D = 1'b0; clk = 1'b0; #10; // Q = 0
    D = 1'b0; clk = 1'b1; #10; // Q = 0
    D = 1'b1; clk = 1'b0; #10; // Q = 0
    D = 1'b1; clk = 1'b1; #10; // Q = 1
    D = 1'b0; clk = 1'b0; #10; // Q = 1
    D = 1'b0; clk = 1'b1; #10; // Q = 0
    D = 1'b1; clk = 1'b0; #10; // Q = 0
    D = 1'b1; clk = 1'b1; #10; // Q = 1
  end

endmodule