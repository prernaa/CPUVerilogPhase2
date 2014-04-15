module ShiftLeftThenAdd1s(In, Out_L8_1);
    input [7:0] In;
    output [15:0] Out_L8_1;
    
    assign Out_L8_1 = {In[7:0], 8'b11111111};
    
endmodule

