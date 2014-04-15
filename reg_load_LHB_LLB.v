`define LHB 4'b1010
`define LLB 4'b1011

module reg_load_LHB_LLB(opcode, In, imm_val, Out);
    parameter DSIZE = 16;
    input [3:0] opcode;
    //LHB = 1010
    //LLB = 1011
    input [DSIZE-1:0] In;
    input [15:0] imm_val;
    
    output [DSIZE-1:0] Out;
    assign Out = (opcode==`LHB)? {imm_val[7:0], In[7:0]} : ($signed(imm_val[7:0]));    
endmodule


