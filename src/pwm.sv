`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/28/2022 12:40:13 PM
// Design Name: 
// Module Name: pwm
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


module pwm
(
    input i_clk,
    input [7:0] i_duty_cycle,
    output o_wire
);

    logic [7:0] counter = 0;
    logic r_wire = 0;

    always @(posedge i_clk) begin
        r_wire = (counter < i_duty_cycle) ? 1 : 0;
        counter <= counter + 1;
    end
    
    assign o_wire = r_wire;
    
endmodule
