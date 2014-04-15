module andgate(
  mem_branch,
  zero,
  pcsrc
);
input mem_branch;
input zero;
output pcsrc;

assign pcsrc = mem_branch & zero;

endmodule