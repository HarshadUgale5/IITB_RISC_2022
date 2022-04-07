// Authors : 
//	Harshad Bhausaheb Ugale
//	Mahesh Shahaji Patil

// Description :
//	This module is responsible for read and
//	 write in registerfile.

module Register_File
(
	input clk,resetn,R7_enable,
	input [15:0] Din,R7_in,
	input [2:0] reg_write_addr,
	input [8:0] reg_read_addr,
	
);
