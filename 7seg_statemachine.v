`timescale 1ms/1us

module seven_segment_driver(
input clock,
input reset,
input button,
output wire [6:0] seg1,
output wire [6:0] seg10
);

reg [6:0] value;
reg [17:0] debounce;
wire [3:0] tens;
wire [3:0] ones;
wire max_num;
wire input_open;
wire debounce_cnt_low;

seven_segment_decode seven_segment_decode_u_tens(
    .value(tens),
    .segment(seg10)
);

seven_segment_decode seven_segment_decode_u_ones(
    .value(ones),
    .segment(seg1)
);

initial
begin
    debounce = 18'b000000000000000000;
    value = 6'b000000;
end


always@(posedge clock or posedge reset)
    begin
        if (reset) begin
            value <= 1'b0;  // as next desired num is 1, go straight to 1 instead of 0
            debounce <= 18'b000000000000000000;  // reset the debounce counter
        end
        
        else begin
            // value increment logic
            if (max_num) value <= 7'h00;
            else if (input_open) value <= value + 1'b1;

            // debounce logic
            if (button == 1'b0) debounce <= 18'b000000000000000000;
            else if (debounce < 18'b111111111111111111) debounce <= debounce + 1'b1;
        end
    end


assign input_open = button & (debounce == 18'b111111111111111110);
assign debounce_cnt_low = button & (debounce < 18'b111111111111111110);
assign max_num = (value == 7'b1100100);
assign tens = value/10;  // no need to floor as integer only
assign ones = value % 10;  // ditto

endmodule