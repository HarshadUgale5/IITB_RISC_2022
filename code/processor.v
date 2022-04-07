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
//	kbitwidthReg IF_to_ID_REG #(16) (.Din(Instruction), .clk(clk), .restn(resetn), .ld(1'b1), .Qout(OutputToDecode));

//	Instr_Decode instr_decode_inst(.clk(clk),.resetn(resetn),.Instr(OutputToDecode),.R_I_J(R_I_J),.alu_op(alu_op),.I_12(I_12));
//	kbitwidthReg ID_to_RR_REG #(19) (.Din({R_I_J,alu_op,I_12}),.clk(clk),.restn(resetn),.ld(1'b1),.Qout(OutputToRR));

//	Register_Read register_read_inst (resetn,.....);
//	kbitwidthReg RR_to_EX_REG #(k) (.Din(input),.clk(clk),.restn(resetn),.ld(reg_enable),.Qout(output));

//	Instr_Execute instr_execute_inst (resetn,....);
//	kbitwidthReg EX_to_MA_REG #(k) (.Din(input),.clk(clk),.restn(resetn),.ld(reg_enable),.Qout(output));

//	Memory_Access memory_access_inst (resetn,....);
//	kbitwidthReg MA_to_WB_REG #(k) (.Din(input),.clk(clk),.restn(resetn),.ld(reg_enable),.Qout(output));

//	Write_Back write_back_inst (resetn,....);
//	kbitwidthReg WB_to_RF_Mem_REG #(k) (.Din(input),.clk(clk),.restn(resetn),.ld(reg_enable),.Qout(output));
		// may not be needed



