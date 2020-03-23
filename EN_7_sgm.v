`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/16/2019 10:50:08 PM
// Design Name: 
// Module Name: EN_7_sgm
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

//Aici vom selecta ce segment sa se aprinda, din datasheet reiese faptul ca este logica inversata pentru aprinderea unui segment

module EN_7_sgm(
    input[2:0] select,
    output reg[7:0] sgm_select
);

always @(select)
    begin

        case(select)
            3'b000 : sgm_select = {{6{1'b1}},1'b0,1'b1};  //afisez A / p
            3'b001 : sgm_select = {{5{1'b1}},1'b0,{2{1'b1}}}; //afisez secunde_unitati
            3'b010 : sgm_select = {{4{1'b1}},1'b0,{3{1'b1}}}; //afisez secunde_zeci
            3'b011 : sgm_select = {{3{1'b1}},1'b0,{4{1'b1}}}; //afisez minute_unitati
            3'b100 : sgm_select = {{2{1'b1}},1'b0,{5{1'b1}}};  //afisez minute_zeci
            3'b101 : sgm_select = {1'b1,1'b0,{6{1'b1}}};//afisez ore_unitati
            3'b110 : sgm_select = {1'b0,{7{1'b1}}};//afisez ore_zeci
            default : sgm_select = 4'b1111;
        endcase
    end
endmodule
