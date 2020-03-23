`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/06/2019 08:05:52 PM
// Design Name: 
// Module Name: debounce_button
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

 // In acest bloc facem partea de debounce pentru butoane
 
module debounce_buttons(
    input set,increment,start,clock,reset,
    output db_set,db_increment,db_start
);
   
reg [9:0] set_debounce_buffer;  
reg [9:0] increment_debounce_buffer;
reg [9:0] start_debounce_buffer;

assign db_set = set_debounce_buffer == {10{1'b1}} ? 1'b1 : 1'b0 ;
assign db_increment = increment_debounce_buffer == {10{1'b1}} ? 1'b1 : 1'b0 ;
assign db_start = start_debounce_buffer == {10{1'b1}} ? 1'b1 : 1'b0 ;
always @(posedge clock,posedge reset)
    begin
        if(reset)
            set_debounce_buffer <= {10{1'b0}};
         else if(clock)
                set_debounce_buffer <= {set_debounce_buffer[8:0],set};
    end  
               
 always @(posedge clock,posedge reset)
    begin
        if(reset)
            increment_debounce_buffer <= {10{1'b0}};
         else if(clock)
                increment_debounce_buffer <= {set_debounce_buffer[8:0],increment};
    end
    
always @(posedge clock,posedge reset)
    begin
        if(reset)
            start_debounce_buffer <= {10{1'b0}};
         else if(clock)
                start_debounce_buffer <= {set_debounce_buffer[8:0],start};
    end                         
            
    
endmodule
