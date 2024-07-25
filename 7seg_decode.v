`timescale 1ms/1us

module seven_segment_decode(
input wire [3:0] value,
output reg [6:0] segment
);

localparam zero = 7'b0111111;  // g = 0, ... b = 1 , a = 1
localparam one = 7'b0110000;
localparam two = 7'b1011011;
localparam three = 7'b1001111;
localparam four = 7'b1100110;
localparam five = 7'b1101101;
localparam six = 7'b1111101;
localparam seven = 7'b0000111;
localparam eight = 7'b1111111;
localparam nine = 7'b1101111;
localparam error = 7'b1000000;

always@* begin
    if (value == 0) segment = zero;
    else if (value == 1) segment = one;
    else if (value == 2) segment = two;
    else if (value == 3) segment = three;
    else if (value == 4) segment = four;
    else if (value == 5) segment = five;
    else if (value == 6) segment = six;
    else if (value == 7) segment = seven;
    else if (value == 8) segment = eight;
    else if (value == 9) segment = nine;
    else segment <= error;
end

endmodule
