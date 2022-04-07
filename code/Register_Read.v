// Authors : 
//	Harshad Bhausaheb Ugale
//	Mahesh Shahaji Patil

// Description :
//	This module reads data from register file.


module Register_Read
(
	input clk,resetn,flush,
	input [18:0] InData,
	output wire [57:0]  outData 
);
	reg [15:0] R [0:7];		
	reg [57:0] outData_reg;
	initial 
		begin
			R[0] = 16'd1;
			R[1] = 16'd2;
			R[2] = 16'd3;
			R[3] = 16'd4;
			R[4] = 16'd5;
			R[5] = 16'd6;
			R[6] = 16'd7;
			R[7] = 16'd0;
		end
	always @ (posedge clk or negedge resetn)
		begin
			if(!resetn || flush)
					outData_reg = 58'd0;
			else
				begin
					outData_reg[6:0] = InData[6:0];
					outData_reg[25:10] = R[InData[18:16]];
					case(InData[1:0])
						2'b11 : outData_reg[57:26] = {R[InData[15:13]],R[InData[12:10]]}; // R 
						2'b10 :	outData_reg[57:26] = {R[InData[15:13]],10'd0,InData[12:7]}; // I
						2'b01 : outData_reg[57:26] = {23'd0,InData[15:7]}; // J
						2'b00 : outData_reg[57:26] = 32'd0;
					endcase
				end
		end
	assign outData = outData_reg;

endmodule

module ReadRegFile
#(parameter )
();
