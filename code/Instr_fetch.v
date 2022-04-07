// Authors : 
//	Harshad Bhausaheb Ugale
//	Mahesh Shahaji Patil

// Description :
//	This module initially loads instructions from 
//	 program_instr.hex file and stores them
//	 into Instruction_mem.
//	Then, reads instruction from instr_mem using PC.
module Instr_Fetch
(
	input clk,resetn,flush,
	output wire [15:0] Instruction
);
	reg  [15:0] PC;
	wire [15:0] PC_next;
	reg [3:0]  instr_mem_addr;
	reg  [15:0] instr;	
	reg  [15:0] instr_mem [0:15];
	initial
		begin
		$readmemb("program_instr.hex",instr_mem); 
		end

	always @ (posedge clk or negedge resetn)
		begin
		if(!resetn)
			begin
			// if resetn = '0' clear all
			instr <= 16'd0;
			PC <= 16'd0;
			end
		else if(flush)
			instr <= 16'd0;
		else
			begin
			// else fetch new instr.
			instr_mem_addr <= PC[3:0];
			instr <= instr_mem[instr_mem_addr];
			PC <= PC_next;
			end
		end
	assign PC_next = PC + 16'd1;
	assign Instruction = instr;
endmodule
