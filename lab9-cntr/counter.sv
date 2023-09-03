module counter#(parameter WITDH = 5)
(
	input logic 		 clk	,
				 load	,
			 	 rst	,
			    	 enab	,
	input logic  [WITDH-1:0] cnt_in	,
	output logic [WITDH-1:0] cnt_out
);
	
	always@(posedge clk)
		if(rst)
			cnt_out <= 0;
		else if(load)
			cnt_out <= cnt_in;
		else 	cnt_out <= enab ? cnt_out + 1: cnt_out;
endmodule
