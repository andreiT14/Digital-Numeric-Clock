`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/16/2019 01:26:29 PM
// Design Name: 
// Module Name: FSM_control
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

module FSM_control(
    input start,reset_from_start,reset,set,
    output reg set_minute,set_ore,clk_select
);

localparam numara = 2'b00;
localparam setare_minute = 2'b01;
localparam setare_ore = 2'b10;

reg [1:0]stare_curenta = numara ;
reg [1:0]stare_viitoare;

always @(start,stare_curenta)
    begin
        case(stare_curenta)
            numara : if(!start)
                            stare_viitoare = setare_minute;
                      else
                            stare_viitoare = numara;
            setare_minute:  if(!start)
                                stare_viitoare = setare_ore;
                             else
                                 stare_viitoare = numara;
            setare_ore : if(!start)
                            stare_viitoare = setare_minute;
                         else
                            stare_viitoare = numara;
            default : stare_viitoare = numara;           
         endcase
      end
  
always @(posedge set,posedge reset_from_start, posedge reset)
    begin
        if(reset || reset_from_start)
           stare_curenta <= numara;
        else if (set)
            stare_curenta <= stare_viitoare;        
    end
always @(stare_curenta)
    begin
        case(stare_curenta)
            numara : begin 
                        clk_select = 0;
                        set_minute = 0;
                        set_ore = 0;
                      end
            setare_minute : begin 
                                clk_select = 1;
                                set_minute = 1;
                                set_ore = 0;
                            end
            setare_ore : begin 
                             clk_select = 1;
                             set_minute = 0;
                             set_ore = 1;
                         end                            
           default : begin 
                           clk_select = 0;
                           set_minute = 0;
                           set_ore = 0;
                       end   
         endcase                              
     end
endmodule
