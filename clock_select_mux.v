`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/16/2019 01:45:06 PM
// Design Name: 
// Module Name: clock_select_mux
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


module clock_select_mux(
    input sel_clock,
    input in_0,in_1,
    output reg clock_out
);

always @(sel_clock,in_0,in_1)
    case(sel_clock)
        0 : clock_out = in_0;   
        1:  clock_out = in_1;
        default : clock_out = 0;
     endcase
     
     
endmodule
