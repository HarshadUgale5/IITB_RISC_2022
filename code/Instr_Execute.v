// Authors : 
//	Harshad Bhausaheb Ugale
//	Mahesh Shahaji Patil

// Description :
//	This module executes the instruction.

module Instr_Execute
(
	input clk,resetn,flush,
	input [42:0] ExInData,
	output wire update,
	output wire [36:0] OutToMA
);
	//	flags[0] -> C and flags[1] -> Z
	reg [1:0] flags;
	wire [1:0] old_flags;
	reg update_w;
	reg [36:0] Out;
	reg load_from_mem;

	kbitwidthReg #(2) Flag_reg (.Din(flags),.clk(clk),.resetn(resetn), .ld(1'b1),.Qout(old_flags));	

	always @(ExInData,resetn,flush)
		if(!resetn || flush)
			begin
			Out = 37'd0;
			flags = 2'd0;
			update_w = 0;
			end
		else
			begin
			case(ExInData[6:2])
				5'b00001 :	// ADD
					begin
					{flags[0],Out[20:5]} = {1'b0,ExInData[41:26]} + {1'b0,ExInData[25:10]};
					update_w = 1;
					flags[1] = ~|Out[20:5];
					load_from_mem = 0;
					end
				5'b00010 :	// ADC
					if(old_flags[0])
						begin
						{flags[0],Out[20:5]} = {1'b0,ExInData[41:26]} + {1'b0,ExInData[25:10]};
						update_w = 1;
						flags[1] = ~|Out[20:5];
						load_from_mem = 0;
						end
					else
						update_w = 0;
				5'b00011 :	// ADZ
					if(old_flags[1])
						begin	
						{flags[0],Out[20:5]} = {1'b0,ExInData[41:26]} + {1'b0,ExInData[25:10]};
						update_w = 1;
						flags[1] = ~|Out[20:5];
						load_from_mem = 0;
						end
					else
						update_w = 0;
				5'b00100 :	// ADL
					begin
					{flags[0],Out[20:5]} = {1'b0,ExInData[41:26]} + {1'b0,(ExInData[25:10] << 1)};
					update_w = 1;
					flags[1] = ~|Out[20:5];
					load_from_mem = 0;
					end
				5'b00101 :	// NDU
					begin
					Out[20:5] = ~(ExInData[41:26] & ExInData[25:10]) ;
					update_w = 1;
					flags[1] = ~|Out[20:5];
					load_from_mem = 0;
					end
				5'b00110 :	// NDC
					if(old_flags[0])
						begin
						Out[20:5] = ~(ExInData[41:26] & ExInData[25:10]);
						update_w = 1;
						flags[1] = ~|Out[20:5];
						load_from_mem = 0;
						end
					else
						update_w = 0;
				5'b00111 :	// NDZ
					if(old_flags[1])
						begin	
						Out[20:5] = ~(ExInData[41:26] & ExInData[25:10]);
						update_w = 1;
						flags[1] = ~|Out[20:5];
						load_from_mem = 0;
						end
					else
						update_w = 0;
				5'b01000 :	// LHI
					begin
					Out[20:5] = {ExInData[18:10],7'd0};
					update_w = 1;
					load_from_mem = 0;
					end
				default :	// NOP
					update_w = 0;
			endcase
			end

	assign update = update_w;
	assign OutToMA = {ExInData[41:26],Out[20:5],ExInData[9:7],ExInData[1:0],load_from_mem};

endmodule


// 000000000000001000000000000000010110000111 // ADD R6,1,2
// 111111111111111100000000000000010110000111 // ADD R6,2^16-1,1
// 000000000000001000000000000000010110001011 // ADC R6,
// 000000000000001000000000000000010110010111 // NDU R6,1,2
// 000000000000001000000000000000010110011011 // NDC R6,1,2
// 000000000000001000000000000000010110011111 // NDZ R6,1,2
// 000000000000001000000000000000010110100001 // LHI R6,1<<10
