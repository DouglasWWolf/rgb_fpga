`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/28/2022 11:58:52 AM
// Design Name: 
// Module Name: clock_div
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


module clock_div#(parameter FREQUENCY=100000000) (input clk_in, output clk_out);
    
    logic [31:0] counter = 0;
    logic r_clk = 0;
    localparam LIMIT  =  100000000 / 2 / FREQUENCY;

    always @(posedge clk_in) begin
        if (counter == LIMIT) begin
            counter <= 0;
            r_clk <= ~r_clk;
        end
        else
            counter <= counter + 1;
    end

    assign clk_out = r_clk;
endmodule
