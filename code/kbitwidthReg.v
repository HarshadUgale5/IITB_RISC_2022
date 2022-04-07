//Authors :
//	1. Harshad Bhausaheb Ugale
//	2. Mahesh Shahaji Patil

// Description :
//	This is register which will be used between 
//	2 stages.

//	use parameter value to specify width of reg.


module kbitwidthReg #(parameter WIDTH = 16)
	(
	input [WIDTH - 1 : 0] Din,
	input clk,resetn,ld,
	output reg [WIDTH - 1 : 0] Qout
); 

	initial
		Qout <= {WIDTH{1'b0}};

	always @(posedge clk or negedge resetn)
	begin
		if(!resetn)
			Qout <= {WIDTH{1'b0}};
		else
		begin
			if(ld)
				Qout <= Din;
			else
				Qout <= {WIDTH{1'b0}};
		end
	end	
endmodule


