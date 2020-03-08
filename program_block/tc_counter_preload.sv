//Counter sanity test

//`include "task.sv"
  
program testcase(
  output logic clk,
  output logic rstn,
  output logic enable,
  output logic preload,
  output logic  [3:0] preload_val,
  input detect,
  input [3:0] result 
);
  
  bit pflag, rflag, dflag;
  int rnd_val;
  int count;
  
  initial begin
  //Free running timer
  //always #5 clk=~clk; syntax error
  forever begin
    #5  clk =  ! clk; 
 	 end
  end
  
  initial begin
    rnd_val = $urandom_range(0,`MAX_COUNT); 
	//Print values when there is a change
    $monitor("t=%0t: result=%0d, detect=%b", $time, result, detect);     
    init(clk, rstn, enable, preload, preload_val);            
   
    @(posedge clk);
    enable=1;

    //set preload data after random count
    do begin
      @(posedge clk);  
    end while(result!=rnd_val);       
    preload=1'b1;
    preload_val=4'h8;
    count=`MAX_COUNT-preload_val;
    
    //reset preload
    @(posedge clk);
	preload=1'b0;
    
    //check if the result is loaded with preload value
    if(result!=preload_val)
      pflag=1;
    
    repeat(count)
      @(posedge clk);
         
    if( result!=`MAX_COUNT)
      rflag=1;   

    if(detect!=1)
      dflag=1;   
    /*do  
    @(posedge clk);
    while(result!=`MAX_COUNT);*/
    
    $finish;
  end  
  
  final begin
    if(pflag==1)
      $display("FAIL: Result does not goes to preload value %0d after preload.",result);
    else
      $display("PASS: Result goes to preload value %0d after preload.",result);
    
    if(rflag==1)
      $display("FAIL: Result=%0d has not reached the max value.",result);
    else
      $display("PASS: Result=%0d has reached the max value.",result);
    
    if(dflag==1)
      $display("FAIL: Detect is not high after expected result reaches max value.",result);
    else
      $display("PASS: Detect is high after expected result reaches max value.",result);
  end 

  task init();  
    // Dump waves
    $dumpfile("dump.vcd");
    $dumpvars(1,top);
	//Print values when there is a change
    $monitor("t=%0t: result=%0d, detect=%b.", $time, result, detect);    
	//Initalize  
    clk=0;
    rstn=0;
    enable=0;
    preload=0;
    preload_val=0;
	//reset
    @(posedge clk);
    rstn=1;
  
  endtask : init
  
endprogram

