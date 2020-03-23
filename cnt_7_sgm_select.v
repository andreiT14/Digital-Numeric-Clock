`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/16/2019 10:53:16 PM
// Design Name: 
// Module Name: cnt_7_sgm_select
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


// Cu ajutorul acestui counter selectez ce parte din ore,secunde si unitati sa afisez. Acest modul coordoneaza si preluarea datei de la numarator,
//decodificarea acestora si afisare
module cnt_7_sgm_select
#(  
    parameter cnt_max = 3'b100, //aici am introdus capetele de numarare max si minim
    parameter cnt_min = 3'b000
)
(
    input reset,clock,
    output [2:0] select_afisare //iesire pentru controlul celorlalte circuite 
);

reg [2:0] tmp_select_afisare = cnt_min;

assign select_afisare = tmp_select_afisare;

always @(posedge clock, posedge reset)
    if(reset)
        tmp_select_afisare <= cnt_min;
    else if(clock)
            if (tmp_select_afisare == cnt_max)
                tmp_select_afisare <= cnt_min;
            else
                tmp_select_afisare <= tmp_select_afisare + 1'b1;
endmodule
