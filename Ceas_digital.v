`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/17/2019 10:27:39 AM
// Design Name: 
// Module Name: Ceas_digital
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


module Ceas_digital(
    input set_FSM,increment,start,reset,clock_FPGA,
    output [7:0] data_7sgm,
    output [7:0] EN_7sgm,
    output LED
    );
    
//NET set_FSM CLOCK_DEDICATED_ROUTE = FALSE;
//wire db_set_FSM,db_start,db_increment;
wire[3:0] tmp_clock_circuit;
wire[15:0] tmp_data_control;
wire[24:0]tmp_data_afisare;
wire tmp_set_minute; 
wire tmp_set_ore;
wire tmp_clock_numarator;
wire tmp_alarm_bit;

/*debounce_buttons M5(
    .set(set_FSM),
    .increment(increment),
    .start(start),
    .clock(tmp_clock_circuit[2]),
    .reset(reset),
    .db_set(db_set_FSM),
    .db_increment(db_increment),
    .db_start(db_start)
);*/
Bloc_div_freq M1(
    .clk_FPGA(clock_FPGA),
    .reset(reset),
    .clock_circuit_control(tmp_clock_circuit)
);   

Bloc_control M2(
    .clock_increment(tmp_clock_circuit[0]),
    .clock_ceas(tmp_clock_circuit[1]),
    .start(start),
    .set(set_FSM),
    .reset(reset),
    .data_in(tmp_data_control),
    .set_minute(tmp_set_minute),
    .set_ore(tmp_set_ore),
    .clock_out(tmp_clock_numarator),
    .alarm_bit(tmp_alarm_bit)
);

Bloc_numarator M3(
    .clock(tmp_clock_numarator),
    .reset(reset),
    .start(start),
    .increment(increment),
    .set_minute(tmp_set_minute),
    .set_ore(tmp_set_ore),
    .data_out_control(tmp_data_control),
    .data_out_afisare(tmp_data_afisare)
);

Bloc_afisare M4(
    .data_in(tmp_data_afisare),
    .clock_afisare(tmp_clock_circuit[2]),
    .clock_alarm(tmp_clock_circuit[3]),
    .reset(reset),
    .alarm_bit(tmp_alarm_bit),
    .afis_7sgm(data_7sgm),
    .EN_to_7sgm(EN_7sgm),
    .LED(LED)
);   
 
endmodule
