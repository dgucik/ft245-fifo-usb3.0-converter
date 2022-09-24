module top (
	input 	wire 			CLK_FPGA, //27MHz
	input 	wire 			CLK_FTDI, //100MHz
	input 	wire 			HRST_N,
	input 	wire 			SRST_N,
	input 	wire 			TXE_N,
	inout 	wire [31:0] DATA,
	inout 	wire [3:0] 	BE,
	output 	wire 			WR_N,
	output	wire			RD_N,
	output	wire			OE_N
	);

	// reset
	wire rst;
	assign rst = (HRST_N & SRST_N);
	
	// data_generator unit
	wire [31:0] ge_data;
	wire ge_valid;
	
	data_generator u_data_generator(
		.clk(CLK_FPGA),
		.rst(rst),
		.ge_data(ge_data),
		.ge_valid(ge_valid)
	);
	
	data_gateway u_data_gateway(
		.rst(rst),
		.data_in_clk(CLK_FPGA),
		.data_in(ge_data),
		.data_in_valid(ge_valid),
		.ftdi_clk(CLK_FTDI),
		.ftdi_txe_n(TXE_N),
		.ftdi_data(DATA),
		.ftdi_be(BE),
		.ftdi_wr_n(WR_N)
	);
	
	assign RD_N = 1'b1;
	assign OE_N = 1'b1;
	
endmodule