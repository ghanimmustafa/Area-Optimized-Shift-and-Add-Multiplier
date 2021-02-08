`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Ozyegin University
// Engineer: Mustafa Ghanim & Emre Aydin Guzel
// 
// Create Date:    18:20:27 02/08/2021 
// Design Name: 
// Module Name:    generic_multiplier 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//


// shift and add sync. multiplier that uses shift registers and 128-bit adder
// we can implement 128-bit adder instead of 256-bit adder( at the normal case) if we locate
// what output bits are corresponding to the current addition operation
// the final result will appear after 128 clock cycle making the valid signal HIGH

module generic_multiplier(load,clk,rst,in0,in1,out,valid);
parameter WIDTH = 128;
input clk,rst,load;
input [WIDTH -1:0] in0,in1;
output reg [WIDTH*2 -1 :0] out;
reg [WIDTH*2 -1:0] outNxt;
output reg valid;
reg validNxt;
reg [7:0] cnt,cntNxt;
reg [WIDTH -1:0] in0_shiftRegNxt,in0_shiftReg;
wire [WIDTH :0] sum;
reg [WIDTH -1:0] A_add,B_add,A_addNxt,B_addNxt;

assign sum =  A_add + B_add;

always@(posedge clk)begin
	A_add <=  #1 A_addNxt;
	B_add <=  #1 B_addNxt;
	cnt <=  #1 cntNxt;
	out <=  #1 outNxt;
	in0_shiftReg <= #1 in0_shiftRegNxt;
	valid <= #1 validNxt;
end

always@(*)begin
		
	A_addNxt = A_add;
	outNxt = out;
	cntNxt = cnt;
	B_addNxt = B_add;
	validNxt = valid;
	in0_shiftRegNxt = in0_shiftReg;	
	if(rst || load )begin
		in0_shiftRegNxt = in0;
		B_addNxt = 0;
		outNxt = 0;
		validNxt = 0;
		cntNxt = 0;
		A_addNxt = 0;
	end else begin

		if(!valid) begin
			A_addNxt = in0_shiftReg[0] ? in1:0;
			in0_shiftRegNxt = in0_shiftReg >> 1;
			cntNxt = cnt + 1;
			outNxt = out >> 1;
			outNxt[WIDTH*2 - 1 :WIDTH -1 ] = sum;
			B_addNxt = outNxt[WIDTH*2 - 1:WIDTH];
		end	
		if(cnt == WIDTH) begin
			validNxt = 1;
		end	
			
	end	
end

endmodule 