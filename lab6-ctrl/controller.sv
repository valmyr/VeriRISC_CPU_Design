module controller
(
	input logic		zero	,
				clk	,
				rst	,
	input logic	[2:0] 	opcode	,
				phase	,
	output logic 		sel	,
				rd	,
				ld_ir	,
				halt	,
				ld_ac	,
				wr	,
				inc_pc	,
				ld_pc	,
				data_e	
);
	

	enum {
		INST_ADDR=0	,
		INST_FETCH	,
		INST_LOAD	,
		IDLE		,
		OP_ADDR		,
		OP_FETCH	,
		ALU_OP		,
		STORE		
	} states;
	
	enum {
		HLT=0		,
		SKZ		,
		ADD		,
		AND		,
		XOR		,
		LDA		,
		STO		,
		JMP		
	} opcode_instruction;

	logic HALT, ALUOP, SKZ_, JMP_;

       

	assign HALT  = opcode == HLT ;
	assign ALUOP = opcode == ADD | 
		       opcode == AND |
		       opcode == XOR |
		       opcode == LDA ;
	assign SKZ_  = opcode == SKZ ;
	assign JMP_  = opcode == JMP ;
	assign STO_  = opcode == STO ;
	always_comb case(phase)
		INST_ADDR	: {sel,rd,ld_ir,halt,inc_pc,ld_ac,ld_pc,wr,data_e} = 9'b100000000		 	;	
	      	INST_FETCH	: {sel,rd,ld_ir,halt,inc_pc,ld_ac,ld_pc,wr,data_e} = 9'b110000000	 	 	;		
		INST_LOAD	: {sel,rd,ld_ir,halt,inc_pc,ld_ac,ld_pc,wr,data_e} = 9'b111000000		 	;
		IDLE 		: {sel,rd,ld_ir,halt,inc_pc,ld_ac,ld_pc,wr,data_e} = 9'b111000000	 	 	;
		OP_ADDR		: {sel,rd,ld_ir,halt,inc_pc,ld_ac,ld_pc,wr,data_e} = 9'b000010000 | (HALT  << 5	 )	;
		OP_FETCH	: {sel,rd,ld_ir,halt,inc_pc,ld_ac,ld_pc,wr,data_e} = 9'b000000000 | (ALUOP << 7  )	;
		ALU_OP		: {sel,rd,ld_ir,halt,inc_pc,ld_ac,ld_pc,wr,data_e} = 9'b000000000 | (ALUOP << 7	 )   	
												  | (SKZ_ && zero) << 4
												  | (JMP_  << 2  )
												  | (STO_        )	;
		STORE 		: {sel,rd,ld_ir,halt,inc_pc,ld_ac,ld_pc,wr,data_e} = 9'b000000000 | (ALUOP << 7  ) 
												  | (ALUOP << 3  )
												  | (JMP_  << 2  ) 
												  | (STO_  << 1  )
												  | (STO_        )	;

	  endcase
endmodule	
