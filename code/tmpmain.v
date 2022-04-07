module tmpmain;

	reg [15:0] instr_mem [0:15];
	reg [15:0] data_mem  [0:15];
	load_instr_mem loadmem (instr_mem);
