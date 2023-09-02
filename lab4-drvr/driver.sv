module driver#(parameter WIDTH = 8)(
	input logic  [WIDTH-1:0] data_in	,
	input logic 		 data_en	,
	output logic [WIDTH-1:0] data_out       
); 
	always_comb data_out = (data_en)? data_in : 'z;	
endmodule

