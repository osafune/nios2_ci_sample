// ===================================================================
// TITLE : Xorshift128 random instruction for NiosII
//
//     DESIGN : s.osafune@j7system.jp (J-7SYSTEM WORKS LIMITED)
//     DATE   : 2020/11/01 -> 2020/11/01
//
// ===================================================================
//
// The MIT License (MIT)
// Copyright (c) 2020 J-7SYSTEM WORKS LIMITED.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of
// this software and associated documentation files (the "Software"), to deal in
// the Software without restriction, including without limitation the rights to
// use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
// of the Software, and to permit persons to whom the Software is furnished to do
// so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

// Verilog-2001 / IEEE 1364-2001
`default_nettype none

module ci_rand_xorshift128(
	input wire			clk,
	input wire			clk_en,
	input wire			reset,
	output wire [31:0]	result
);

	reg  [31:0]		x_reg, y_reg, z_reg, w_reg;
	wire [31:0]		t_sig, r_sig;

	assign t_sig = x_reg ^ {x_reg[20:0], {11{1'b0}}};
	assign r_sig = (w_reg ^ {{19{1'b0}}, w_reg[31:19]}) ^ (t_sig ^ {{8{1'b0}}, t_sig[31:8]});

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			x_reg <= 32'd123456789;
			y_reg <= 32'd362436069;
			z_reg <= 32'd521288629;
			w_reg <= 32'd88675123;
		end
		else begin
			if (clk_en) begin
				x_reg <= y_reg;
				y_reg <= z_reg;
				z_reg <= w_reg;
				w_reg <= r_sig;
			end
		end
	end

	assign result = w_reg;

endmodule
