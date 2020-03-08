//Counter sanity test

program testcase(
  output logic clk,
  output logic rstn,
  output logic enable,
  output logic preload,
  output logic  [3:0] preload_val,
  input detect,
  input [3:0] result 
);

  initial begin
  //Free running timer
  //always #5 clk=~clk; syntax error
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
    
    repeat(10) 
    @(posedge clk);
    enable=0;
    
    repeat(10) @(posedge clk)
    $finish;        
  end  
  
endprogram