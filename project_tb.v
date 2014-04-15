// This file is the testbench for D_memory.v

module project_tb;
reg clk;
reg rst;

phase1_top CPU(.clk(clk), .rst(rst));

initial
begin
  clk = 0;
  //rst = 0;
  //#5 rst = 1;
  //#10 rst = 0;
  rst=0;
  #10 rst = 1;
  #20 rst = 0;
  #300 $stop;
end

always begin
  #5 clk = ~clk;
end


endmodule // end of testbench module

