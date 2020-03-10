clock cb @(posedge clk)
	default input #0
			output #1step;
endclocking
Here the 'input' represents the Out signal of the design. #0 skew will drive the output at the same time of clocking event in the NBA region.
Here the 'output' represents the Input signal of the design. #1step will sample the signal immediately before the clock edge.

'Always' block cannot reside inside program block.
'Always' block gets schedule inside active region where the RTL block is scheduled. Program block lives in the reactive region.
   #10 is just 10 time units.
   ##10 and repeat(10) @(cb) both are similar. Example if they have clock period of 20ns. Then ##10=190ns.
   Default clocking block clock value is used when you use ##10. Otherwise what ever the clocking block is mentioned is used.
   repeat(1) @(cb) = 0 cb time units for its clock 
   repeat(2) @(cb) = 1 cb time units for its clock

