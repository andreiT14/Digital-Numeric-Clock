`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/15/2019 07:06:53 PM
// Design Name: 
// Module Name: Bloc_div_freq
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


module Bloc_div_freq(
    input clk_FPGA,reset, //clk_FPGA este frecventa 100 MHZ de intrare din FPGA, reset-ul asincron
    output [3:0] clock_circuit_control // clock_circuit_control => bit 3 => clock alarma
                                       //                          bit 2 -> clock afisare
                                       //                          bit 1 -> clock ceas
                                       //                          bit 0 -> clock_increment
    );
    
wire tmp_clock_out; // acesta va fi frecventa etalonului ( 2 Mhz) ceruta in bilet

div_freq_parameter   // divizor pentru frecventa etalonului
#(
    .grad_divizare(50),
    .numar_biti(6)
    
)  CLK_2MHz (
    .clock_in(clk_FPGA),
    .reset(reset),
    .clock_out(tmp_clock_out)
);

div_freq_parameter 
#(
    .grad_divizare(2000),
    .numar_biti(11)
    
)  CLK_1KHz_afisare (
    .clock_in(tmp_clock_out),
    .reset(reset),
    .clock_out(clock_circuit_control[2])
);

div_freq_parameter 
#(
    .grad_divizare(2000000),
    .numar_biti(21)
    
) CLK_1Hz_ceas (
    .clock_in(tmp_clock_out),
    .reset(reset),
    .clock_out(clock_circuit_control[1])
);

div_freq_parameter 
#(
    .grad_divizare(1000000),
    .numar_biti(20)
    
) CLK_2Hz_increment (
    .clock_in(tmp_clock_out),
    .reset(reset),
    .clock_out(clock_circuit_control[0])
);

div_freq_parameter 
#(
    .grad_divizare(667),
    .numar_biti(10)
    
) CLK_3KHz_alarma (
    .clock_in(tmp_clock_out),
    .reset(reset),
    .clock_out(clock_circuit_control[3])
);

endmodule
