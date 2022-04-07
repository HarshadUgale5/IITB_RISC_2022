// Authors : 
//	Harshad Bhausaheb Ugale
//	Mahesh Shahaji Patil

// Description :
//	This module reads instruction from kbitwidthReg
//	 Decodes it and sends signals to next stage.

module Instr_Decode
(
	input resetn,flush,
	input [15:0] Instr,
	output wire [1:0]  R_I_J,
	output wire [4:0]  alu_op,
	output wire [11:0] I_12
); 

	wire R,I,J;
	reg [1:0] R_I_J_reg;
	reg [4:0] alu_op_reg;
	reg [11:0] I_12_reg;
	
	// R = (!I[15]) and (!i[14]) and (I[13] xor I[12]);
	assign R = (!Instr[15]) && (!Instr[14]) && ( ((!Instr[13]) && Instr[12]) || ((!Instr[12]) && (Instr[13])));
	// I = (!I[13] and !I[12] and !I[15]) or (!I[15] and I[14] and !I[13]) or (I[15] and !I[14] and !I[12])
	assign I = ((!Instr[13]) && (!Instr[12]) && (!Instr[15])) || ((!Instr[15])&&(Instr[14])&&(!Instr[13])) || ((!Instr[14])&&(Instr[15])&&(!Instr[12]));
	// J = (I[15] and I[14]) or (I[14] and I[12]) or (!I[14] and I[13] and I[12])
	assign J = (Instr[15] && (Instr[14] || Instr[12])) || ((!Instr[14]) && (Instr[13]) && (Instr[12]));

	always @ (*)
		begin
			if(flush || (!resetn))
				begin
					R_I_J_reg = 2'd0;
					alu_op_reg = 5'd0;
					I_12_reg = 12'd0;
				end	
			else
				begin
					I_12_reg = Instr[11:0];
					case({R,I,J})
						3'b100 :  R_I_J_reg = 2'b11;
						3'b010 :  R_I_J_reg = 2'b10;
						3'b001 :  R_I_J_reg = 2'b01;
						default : R_I_J_reg = 2'b00;
					endcase
					
					case(Instr[15:12])
						4'b0001 : case(Instr[1:0])
								2'b00 : alu_op_reg = 5'd1; // ADD
								2'b10 : alu_op_reg = 5'd2; // ADC
								2'b01 : alu_op_reg = 5'd3; // ADZ
								2'b11 : alu_op_reg = 5'd4; // ADL
							 endcase
						4'b0010 : case(Instr[1:0])
                                                                2'b00 : alu_op_reg = 5'd5; // NDU
                                                                2'b10 : alu_op_reg = 5'd6; // NDC
                                                                2'b01 : alu_op_reg = 5'd7; // NDZ
                                                                2'b11 : alu_op_reg = 5'd0; // Invalid
                                                         endcase
						4'b0011 : alu_op_reg = 5'd8; // LHI
						default : alu_op_reg = 5'd0; // Invalid
					endcase
				end
		end

	assign R_I_J = R_I_J_reg;
	assign alu_op = alu_op_reg;
	assign I_12 = I_12_reg;

endmodule
