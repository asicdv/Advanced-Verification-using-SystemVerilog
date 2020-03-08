//Counter Testbench

program testcase(
  output logic clk,
  output logic rstn,
  output logic enable,
  output logic preload,
  output logic  [3:0] preload_val,  
  input detect,
  input [3:0] result 
);
  
  logic flag=0;

  initial begin
  forever begin
    #5  clk =  ! clk; 
  end
  end
  
  initial begin
    // Dump waves
    $dumpfile("dump.vcd");
    $dumpvars(1,top);    

    clk=0;
    rstn=0;
    enable=0;
    preload=0;
    preload_val=0;
    
    $monitor("t=%0t: result=%0d, detect=%b.", $time, result, detect);    
    
    @(posedge clk);
    rstn=1;
    
    @(posedge clk);
    enable=1;
    
    fork
    begin
    repeat(16) 
    	@(posedge clk);
    	enable=0;
    end
    begin
      	repeat(15) 
    	@(posedge clk);
     	if(detect!=1)
     	flag=1;
    end
    join
    
    repeat(1) 
    @(posedge clk);

    $finish;	//to call the final block
    
  end  
  
  final begin
    if(flag==1)
      $display("FAIL: Detect is not high after the count reached max value.");
    else
      $display("PASS: Detect is high after the count reached max value.");
  end   
endprogram