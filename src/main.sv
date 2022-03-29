module main
(
    input   CLK100MHZ,
    
    input   [2:0] SW,

    input BTNU, BTND, BTNC,
    
    output  CLK_LED,
    
    output  LED16_R,
    output  LED16_G,
    output  LED16_B,
    
    // The anodes of the rightmost four 7-segment displays 
    output [7:0] AN,
        
    // THe cathods of the 7-segment dispalsy
    output [7:0] SEG
);

    logic pwm_clk;
    
    logic [7:0] red = 200;
    logic [7:0] green = 100;
    logic [7:0] blue = 100;

    logic one = 1;
    
    logic is_up;
    logic is_down;
    logic is_ctr;

    // A 100 kHz clock for feeding to the PWM
    clock_div#(100000) u1(CLK100MHZ, pwm_clk);

    // This displays a value on a four-digit 7-segment display
    four_digit_display u_fdd
    (
        .i_clk(CLK100MHZ),
        .four_digit_display_tvalue(red),
        .four_digit_display_tvalid(one),
        .o_cathode(SEG),
        .o_anode(AN[3:0])
    );
    
    pwm u_red(pwm_clk, red,    LED16_R);
    pwm u_grn(pwm_clk, green,  LED16_G);
    pwm u_blu(pwm_clk, blue,   LED16_B);
    
    button u_up  (CLK100MHZ, BTNU, is_up  );
    button u_ctr (CLK100MHZ, BTNC, is_ctr );
    button u_down(CLK100MHZ, BTND, is_down);
     
    assign CLK_LED = pwm_clk;
    
    always @(posedge CLK100MHZ) begin
        if (is_ctr) begin
            red   <= 0;
            green <= 0;
            blue  <= 0;
        end
            
        if (is_up) begin
            if (SW[0]) begin
                if (red < 250) red <= red + 10;
            end
            
            if (SW[1]) begin
                if (green < 250) green <= green + 10;
            end

            if (SW[2]) begin
                if (blue < 250) blue <= blue + 10;
            end
        end

        if (is_down) begin
            if (SW[0]) begin
                if (red >= 10) red <= red - 10;
            end
            
            if (SW[1]) begin
                if (green >= 10) green <= green - 10;
            end

            if (SW[2]) begin
                if (blue >= 10) blue <= blue - 10;
            end
        end

          
    end
    
    // Turn off the upper four digits of the display   
    assign AN[7:4] = 4'b1111;

endmodule


