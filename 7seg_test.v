`timescale 1ms/1ns

module seven_segment_driver_tb;
reg clk;
reg button;
reg reset;
wire [6:0] seg1;
wire [6:0] seg10;

seven_segment_driver seven_segment_driver_u(
    .clock(clk),
    .reset(reset), 
    .button(button),
    .seg1(seg1),
    .seg10(seg10)
);

initial begin
    forever begin
    clk = 0;
    #833ns ;
    clk = ~clk;
    #833ns;
    end 
end

initial begin
    button = 1'b0;
    reset = 1'b0;
    #1ms;
    reset = 1'b1;
    #1ms;
    reset = 1'b0;
    #1ms;
for(int i = 0; i < 101; i++)
    begin
        #500us;
        button = 1'b1;
        #500us;
        button = 1'b0;
        #50us;
        button = 1'b1;
        #50us;
        button = 1'b0;
        
        #50us;
        button = 1'b1;
        
        #500000us;
        button = 1'b0;
        #100us;
        button = 1'b1;
        #50us;
        button = 1'b0;
        #50us;
        button = 1'b1;

        #30us;
        button = 1'b0;
    end
    #50us;
    reset = 1'b1;
    #50us;
    reset = 1'b0;
    $finish;
end

endmodule
