`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/15/2019 09:14:49 PM
// Design Name: 
// Module Name: control_en
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module control_en(
     input start_in,rco_in,set,increment,
     output out_to_en
    );
    
assign out_to_en = (start_in & rco_in) | (set & increment);
    
endmodule
