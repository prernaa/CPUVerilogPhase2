module sign_ext_12_16(
  imm_12, imm_16);
  
  input [11:0] imm_12;
  output[15:0] imm_16;
  
  assign imm_16 = {{4{imm_12[11]}}, imm_12};
endmodule  

