`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/16/2019 01:38:45 PM
// Design Name: 
// Module Name: Bloc_control
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


module Bloc_control(
    input clock_increment,clock_ceas,start,set,reset,
    input [15:0] data_in,
    output set_minute,set_ore,clock_out,alarm_bit
);

wire tmp_clk_select;

clock_select_mux D1(
    .sel_clock(tmp_clk_select),
    .in_0(clock_ceas),
    .in_1(clock_increment),
    .clock_out(clock_out)
);

FSM_control D2(
    .start(start),
    .reset_from_start(start),
    .reset(reset),
    .set(set),
    .set_minute(set_minute),
    .set_ore(set_ore),
    .clk_select(tmp_clk_select)    
);

//Mai jos am creat bitul pentru alarma, ce este activ pentru 2 secunde cand minutele sunt 00 si secundele sunt 00 si 01. 
//Totul se petrece atunci cand bitul start = 1(ceasul nu este in modul de setare => start=0 )
assign alarm_bit = ((!(data_in[15:8] | data_in[7:0])) | (!(data_in[15:8] | data_in[7:1] | (!data_in[0])))) & start;  
//Cu acest bit , vom face o poart Si in afisare si activam clock-ul de alarma
endmodule
