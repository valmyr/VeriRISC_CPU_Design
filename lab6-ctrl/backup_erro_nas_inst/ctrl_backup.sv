module controller(
		input logic 		zero,
			    		phase,
			    	 	clk,
					reset,
		input logic [2:0] 	opcode,
		output logic		sel,
					rd,
					ld_ir,
					halt,
					inc_pc,
					ld_ac,
					wr,
					ld_pc,
					data_e
);
	enum {INST_ADDR_=0,INST_FETCH_=1,INST_LOAD,IDLE,OP_ADDR,OP_FETCH,ALU_OP,STORE} state;
	enum {_HLT_,_SKZ_,_ADD_,_AND_,_XOR_,_LDA_,_STO_,_JMP_} instruction;
	logic  HALT,SKZ,ADD,AND,XOR,LDA,STO,JMP,ALUOP;
	logic [2:0] next_state;
	logic [2:0] state_current;
	//-----s-o�ões da ula--------
	always_comb case(opcode)
		_HLT_			: {ALUOP,HALT,STO,SKZ,JMP,AND,XOR,LDA,ADD,LDA}  = {1'b0,_HLT_,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0};
		_STO_			: {ALUOP,HALT,STO,SKZ,JMP,AND,XOR,LDA,ADD,LDA}  = {1'b0,1'b0,_STO_,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0};
	        _JMP_			: {ALUOP,HALT,STO,SKZ,JMP,AND,XOR,LDA,ADD,LDA}  = {1'b0,1'b0,1'b0,1'b0,_JMP_,1'b0,1'b0,1'b0,1'b0,1'b0};
		_SKZ_			: {ALUOP,HALT,STO,SKZ,JMP,AND,XOR,LDA,ADD,LDA}  = {1'b0,1'b0,1'b0,_SKZ_,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0};
		_ADD_,_AND_,_XOR_,_LDA_ : {ALUOP,HALT,STO,SKZ,JMP,AND,XOR,LDA,ADD,LDA}  = {1'b1,1'b0,1'b0,    1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0};
		default			: {ALUOP,HALT,STO,SKZ,JMP,AND,XOR,LDA,ADD,LDA}  = 10'b0	;
	endcase
	parameter [2:0] INST_ADDR = 0, INST_FETCH=1;
	always_comb //case(phase)
	 // 0:
	    case(state_current)
		INST_ADDR	:{next_state,sel,rd,ld_ir,halt,inc_pc,ld_ac,ld_pc,wr,data_e} = {3'b1,1'b1,	1'b0,	1'b0,	1'b0,	1'b0,	1'b0,	1'b0,	1'b0,	1'b0};
		1	:{next_state,sel,rd,ld_ir,halt,inc_pc,ld_ac,ld_pc,wr,data_e} = {INST_LOAD,1'b1,	1'b1,	1'b0,	1'b0,	1'b0,	1'b0,	1'b0,	1'b0,	1'b0	};
		INST_LOAD	:{next_state,sel,rd,ld_ir,halt,inc_pc,ld_ac,ld_pc,wr,data_e} = {IDLE,1'b1,	1'b1,	1'b1,	1'b0,	1'b0,	1'b0,	1'b0,	1'b0,	1'b0	};
		IDLE		:{next_state,sel,rd,ld_ir,halt,inc_pc,ld_ac,ld_pc,wr,data_e} = {OP_ADDR,1'b1,	1'b1,	1'b1,	1'b0,	1'b0,	1'b0,	1'b0,	1'b0,	1'b0	};
		OP_ADDR		:{next_state,sel,rd,ld_ir,halt,inc_pc,ld_ac,ld_pc,wr,data_e} = {OP_FETCH,1'b0,	1'b0,	1'b0,   HALT,   1'b1,   1'b0,	1'b0,	1'b0,   1'b0, 1'b0	};
		OP_FETCH	:{next_state,sel,rd,ld_ir,halt,inc_pc,ld_ac,ld_pc,wr,data_e} = {ALU_OP,1'b0,	ALUOP,	1'b0,	1'b0,	1'b0,	1'b0,	1'b0,	1'b0,	1'b0	};
		ALU_OP		:{next_state,sel,rd,ld_ir,halt,inc_pc,ld_ac,ld_pc,wr,data_e} = {STORE,1'b0,	ALUOP,	1'b0,	1'b0,  SKZ&&zero,  1'b0,    SKZ,	1'b0,	STO	};
		STORE		:{next_state,sel,rd,ld_ir,halt,inc_pc,ld_ac,ld_pc,wr,data_e} = {INST_ADDR,1'b0,    ALUOP,  1'b0,      1'b0,     1'b0,    JMP,  ALUOP,    STO,      STO	}; 
   		default         :{next_state,sel,rd,ld_ir,halt,inc_pc,ld_ac,ld_pc,wr,data_e} = {3'b1,1'b1,        1'b0,   1'b0,   1'b0,   1'b0,   1'b0,   1'b0,   1'b0,   1'b0};
		endcase
	 //  1: 
	// 	{sel,rd,ld_ir,halt,inc_pc,ld_ac,ld_pc,wr,data_e} = {1'b0,    1'b0,   1'b0,   1'b0,   1'b0, 1'b0,  1'b0,   1'b0,   1'b0   };
	//  endcase
//máquina de estados
//
//
//	initial next_state = INST_ADDR;
//	initial state_current = INST_ADDR;
//	always@({sel,rd,ld_ir,halt,inc_pc,ld_ac,ld_pc,wr,data_e}) next_state = state_current + 1;
	always_ff@(posedge clk) state_current <= 1;
	endmodule
