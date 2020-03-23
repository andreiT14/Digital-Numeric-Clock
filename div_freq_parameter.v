`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/15/2019 07:03:59 PM
// Design Name: 
// Module Name: div_freq_parameter
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


module div_freq_parameter
#(
    parameter grad_divizare = 10, // gradul de divizare = frecventa de intrare / frecventa dorita la iesire
    parameter numar_biti = 20 //numarul de biti pentru reprezentarea gradului de divizare
)
(
    input clock_in,reset,
    output reg clock_out
 );
localparam VCC = 1'b1;
localparam GND = 1'b0; 
reg[numar_biti - 1:0] counter = {numar_biti{GND}};

always @(posedge clock_in,posedge reset)
    begin
        if(reset)
            counter <= {numar_biti{GND}};
        else if( counter == grad_divizare - 1)
                begin
                    counter <= {numar_biti{GND}};
                    clock_out <= 1'b1;
                end    
             else
                begin
                    if( counter == (grad_divizare - 1)/2 )
                        clock_out <= 1'b0;
                        
                    counter <= counter + 1'b1;
                end
    end

endmodule
