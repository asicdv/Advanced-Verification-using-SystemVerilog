
module top;
  
  wire clk;
  wire sys_clk;
  
  testcase u_testcase(.clk,.sys_clk);
  
  initial begin    
    // Dump waves
    $dumpfile("dump.vcd");
    $dumpvars(1,top);        
  end
  
endmodule : top

module testcase(
  output clk,
  output sys_clk);
  
  logic clk=1;
  logic sys_clk=1;

  int time1,time2,time3,time4,time5,time6;
  
  always #5 clk=~clk;
  always #10 sys_clk=~sys_clk;
  
  //make 5 units clock
  clocking cb @(posedge clk);  

  endclocking  
    
  //make 10 units clock as default
  default clocking syscb @(posedge sys_clk);  
  
  endclocking  
  
  initial begin
    //repeat(10) @(posedge clock);
    
    #10 time1=$time;
    $display("Time1 #10=%0d",time1);    
    
    ##10 time2=$time;     
    $display("Time2 ##10=%0d",time2-time1);
    
    repeat(10) @(posedge clk)
    time3=$time;
    $display("Time3 @(posedge clk)=%0d",time3-time2);
    
    repeat(10) @(cb)
    time4=$time;
    $display("Time4 @(cb)=%0d",time4-time3); 
    
    repeat(10) @(posedge sys_clk)
    time5=$time;
    $display("Time5 @(posedge sys_clk)=%0d",time5-time4);
    
    repeat(10) @(syscb)
    time6=$time;
    $display("Time6 @(syscb)=%0d",time6-time5);       
    
    $finish;     
  end
    
endmodule : testcase