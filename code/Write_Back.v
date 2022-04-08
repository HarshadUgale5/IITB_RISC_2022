// Authors : 
//	Harshad Bhausaheb Ugale
//	Mahesh Shahaji Patil

// Description :
//	This module writes data back to memory or register file.


module Write_Back
(
	input resetn,
	input [36:0] WBInData,
	output wire [15:0] WB_OUT,
	output wire [2:0] reg_write_addr
);

	reg [15:0] WBOut_wire;
	reg [2:0]  reg_write_addr_wire;
	always @(resetn, WBInData)
		if(!resetn)
			begin
			WBOut_wire = 16'd0;
			reg_write_addr_wire = 3'd0;
			end
		else
			begin
			reg_write_addr_wire = WBInData[4:2];
			WBOut_wire = WBInData[20:5];
			end
	assign reg_write_addr = reg_write_addr_wire ;
	assign WB_OUT = WBOut_wire;

endmodule
