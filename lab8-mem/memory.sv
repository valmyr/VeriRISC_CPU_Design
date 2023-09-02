module memory #(
	parameter DWIDTH = 8,
	parameter AWIDTH = 5
)
(
	input logic		  clk	,
				  wr	,
			      	  rd	,
	input logic  [AWIDTH-1:0] addr	,
	inout logic  [DWIDTH-1:0] data	
);

	logic [7:0] memory [32];
	always_ff@(posedge clk)begin
		 memory[addr] <=  wr ? data : memory[addr];
	end
	assign data = rd ? memory[addr] : 'z;

endmodule
