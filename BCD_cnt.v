`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/15/2019 08:27:56 PM
// Design Name: 
// Module Name: BCD_cnt
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

module BCD_cnt
#(
    parameter zeci_max = 4'b0101, //Valoare maxima de numarare
    parameter unitati_max = 4'b1001,
    parameter zeci_min = 4'b0000, //Valoare minima la care revine numaratorul
    parameter unitati_min = 4'b0000,
    parameter zeci_reset = 4'b0000, // Aceste valori sunt pentru resetare, le-am adaugat pt ca nu pot reseta orele in 00
                                    // trebuie 12 PM sau AM , dar secundele si minutele sunt resetar
    parameter unitati_reset = 4'b0000
)
(
    input clock,en,reset,
    output[7:0] zeci_si_unitati,
    output ripple_carry_out
);

reg [3:0] zeci = 4'b0000;
reg [3:0] unitati = 4'b0000;

assign zeci_si_unitati[7:4] = zeci;
assign zeci_si_unitati[3:0] = unitati;
assign ripple_carry_out = ((zeci == zeci_max) && (unitati == unitati_max ) && en) ? 1 : 0;

always @(posedge clock,posedge reset) //aici controlam functionarea automata a ceasului
    begin
        if(reset)
            begin
                zeci <= zeci_reset;
                unitati <= unitati_reset;
            end
        else if( en )  
            begin
               if( (zeci == zeci_max) &&  (unitati == unitati_max) )
                    begin
                        zeci <= zeci_min;
                        unitati <= unitati_min;
                    end
               else
                    begin
                        if(unitati == 4'b1001)
                            begin
                                zeci <= zeci + 4'b0001;
                                unitati <= 4'b0000;
                             end   
                        else
                            unitati <= unitati + 4'b0001;
                    end 
             end
             
           
    end     


endmodule
