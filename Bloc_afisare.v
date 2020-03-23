`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/16/2019 04:11:59 PM
// Design Name: 
// Module Name: Bloc_afisare
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


module Bloc_afisare(
    input[24:0] data_in,
    input clock_afisare,clock_alarm,alarm_bit,reset,
    output [7:0] afis_7sgm,
    output [7:0] EN_to_7sgm,
    output LED
);

wire[2:0] tmp_select_sgm;
wire[3:0] tmp_BCD_data;
wire[7:0] tmp_data_7sgm;

assign LED = clock_alarm & alarm_bit;

cnt_7_sgm_select 
#(
    .cnt_max(3'b110), // numarator pentru atatea afisaje pe care vreau sa afisez valorile ceasului
    .cnt_min(3'b000)
) M1 (
    .clock(clock_afisare),
    .reset(reset),
    .select_afisare(tmp_select_sgm)
);

Sel_data_numarator M2(
    .select(tmp_select_sgm),
    .data_in(data_in),
    .data_out(tmp_BCD_data)
);

EN_7_sgm M3(
    .select(tmp_select_sgm),
    .sgm_select(EN_to_7sgm)
);

BCD_to_7sgm M4(
    .data_in(tmp_BCD_data),
    .data_7_sgm(tmp_data_7sgm)
);

Handle_digital_point M5(
    .data_to_7sgm(tmp_data_7sgm),
    .select(tmp_select_sgm),
    .put_to_7sgm(afis_7sgm)
);    
endmodule
