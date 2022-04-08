// Authors : 
//	Harshad Bhausaheb Ugale
//	Mahesh Shahaji Patil

// Description :
//	This module is responsible for read and
//	 write in registerfile.

module Register_File
#(parameter REG_FILE_WIDTH = 8)
(
	input clk,resetn,
	input [15:0] Din,
	input [2:0] reg_write_addr,
	input [5:0] reg_read_addr,
	output reg [31:0] read_data	
);

	wire [15:0] reg_read_data[0 : REG_FILE_WIDTH - 1];
	reg [0 : REG_FILE_WIDTH-1] en;

	genvar i;
	
	generate
		for(i = 0; i < (REG_FILE_WIDTH); i = i + 1)
		begin
		kbitwidthReg #(16) kbitwidthRegIns(.Din(Din), .clk(clk), .resetn(resetn), .ld(en[i]), .Qout(reg_read_data[i]));
		end
	endgenerate
	// read data
	always @(clk,reg_read_addr)
		read_data = {reg_read_data[reg_read_addr[5:3]],reg_read_data[reg_read_addr[2:0]]};

	// write enable 
	always @(reg_write_addr,Din,resetn)
		begin
			if(!resetn)
				read_data = 32'd0;
			else
			begin
				en = 8'd0;
				en[reg_write_addr] = 1;	
			end
		end
endmodule

