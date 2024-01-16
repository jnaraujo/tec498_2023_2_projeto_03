module FF_jk(
  j, k, reset, clock, q
);
  input j, k, clock;
  input reset;
  output q;

  reg q;

  initial begin
    q = 1'b0;
  end

  always @(posedge clock or posedge reset) begin
    if (reset) begin
      q = 1'b0;
    end else begin
      case ({j, k})
        2'b00: q = q;
        2'b01: q = 1'b0;
        2'b10: q = 1'b1;
        2'b11: q = ~q;
      endcase
    end
  end
endmodule

module TB_FF_jk();
  reg j, k, clk, reset;
  wire q;

  FF_jk FF_jk(j, k, reset, clk, q);

  initial begin
    reset = 1'b0;

    j = 1'b0; k = 1'b0; clk = 1'b0; #10; // q = 0
    j = 1'b0; k = 1'b0; clk = 1'b1; #10; // q = 0

    j = 1'b1; k = 1'b0; clk = 1'b0; #10; // q = 0
    j = 1'b1; k = 1'b0; clk = 1'b1; #10; // q = 1

    j = 1'b0; k = 1'b1; clk = 1'b0; #10; // q = 1
    j = 1'b0; k = 1'b1; clk = 1'b1; #10; // q = 0

    j = 1'b1; k = 1'b1; clk = 1'b0; #10; // q = 0
    j = 1'b1; k = 1'b1; clk = 1'b1; #10; // q = 1

    j = 1'b0; k = 1'b0; clk = 1'b0; #10; // q = 1
    j = 1'b0; k = 1'b0; clk = 1'b1; #10; // q = 1

    reset = 1'b1; #10;
    reset = 1'b0; #10;

    j = 1'b0; k = 1'b0; clk = 1'b0; #10; // q = 0
    j = 1'b0; k = 1'b0; clk = 1'b1; #10; // q = 0
  end

endmodule