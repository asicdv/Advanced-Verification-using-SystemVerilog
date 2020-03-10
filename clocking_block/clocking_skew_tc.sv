program testcase(
			input bit clk,
            output logic rstn,
            output logic ce_mem,
            output logic we_mem,
  			output logic [3:0] addr_mem,
  			output logic [3:0] datai_mem,
  			input logic [3:0] datao_mem   
);

  logic [3:0] addr, data, out;
  
  //This clocking block will be the default for the system
  default clocking ramcb @(posedge clk);
      default input #1step
    		  output #0;
    
	//try with different skews    
      input  #1 datao_mem=ram_tb.u_ram.datao_mem;
  	  output #2 ce_mem, addr_mem, datai_mem;
      output #2 we_mem;
  endclocking

  initial begin 
    
    //Clocking block not used
/*    
    //initalize
    ce_mem<=0;
    we_mem<=0;
    addr_mem<=0;
    datai_mem<=0;
    
    //reset DUT
    rstn <= 1;    
	#10 rstn=0;
    
    addr = $urandom_range(0,15);
    data = $urandom_range(0,15);
    
    //write operation
    @(posedge clk);
    addr_mem<=addr;
    datai_mem<=data;
    ce_mem<=1;
    we_mem<=1;    
    
    @(posedge clk);
    ce_mem<=0;
    we_mem<=0;    
    
    //read operation
    @(posedge clk);
    addr_mem<=addr;
    ce_mem<=1;
    we_mem<=0;    

    @(posedge clk);
    ce_mem<=0;
    we_mem<=0; 
    out=datao_mem;	//program variable so it is blocking assignment
    
    assert (data == out) $display ("OK. Read data equals Write data");
    else $error("It's gone wrong. Data=%d Out=%d", data, out);
    
    repeat(10) @(posedge clk);
*/
    //Using clocking block
    
    //initalize
    ramcb.ce_mem<=0;
    ramcb.we_mem<=0;
    ramcb.addr_mem<=0;
    ramcb.datai_mem<=0;
    
    //reset DUT
    rstn <= 1;    
	#10 rstn=0;
    
    addr = $urandom_range(0,15);
    data = $urandom_range(0,15);
    
    //write operation
    @(ramcb);
    ramcb.addr_mem<=addr;
    ramcb.datai_mem<=data;
    ramcb.ce_mem<=1;
    ramcb.we_mem<=1;    
    
    @(ramcb);
    ramcb.ce_mem<=0;
    ramcb.we_mem<=0;    
    
    //read operation
    @(ramcb);
    ramcb.addr_mem<=addr;
    ramcb.ce_mem<=1;
    ramcb.we_mem<=0;    

    @(ramcb);
    ramcb.ce_mem<=0;
    ramcb.we_mem<=0; 
    
    repeat(2) @(ramcb);
    //repeat(2) @(posedge clk);
    //##2;
    //#2;
    out=ramcb.datao_mem;	//program variable so it is blocking assignment

    assert (data == out) $display ("OK. Read data equals Write data");
    else $error("It's gone wrong. Data=%d Out=%d", data, out);
    
    repeat(5) @(ramcb);
    
    $finish;
    
  end
 
  
endprogram