`default_nettype none

module de0nano_top (
	input wire			CLOCK_50,
	input wire [1:0]	KEY
);

	nios2_ci_core u_core (
		.clk_clk       (CLOCK_50),
		.reset_reset_n (KEY[0])
	);

endmodule
