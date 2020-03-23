`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/16/2019 11:11:48 PM
// Design Name: 
// Module Name: BCD_to_7sgm
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


module BCD_to_7sgm(
    input [3:0] data_in,
    output reg [7:0]data_7_sgm
);

always @(data_in)
    case(data_in)
        0: data_7_sgm = 8'b1100_0000; // 
        1: data_7_sgm = 8'b1111_1001; // 
        2: data_7_sgm = 8'b1010_0100; // 
        3: data_7_sgm = 8'b1011_0000; // 
        4: data_7_sgm = 8'b1001_1001; // 
        5: data_7_sgm = 8'b1001_0010; // 
        6: data_7_sgm = 8'b1000_0010; // 
        7: data_7_sgm = 8'b1111_1000; // 
        8: data_7_sgm = 8'b1000_0000; // 
        9: data_7_sgm = 8'b1001_0000; // 
        14: data_7_sgm = 8'b0000_1000; //codific pe A + DP
        15: data_7_sgm = 8'b0000__1100; // codific pe P + DP
        default : data_7_sgm = 8'b1111_1111;
    endcase
endmodule
