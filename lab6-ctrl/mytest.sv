module tb();
	

	logic 	zero	,
		phase	,
		reset	,
		clk	;
	logic [2:0] opcode;
	controller ctrl_inst
	(
		.reset	(	reset	),
		.clk	( 	clk	),
		.phase	(	phase	),
		.opcode	(	opcode	),
		.zero	(	zero	)				
	);
	initial #40 $finish;
	initial@(negedge clk)begin
		 #1reset = 1;
		 #1 reset = 0;
		 opcode = 0;
		 phase = 0;
	 end
	always begin #1  clk = 0;
		     #1	clk = ~clk;
	end

	initial $monitor("%d, %b",ctrl_inst.state_current, {ctrl_inst.sel,ctrl_inst.rd,ctrl_inst.ld_ir});
endmodule
