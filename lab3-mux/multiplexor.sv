module multiplexor #(parameter WIDTH =5)(
    input logic 		sel,
    input logic  [WIDTH-1:0]	in0,
   				in1,
    output logic [WIDTH-1:0]    mux_out
);
	always_comb mux_out = (sel) ? in1 : in0;
endmodule
