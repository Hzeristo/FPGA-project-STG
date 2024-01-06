module moon(
    input clk, reset,
    input [9:0] player_x, player_y,
    input [9:0] x, y, 
    input [25:0] speed_offset,
    output [9:0] moon_x, moon_y,
    output moon_on,
    output [11:0] rgb_out
);

localparam MAX_X = 640,
localparam MAX_Y = 480;


endmodule