//instruction fetch stage
module if_id(clk, inst_curr, pc_added, inst_curr_IFID, pc_added_IDIF, ifid_stall);
    input[15:0] inst_curr , pc_added;
    input clk;
    input ifid_stall;
    output [15:0] inst_curr_IFID , pc_added_IDIF;
    reg [15:0] test;
    reg [15:0] pc_added_temp;
    reg try;
    wire stall_temp;
    assign stall_temp = ifid_stall;
    always @ (posedge clk)
      begin
        //get instruction
        try = 0;
        if(stall_temp!==1'b1) begin
          try=1; 
          test <= inst_curr;
          pc_added_temp <= pc_added;
        /*pc_added_IFID <= pc_added;*/
        end
      end
    assign inst_curr_IFID = test; 
    assign pc_added_IDIF = pc_added_temp;

endmodule
