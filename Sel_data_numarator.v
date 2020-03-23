`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/16/2019 10:23:04 PM
// Design Name: 
// Module Name: Sel_data_numarator
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
// Semnalele de intrare sunt : data_in [16] = AM {0} / PM{1}
//                            data_in [15:12] = ore_zeci;
//                            data_in [11:8 ] = ore_unitati;
//                            data_in [7:4] = min_zeci;
//                            data_in [3:0] = min_unitati;

module Sel_data_numarator(
    input[2:0] select,
    input[24:0] data_in,
    output reg [3:0] data_out
);
 //In acest modul , selectez ce intrare de date voi transmite la decodificatorul BCD 7 segmente.
 //Intrarea(data_in) in acest bloc vine de la blocul numarator. Practic pe intrare(data_in) am afisajul cu ora(ore,minute,secunde) si AM/PM codificat cu A / P
 always @(select,data_in)
    begin
        case(select)
            3'b000 : data_out = {{3{1'b1}},data_in[24]}; //out = 111,AM_PM => 14 = A , 15 = P
            3'b001 : data_out = data_in[3:0]; //out = secunde_unitati
            3'b010 : data_out = data_in[7:4]; //out = secunde_zeci
            3'b011 : data_out = data_in[11:8]; // out = min_unitati
            3'b100 : data_out = data_in[15:12] ; //out = min_zeci
            3'b101 : data_out = data_in[19:16]; //out = ore_unit
            3'b110 : data_out = data_in[23:20]; //out = ore_zeci
            default : data_out = 4'b0000;
        endcase    
    end
endmodule
