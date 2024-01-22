module mux_2x1(a, b, sel, out);
	input a, b, sel;

	output out;

	wire w0, w1;

	and and0(w0, a, ~sel);
	and and1(w1, b, sel);

	or or0(out, w0, w1);
	
endmodule

module TB_mux_2x1();
	reg a, b, sel;
	wire out;

	mux_2x1 mux_2x1(a, b, sel, out);

	initial begin
		sel = 1'b0; a = 1'b0; b = 1'b0; #10; // out = 0
		sel = 1'b0; a = 1'b0; b = 1'b1; #10; // out = 0
		sel = 1'b0; a = 1'b1; b = 1'b0; #10; // out = 1
		sel = 1'b0; a = 1'b1; b = 1'b1; #10; // out = 1
		sel = 1'b1; a = 1'b0; b = 1'b0; #10; // out = 0
		sel = 1'b1; a = 1'b0; b = 1'b1; #10; // out = 1
		sel = 1'b1; a = 1'b1; b = 1'b0; #10; // out = 0
		sel = 1'b1; a = 1'b1; b = 1'b1; #10; // out = 1
	end
endmodule