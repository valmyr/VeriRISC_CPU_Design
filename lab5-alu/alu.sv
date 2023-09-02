module alu#(parameter WIDTH = 8)(
	input logic [3:0] 	 opcode		,
	input logic [WIDTH-1:0]  in_a		, 
				 in_b		,
	output logic [WIDTH-1:0] alu_out 	,
	output logic 		 a_is_zero	

);
	enum {HLT,SKZ,ADD,AND,XOR,LDA,STO,JMP} instruction;
	always_comb case(opcode)
		HLT: alu_out = in_a;
		SKZ: alu_out = in_a;
		ADD: alu_out = in_a + in_b;
		AND: alu_out = in_a & in_b;
		XOR: alu_out = in_a ^ in_b;
		LDA: alu_out = in_b;
		STO: alu_out = in_a;
		JMP: alu_out = in_a;		
	endcase
	assign a_is_zero = alu_out == 0;
endmodule
