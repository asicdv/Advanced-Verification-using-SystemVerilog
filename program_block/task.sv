//Initalize task

task init(logic clk, logic rstn, logic enable, logic preload, logic [3:0] preload_val);  
    // Dump waves
    $dumpfile("dump.vcd");
    $dumpvars(1,top);
   
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