
module testbench();
  
initial begin
$display("-----------------------------------------------------------------");
    show(3,1);
    show(2,2);
    show(1,3);
$display("-----------------------------------------------------------------");  
end

  task show(int sdelay, int stask);
    #sdelay $display("Task:%0d is execued after Delay:%0d at Time:%0d",sdelay,stask,$time);
  endtask

endmodule
