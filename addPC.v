module addPC(in, out, stall);
    input[15:0] in;
    input stall;
    output[15:0] out;
    
    assign out = (stall!==1'b1)? in + 16'b0000000000000001 : in;
    
endmodule
