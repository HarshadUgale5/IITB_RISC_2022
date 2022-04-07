// Authors : 
//	Harshad Bhausaheb Ugale
//	Mahesh Shahaji Patil

// Description :
//	This module reads instruction from kbitwidthReg
//	 Decodes it and sends signals to next stage.

module Instr_Decode
(
	input clk,resetn,flush,
	input [15:0] Instr,
	output wire [1:0]  R_I_J,
	output wire [4:0]  alu_op,
	output wire [11:0] I_12
); 

	wire R,I,J;
	wire [1:0] R_I_J_wire;
	wire [4:0] alu_op_wire,
	
	assign R = (not ( Instr[15] )) and (not ( Instr[14] )) and ( (Instr[13]) xor (Instr[12]));
	assign I = (not ((Instr[13])or(Instr[12])or(Instr[15]))) or ((not (Instr[15])) and (Instr[14]) and (not (Instr[13]))) or ((Instr[15]) and ((Instr[14]) nor (Instr[12])));

	assign J = (Instr[15] and (Instr[14] or Instr[12])) or ((not Instr[14]) and (Instr[13]) and (Instr[12]));

	always @ (posedge clk or negedge resetn)
		begin
			if(flush or (!resetn))
				begin
					R_I_J <= 2'd0;
					alu_op <= 5'd0;
					I_12 <= 12'd0;
				end	
			else
				begin
					case({R,I,J})
						3'b100 :  R_I_J_wire = 2'b11;
						3'b010 :  R_I_J_wire = 2'b10;
						3'b001 :  R_I_J_wire = 2'b01;
						default : R_I_J_wire = 2'b00;
					endcase
				end

	assign R_I_J = R_I_J_wire;
	alu_op,
	I_12

endmodule



