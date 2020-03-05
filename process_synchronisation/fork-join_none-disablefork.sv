
module testbench();
  
initial begin
$display("-----------------------------------------------------------------");  	
  fork
    show(30,1); //show(delay,task_number)
    show($urandom_range(0,20),2);
    show(10,3);
  join_none 
  show(5,4);
  show(1,5);
  disable fork;//if you disable the join_none forked process unless 0 time all process gets killed.
  #50;
$display("-----------------------------------------------------------------");  
end

  task automatic show(int sdelay, int stask);
    #sdelay $display("Task:%0d is execued after Delay:%0d at Time:%0d",stask, sdelay,$time);
  endtask
  
endmodule
