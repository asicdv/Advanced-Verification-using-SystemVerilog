module ram(
            clk,
            rstn,
            ce_mem,
            we_mem,
            addr_mem,
            datai_mem,
            datao_mem   
);
  
  	input bit clk;
  	input bit rstn;
  	input bit ce_mem;
  	input bit we_mem;
  	input bit [3:0] addr_mem;
  	input bit [3:0] datai_mem;
  	output logic [3:0] datao_mem;
  	
  	logic [3:0] mem [0:3];
    
  always @(posedge clk or negedge rstn) begin
    if(rstn) begin
      mem[0]  <= 4'b0;
      mem[1]  <= 4'b0;
      mem[2]  <= 4'b0;
      mem[3]  <= 4'b0;
      datao_mem <= 4'b0;
    end
	//Memory write logic
    else if(ce_mem && we_mem)
      mem[addr_mem] <= datai_mem;
	//Memory read logic
    else if(ce_mem && !we_mem)
      datao_mem <= mem[addr_mem];  
  end      
endmodule 