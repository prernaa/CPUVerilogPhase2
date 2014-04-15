module changefirst8bits_1(In, Out_F8_1);

    input [15:0] In;
    output [15:0] Out_F8_1;
    
    assign Out_F8_1 = {8'b11111111, In[7:0]};    
endmodule

