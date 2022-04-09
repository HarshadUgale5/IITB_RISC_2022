// Authors : 
//	Harshad Bhausaheb Ugale
//	Mahesh Shahaji Patil

// Description :
//	This module works as memory controller.



module Memory
(
	input clk,resetn,rwbar,
	input [15:0] mem_addr,
	input [15:0] write_data,
	output wire [15:0] read_data
);
	reg [15:0] Memory [0:15];
	wire [3:0] mem_physical_addr = mem_addr[3:0];
	reg [15:0] read_data_reg;

	always @ (posedge clk or negedge resetn)
		begin
			if(!resetn)
				read_data_reg = 16'd0;
			else
				begin
					if(rwbar) // read data
						read_data_reg = Memory[mem_physical_addr];
					else //write data
						Memory[mem_physical_addr] = write_data;
				end
		end
	assign read_data = read_data_reg;
endmodule
