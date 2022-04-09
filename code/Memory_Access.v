// Authors : 
//	Harshad Bhausaheb Ugale
//	Mahesh Shahaji Patil

// Description :
//	This module reads memory and gived data.


module Memory_Access
(
	input resetn,flush,
	input [37:0] MemAccessInData,
	output wire [15:0] Mem_Addr,
	output wire [37:0] MemAccessOutput
);

	reg [37:0] MemAccessOutput_reg;
	reg [15:0] Mem_Addr_reg;
	always @ (resetn,flush, MemAccessInData)
		if(!resetn)
			begin
				MemAccessOutput_reg = 38'd0;
				Mem_Addr_reg = 16'd0;
			end
		else
			begin
			if(MemAccessInData[0])
				begin
				Mem_Addr_reg = MemAccessInData[21:6]; 
				MemAccessOutput_reg = {16'd0, MemAccessInData[37:22],MemAccessInData[5:0]};
				end
			else
				begin
				Mem_Addr_reg = 16'd0;
				MemAccessOutput_reg = MemAccessInData; 
				end
			end

	assign Mem_Addr = Mem_Addr_reg;
	assign MemAccessOutput = MemAccessOutput_reg;

endmodule

				
