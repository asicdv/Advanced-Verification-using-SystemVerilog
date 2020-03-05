
module testbench();
  
initial begin
$display("-----------------------------------------------------------------");  	
  fork
    show(30,1); //show(delay,task_number)
    show($urandom_range(0,20),2);
    show(10,3);
  join_any  
  show(5,4);
  show(1,5);
  wait fork;//previously I had delay here.
$display("-----------------------------------------------------------------"); 
  $finish;
end

  task automatic show(int sdelay, int stask);
    #sdelay $display("Task:%0d is execued after Delay:%0d at Time:%0d",stask, sdelay,$time);
  endtask
  
endmodule
