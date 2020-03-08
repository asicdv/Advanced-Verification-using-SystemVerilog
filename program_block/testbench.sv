//Counter Testbench

`define MAX_COUNT 15

//`include "task.sv"
//`include "tc_sanity_check.sv"
//`include "tc_count2max.sv"
//`include "tc_count2max_bug.sv"
//`include "tc_disable_count.sv"
//`include "tc_reset_count.sv"
//`include "tc_reset_disable.sv"
`include "tc_counter_preload.sv"

module top;
   
  wire clk;
  wire rstn;
  wire enable;
  wire preload;
  wire [3:0] preload_val;
  wire detect;
  wire [3:0] result;

  //using implicit port connections
  counter u_counter (.clk, .rstn, .enable, .preload, .preload_val, .detect, .result);	
  testcase u_testcase(.*);

  /*counter u_counter(
    .clk(clk),
    .rstn(rstn),
    .enable(enable),
    .detect(detect),
    .result(result)
  );*/
  
/*  testcase u_testcase(
    .clk(clk),
    .rstn(rstn),
    .enable(enable),
    .detect(detect),
    .result(result)
  );*/


  
endmodule : top
