module Sign_Extend (In,ImmSrc,Imm_Ext);
    input [31:0] In;
    input [1:0] ImmSrc;
    output [255:0] Imm_Ext;

    assign Imm_Ext =  (ImmSrc == 2'b00) ? {{244{In[31]}},In[31:20]} : 
                     (ImmSrc == 2'b01) ? {{244{In[31]}},In[31:25],In[11:7]} : 256'h00000000; 

endmodule