`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: Ozyegin University
// Engineer:  Mustafa Ghanim & Emre Aydin Guzel
//
// Create Date:   18:25:01 02/08/2021
// Design Name:   generic_multiplier
// Module Name:   E:/My Google Drive/OZU/Fall 2019/FPGA Course/generic_multiplier/generic_multiplier_tb.v
// Project Name:  generic_multiplier
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: generic_multiplier
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module generic_multiplier_tb;

	parameter WIDTH = 128;
	parameter PERIOD = 20;
	parameter LOAD_CYCLE = PERIOD * WIDTH;
	parameter DUTY_CYCLE = PERIOD/2;
	// Inputs
	reg load;
	reg clk;
	reg rst;
	reg [WIDTH-1:0] in0;
	reg [WIDTH-1:0] in1;

	// Outputs
	wire [2*WIDTH - 1:0] out;
	wire valid;
	integer i = 0 ;

	// Instantiate the Unit Under Test (UUT)
	generic_multiplier uut (
		.load(load), 
		.clk(clk), 
		.rst(rst), 
		.in0(in0), 
		.in1(in1), 
		.out(out), 
		.valid(valid)
	);

	initial begin
		// Initialize Inputs
		load = 0;
		clk = 0;
		rst = 1;
		in0 = 10;
		in1 = 12;

		// Wait 90 ns for global reset to finish
		#90;
		rst = 0;




		
		
        
		// Add stimulus here

	end
	
	always begin
		#DUTY_CYCLE	
		clk = ~clk;
		i = i + 1;

	
	end
	always begin
		#PERIOD;
		if(valid) begin
			if(out == (in0 * in1)) $display("Your output is correct");
			else $display("Your output is incorrect");
			$display("Your First Input = %h",in0);
			$display("Your Second Input = %h",in1);
			$display("Your Output  = %h",out);
			#PERIOD;
			#PERIOD;
	
			load = 1;
			in0 = $random%10000;
			in1 = $random%10000;
			#PERIOD;
			load = 0;
		

		end	
	
	
	
	
	end
      
endmodule

