// Register File module
`timescale 1ns / 1ps
module regfile (
	clk,
	rst,
	wen,
	//lhb_llb_sec_control,
	//jr_rf,
	//jr_raddr,
	//jal_write_reg,
	//jal_pc_val,
	raddr1, 
	raddr2, 
	waddr, 
	wdata, 
  	rdata1,
	rdata2
	);
	
        parameter DSIZE=16;
        parameter NREG=16;
        localparam RSIZE=4;
        
  	input clk;
	input rst;
	input wen;
	//input lhb_llb_sec_control;
	//input jr_rf;
	//input jal_write_reg;
	//input [DSIZE-1:0] jal_pc_val;
	//input [RSIZE-1:0] jr_raddr;
	input [RSIZE-1:0] raddr1;
	input [RSIZE-1:0] raddr2; 
	input [RSIZE-1:0] waddr;
	input [DSIZE-1:0] wdata;
 	output [DSIZE-1:0] rdata1;
	output [DSIZE-1:0] rdata2;

	reg [DSIZE-1:0] regdata [0:NREG-1];
	reg wen_temp;
	// assign RData2 = RegFile[RAddr2];
	//assign wen = wen_temp;

	always@(posedge clk)
		begin
			if(rst)
				begin
				  //wen_temp <= 0;
					regdata[0] <=0;
                                        regdata[1] <=0;
                                        regdata[2] <=0;
                                        regdata[3] <=0;
                                        regdata[4] <=0;
                                        regdata[5] <=0;
                                        regdata[6] <=0;
                                        regdata[7] <=0;
                                        regdata[8] <=0;
                                        regdata[9] <=0;
                                        regdata[10] <=0;
                                        regdata[11] <=0;
                                        regdata[12] <=0;
                                        regdata[13] <=0;
                                        regdata[14] <=0;
                                        regdata[15] <=0;
				end
			/*else if(jal_write_reg == 1)
			  regdata[15] = jal_pc_val;*/
			else
				regdata[waddr] <= ((wen == 1) && (waddr != 0)) ? wdata : regdata[waddr];
				
		end
	
	//assign rdata1 = jr_rf? regdata[jr_raddr]:(((wen) && (waddr == raddr1) && (waddr != 0)) ? wdata : regdata[raddr1]);
	//added support for load immediate, new control added
	//assign rdata2 = (lhb_llb_sec_control)?(regdata[waddr]) :(((wen) && (waddr == raddr2) && (waddr != 0)) ? wdata : regdata[raddr2]); 

  assign rdata1 = ((wen===1) && (waddr == raddr1) && (waddr != 0))? wdata : regdata[raddr1];
  assign rdata2 = ((wen===1) && (waddr == raddr2) && (waddr != 0)) ? wdata : regdata[raddr2];

endmodule 
