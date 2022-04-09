// Authors : 
//	Harshad Bhausaheb Ugale
//	Mahesh Shahaji Patil

// Description :
//	This module reads data from register file.


module Register_Read
(
	input resetn,flush,
	input [18:0] InData,
	input [31:0] reg_Read_Data,
	output reg [5:0] reg_read_addr,	
	output wire [41:0]  outData 
);
	reg [41:0] outData_reg;
	
	always @ (*)
		begin
			if(!resetn || flush)
				begin
					outData_reg = 58'd0;
					reg_read_addr = 6'd0;
				end
			else
				begin
					reg_read_addr = {InData[15:13] , InData[12:10]}; // will change for SW instr.
					case(InData[1:0])
						2'b11 : outData_reg[41:10] = reg_Read_Data; // R 
						2'b10 :	outData_reg[41:10] = {reg_Read_Data[31:16],10'd0,InData[12:7]}; // I
						2'b01 : outData_reg[41:10] = {23'd0,InData[15:7]}; // J
						2'b00 : outData_reg[41:10] = 32'd0;
					endcase
				end
		end
	assign outData = {outData_reg[41:10],InData[18:16],InData[6:0]};

endmodule

