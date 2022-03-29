`timescale 1ns / 1ps
`define SYSCLOCK_FREQ 100000000

//======================================================================================================================
// pos_edge_detector() - Detects highgoing edges of a pin (for instance, a button)
//
// Input:  clk = system clock
//         pin = the pin to look for a high-going edge on
//
// Output:  q = 1 if a high-going edge is detected, otherwise 0
//
// Notes: edge detection is fully debounced.  q only goes high if a specified pin is still high
//        10ms after the high-going edge was initially detected 
//======================================================================================================================
module button(input clk, input pin, output q);
    
    parameter [31:0] DEBOUNCE_PERIOD = `SYSCLOCK_FREQ / 200;

    reg previous_pin_state = 0;
    reg [31:0] debounce_clock = 0;
    reg edge_detected = 0;    
    
    // We're going to check for edges on every clock cycle
    always @(posedge clk) begin
                
        edge_detected <= 0;       
        
        // If the debounce clock is about to expire, find out of the user-specicied pin is still high
        if (debounce_clock == 1) begin
            edge_detected <= pin;
            debounce_clock <= 0;
        end
        
        // Otherwise, the debounce clock is still counting down, decrement it
        else if (debounce_clock != 0) begin
            debounce_clock <= debounce_clock - 1;
        end  
        
        // If the pin is high and was previously low, start the debounce clock
        if (pin & ~previous_pin_state) debounce_clock <= DEBOUNCE_PERIOD;
        
        // The 'previous_pin_state" register gets the current state of the pin for 
        // use during the next clock cycle`
        previous_pin_state <= pin;
    end
    
    // The output wire always reflects the state of the 'edge_detected' register
    assign q = edge_detected;
    
endmodule
//======================================================================================================================

