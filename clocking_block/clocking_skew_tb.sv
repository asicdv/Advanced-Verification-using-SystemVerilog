`include "testcase.sv"

module ram_tb();
  
  bit clk;
  logic rstn;
  logic ce_mem;
  logic we_mem;
  logic [3:0] addr_mem;
  logic [3:0] datai_mem;
  logic [3:0] datao_mem;
  
  always #10 clk=~clk;
  
  initial begin
    // Dump waves
    $dumpfile("dump.vcd");
    $dumpvars(1,u_ram); 
 
  end
  
  ram u_ram(.*);
  
  testcase u_testcase(.*);
  
endmodule