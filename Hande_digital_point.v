`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/16/2019 11:17:24 PM
// Design Name: 
// Module Name: Handle_digital_point
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

//Cu acest modul adaug DP pentru ceas prin intermediul counter-ului pentru afisare.
module Handle_digital_point(
    input [7:0] data_to_7sgm,
    input [2:0] select,
    output reg [7:0] put_to_7sgm
);

always @(select,data_to_7sgm)
     case(select)
        3'b011: put_to_7sgm = data_to_7sgm & 8'b0111_1111; // Cand ajung sa afisez minute_unitati adaug si digital point pentru cele doua puncte de la ceas
        3'b101: put_to_7sgm = data_to_7sgm & 8'b0111_1111; // Cand ajung sa afisez ore_unitati adaug si digital point pentru cele doua puncte de la ceas
        default : put_to_7sgm = data_to_7sgm; //Daca nu sunt pentru afisare minute_unitati nu adaug DP
     endcase
endmodule
