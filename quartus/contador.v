module contador(clock, S);
	input clock;
	output [2:0] S;

	wire [2:0] curr, next;

	controle controle(next, curr);

	FF_d d0(curr[0], clock, next[0]);
	FF_d d1(curr[1], clock, next[1]);
	FF_d d2(curr[2], clock, next[2]);

	assign S = next;
endmodule

module controle(E, S);
	input [2:0] E;
	output [2:0] S;

	wire w0, w1;

	// NOT a AND b AND c
	and and0(S[2], ~E[2], E[1], E[0]);

	// ( NOT a AND b AND NOT c) OR ( NOT a AND NOT b AND c)
	and and1(w0, ~E[2], E[1], ~E[0]);
	and and2(w1, ~E[2], ~E[1], E[0]);

	or or0(S[1], w0, w1);

	// NOT a AND NOT c
	and and3(S[0], ~E[2], ~E[0]);

endmodule

module TB_contador;
	reg clock;
	wire [2:0] S;

	contador contador(clock, S);

	initial begin
		clock = 1'b0; #10; // S = 000
		clock = 1'b1; #10; // S = 001
		clock = 1'b0; #10; // S = 001
		clock = 1'b1; #10; // S = 010
		clock = 1'b0; #10; // S = 010
		clock = 1'b1; #10; // S = 011
		clock = 1'b0; #10; // S = 011
		clock = 1'b1; #10; // S = 100
		clock = 1'b0; #10; // S = 100
		clock = 1'b1; #10; // S = 000
		clock = 1'b0; #10; // S = 000
		clock = 1'b1; #10; // S = 001
		clock = 1'b0; #10; // S = 001
		clock = 1'b1; #10; // S = 010
		clock = 1'b0; #10; // S = 010
		clock = 1'b1; #10; // S = 011
		clock = 1'b0; #10; // S = 011
		clock = 1'b1; #10; // S = 100
	end
endmodule