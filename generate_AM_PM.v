`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/16/2019 12:04:36 PM
// Design Name: 
// Module Name: generate_AM_PM
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


module generate_AM_PM(
    input clock,reset,set_ore,
    input [23:0] data_in, //data_in[23:16] = ore,  data_in[15:8] = min,  data_in[7:0] = sec
    output AM_PM_bit
);
 
 localparam AM = 1'b0;  //Voi hotara ca bitul sa aiba AM = 0 si PM = 1
 localparam PM = 1'b1; 
  
 reg tmp_AM_PM = AM;
 reg verificator_stare; //Acest reg a fost adaugat datorita faptului ca atunci cand sunt in setare ceas, pe cifra 11 mereu se
                        //schimba AM -> PM si invers cu frecventa ceasului
 assign AM_PM_bit = tmp_AM_PM;
  
 always @(posedge clock, posedge reset)  // Daca data din ore ajunge la valoarea 12:00:00 comanda schimbarea bitului de AM si PM, dar in acelasi timp, la reset revine pe AM
        begin
            if(reset)
                begin
                    tmp_AM_PM <= AM;
                    verificator_stare <= 1; //L-am facut 1 pentru ca nu vreau ca dupa ce dau reset si apas setare ore sa mi
                                            // se schimbe configuratia AM , vreau sa ramana asa pana cand ajung eu cu incrementarea in 12.
                                            //Acest bit se va face 1 dupa ce ies din cifra 12 de la ore si sunt pe setare ore.
                end   
            else
                begin 
                    if(clock && (data_in[23:16] != 8'h12) && (set_ore == 1'b1))
                        verificator_stare <= 0;
                    if( clock && (data_in[23:16] == 8'b0001_0010) && (set_ore == 1) && (verificator_stare == 0) ) 
                        //in acest if schimb AM/PM doar cand sunt in mod setare ceas(setare pe ore) si verficatorul este pe 0
                        //Cand verificator intra , se face 1 , dar intra doar o data la cifra 11 si dupa nu mai intra, asteapta
                        //ca ceasul sa intre in modul normal de functionare
                        begin
                            verificator_stare <= 1;
                            case(tmp_AM_PM) 
                                1'b0 : tmp_AM_PM <= PM;
                                1'b1 : tmp_AM_PM <= AM;
                            endcase
                        end
                    if( clock && (data_in[23:16] == 8'b0001_0001) && (data_in[15:8] == 8'b0101_1001) && (data_in[7:0] == 8'b0101_1001) && (set_ore == 0) )
                        begin
                            verificator_stare <= 0;
                            case(tmp_AM_PM) 
                              1'b0 : tmp_AM_PM <= PM;
                              1'b1 : tmp_AM_PM <= AM;
                             endcase
                        end     
                end               
        end 
        
endmodule
