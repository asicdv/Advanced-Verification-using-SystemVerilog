//Counter Design

module counter(
	input clk,
  	input rstn,
  	input enable,
  	input preload,
  	input [3:0] preload_val,
  	output logic [3:0] result,
  	output logic detect);

  always @(posedge clk or negedge rstn) begin
    if(!rstn) begin
		result<=4'b0;
      	detect<=1'b0;
    end
    else begin
      if(preload==1)
        result<=preload_val;
      else if(enable==1'b1) begin
        if(result==4'hF) begin          
          result<=result;
          detect<=1'b1;          
        end
        else begin
          result<=result+1'b1;
          detect<=(result==4'hE) ? 1'b1: 1'b0;
        end
      end
      else begin
        result<=result;
        detect<=detect;
      end        
    end              
  end
    
endmodule