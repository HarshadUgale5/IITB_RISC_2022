//Authors :
//	1. Harshad Bhausaheb Ugale
//	2. Mahesh Shahaji Patil

// Description :
//	This is main module of system.
//	
//	Organizes all the main modules of the pipeline.


// 6 comb logics,
// 5 regs


//	Instr_fetch instr_fetch_inst (.clk(clk), .resetn(resetn), .Instruction(Instruction));
//	kbitwidthReg IF_to_ID_REG #(16) (.Din(Instruction), .clk(clk), .restn(resetn), .ld(1'b1), .Qout(OutputToDecode)); // may not be needed

//	Instr_Decode instr_decode_inst(.clk(clk),.resetn(resetn),.Instr(OutputToDecode),.R_I_J(R_I_J),.alu_op(alu_op),.I_12(I_12));
//	kbitwidthReg ID_to_RR_REG #(19) (.Din({I_12,alu_op,R_I_J}),.clk(clk),.restn(resetn),.ld(1'b1),.Qout(OutputToRR));

//	Register_Read register_read_inst (resetn,.....);
//	kbitwidthReg RR_to_EX_REG #(k) (.Din(input),.clk(clk),.restn(resetn),.ld(reg_enable),.Qout(output));

//	Instr_Execute instr_execute_inst (resetn,....);
//	kbitwidthReg EX_to_MA_REG #(k) (.Din(input),.clk(clk),.restn(resetn),.ld(reg_enable),.Qout(output));

//	Memory_Access memory_access_inst (resetn,....);
//	kbitwidthReg MA_to_WB_REG #(k) (.Din(input),.clk(clk),.restn(resetn),.ld(reg_enable),.Qout(output));

//	Write_Back write_back_inst (resetn,....);
//	kbitwidthReg WB_to_RF_Mem_REG #(k) (.Din(input),.clk(clk),.restn(resetn),.ld(reg_enable),.Qout(output));
		

module processor (
	input clk,
	input resetn
);

localparam WIDTH = 16;
wire [WIDTH-1:0] OutputToDecode;
wire [15:0] Instruction;
wire [1:0]  R_I_J;
wire [4:0]  alu_op;
wire [11:0] I_12;


	Instr_Fetch instr_fetch_inst (.clk(clk), .resetn(resetn), .Instruction(Instruction));
	kbitwidthReg IF_to_ID_REG (.Din(Instruction), .clk(clk), .resetn(resetn), .ld(1'b1), .Qout(OutputToDecode));
	Instr_Decode instr_decode_inst(.resetn(resetn),.Instr(OutputToDecode),.R_I_J(R_I_J),.alu_op(alu_op),.I_12(I_12));

endmodule

module tb ();

reg clk,resetn;

processor proc_inst (.clk(clk),.resetn(resetn));

initial
	begin
		clk = 0;
		resetn = 1;
		#100 resetn = 0;
		#100 resetn = 1;
	end

always #50 clk = ~clk;

endmodule
