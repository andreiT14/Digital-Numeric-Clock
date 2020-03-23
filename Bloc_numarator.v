`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/15/2019 08:45:09 PM
// Design Name: 
// Module Name: Bloc_numarator
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

// Aici vom implementa blocul numarator.
// Semnalele de iesire sunt : data_out [24] = AM {0} / PM{1}
//                            data_out [23:20] = ore_zeci;
//                            data_out [19:16 ] = ore_unitati;
//                            data_out [15:12] = min_zeci;
//                            data_out [11:8] = min_unitati;
//                            data_out [7:4] = secunde_zeci;
//                            data_out [3:0] = secunde_unitati;

module Bloc_numarator(
    input clock,reset,start,increment,set_minute,set_ore,
    output [15:0] data_out_control,
    output[24:0] data_out_afisare
);

wire tmp_rco_sec,tmp_rco_min,tmp_rco_ore;
wire tmp_en_min,tmp_en_ore;
wire[24:0] tmp_data;
wire reset_secunde; //acesta se activeaza cand vrem sa setam ceasul, numaratoarea secundelor sa inceapa de la 0
assign data_out_control = tmp_data[15:0]; //Iesire spre blocul de control,am nevoie doar de minute si secunde pentru alarma la ora fixa
assign data_out_afisare = tmp_data[24:0]; // Iesire pe care o folosesc doar la afisare, nu am nevoie de secunde,am nevoie doar de PM, ore si min
assign reset_secunde = set_minute | reset; 
BCD_cnt #(
    .zeci_max(4'b0101),
    .unitati_max(4'b1001),
    .zeci_min(4'b0000),
    .unitati_min(4'b0000),
    .zeci_reset(4'b0000),
    .unitati_reset(4'b0000)
) BCD_SECUNDE (
    .clock(clock),
    .en(start),
    .reset(reset_secunde),
    .zeci_si_unitati(tmp_data[7:0]),
    .ripple_carry_out(tmp_rco_sec)
);

control_en EN_BCD_MINUTE(
    .start_in(start),
    .rco_in(tmp_rco_sec),
    .set(set_minute),
    .increment(increment),
    .out_to_en(tmp_en_min)
);  

BCD_cnt #(
    .zeci_max(4'b0101),
    .unitati_max(4'b1001),
    .zeci_min(4'b0000),
    .unitati_min(4'b0000),
    .zeci_reset(4'b0000),
    .unitati_reset(4'b0000)
) BCD_MINUTE (
    .clock(clock),
    .en(tmp_en_min),
    .reset(reset),
    .zeci_si_unitati(tmp_data[15:8]),
    .ripple_carry_out(tmp_rco_min)
);

control_en EN_BCD_ORE(
    .start_in(start),
    .rco_in(tmp_rco_min),
    .set(set_ore),
    .increment(increment),
    .out_to_en(tmp_en_ore)
);

BCD_cnt #(
    .zeci_max(4'b0001),
    .unitati_max(4'b0010),
    .zeci_min(4'b0000),
    .unitati_min(4'b0001),
    .zeci_reset(4'b0001),
    .unitati_reset(4'b0010)
) BCD_ORE (
    .clock(clock),
    .en(tmp_en_ore),
    .reset(reset),
    .zeci_si_unitati(tmp_data[23:16]),
    .ripple_carry_out(tmp_rco_ore)
); 

generate_AM_PM AM_PM(   //module pentru generarea lui AM/PM , la intrare am doar datele orei tmp_data
    .clock(clock),
    .reset(reset),
    .set_ore(set_ore),
    .data_in(tmp_data[23:0]),
    .AM_PM_bit(tmp_data[24])
);        
endmodule
