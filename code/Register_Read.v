// Authors : 
//	Harshad Bhausaheb Ugale
//	Mahesh Shahaji Patil

// Description :
//	This module reads data from register file.


module Register_Read
(
	input clk,resetn,flush,
	input [18:0] InData,
	output wire []  outData 
);
	reg [15:0] R [0:7];		
	reg outData_reg;
	initial 
		begin
			R[0] = 16'd1;
			R[1] = 16'd2;
			R[2] = 16'd3;
			R[3] = 16'd4;
			R[4] = 16'd5;
			R[5] = 16'd6;
			R[6] = 16'd0;
			R[7] = ;
		end
	always @ (posedge clk or negedge resetn)
		begin
			if(!resetn or flush)
					outData_reg = 'd0;
			else
				begin
					case(InData[18:17])
						2'b00 : 
						2'b01 :
						2'b10 :
						2'b11 :
				end
		end
	
