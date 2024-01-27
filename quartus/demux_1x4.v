module demux_1x4(Sel, E, Out4, Out3, Out2, Out1);
	input [1:0] Sel;
	input E;
	output Out1, Out2, Out3, Out4;

	wire W0, W1, W2, W3;

	demux_1x2 d0(.Sel(Sel[1]), .E(E), .Out2(W0), .Out1(W1));

	demux_1x2 d2(.Sel(Sel[0]), .E(W0), .Out2(Out4), .Out1(Out3));
	demux_1x2 d1(.Sel(Sel[0]), .E(W1), .Out2(Out2), .Out1(Out1));

endmodule

module TB_demux_1x4();
	reg [1:0] Sel;
	reg E;

	wire Out1, Out2, Out3, Out4;

	demux_1x4 demux_1x4(Sel, E, Out4, Out3, Out2, Out1);

	initial begin
		Sel = 2'b00; E = 1'b1; #10; // Out1 = 1, Out2 = 0, Out3 = 0, Out4 = 0
		Sel = 2'b01; E = 1'b1; #10; // Out1 = 0, Out2 = 1, Out3 = 0, Out4 = 0
		Sel = 2'b10; E = 1'b1; #10; // Out1 = 0, Out2 = 0, Out3 = 1, Out4 = 0
		Sel = 2'b11; E = 1'b1; #10; // Out1 = 0, Out2 = 0, Out3 = 0, Out4 = 1

		Sel = 2'b00; E = 1'b0; #10; // Out1 = 0, Out2 = 0, Out3 = 0, Out4 = 0
		Sel = 2'b01; E = 1'b0; #10; // Out1 = 0, Out2 = 0, Out3 = 0, Out4 = 0
		Sel = 2'b10; E = 1'b0; #10; // Out1 = 0, Out2 = 0, Out3 = 0, Out4 = 0
		Sel = 2'b11; E = 1'b0; #10; // Out1 = 0, Out2 = 0, Out3 = 0, Out4 = 0
	end
endmodule