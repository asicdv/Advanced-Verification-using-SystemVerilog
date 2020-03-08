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
  
  bit flag=0;
  int val;

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
    
    val=$urandom_range(0,`MAX_COUNT);
    
    $monitor("t=%0t: result=%0d, detect=%b", $time, result, detect);    
    
    @(posedge clk);
    rstn=1;
    
    @(posedge clk);
    enable=1;
    
    do begin
    @(posedge clk);  
    end while(result!=val);
    
    rstn=0;
    
    @(posedge clk);  
    
    if(result!=0)
      flag=1;
    
    repeat(2) 
    @(posedge clk);
        
    $finish;
  end  
  
  final begin
    if(flag==1)
      $display("FAIL: Result does not goes to 0 after reset.");
    else
      $display("PASS: Result goes to 0 after reset.");
  end   
endprogram