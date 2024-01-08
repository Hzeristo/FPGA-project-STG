`timescale 1ns / 1ps

module moon_tb();

  reg clk, reset;
  reg [9:0] player_x, player_y, x, y;
  reg [25:0] speed_offset;
  wire [9:0] moon_x, moon_y;
  wire moon_on;
  wire [11:0] rgb_out;

  moon uut (
    .clk(clk),
    .reset(reset),
    .player_x(player_x),
    .player_y(player_y),
    .x(x),
    .y(y),
    .speed_offset(speed_offset),
    .moon_x(moon_x),
    .moon_y(moon_y),
    .moon_on(moon_on),
    .rgb_out(rgb_out)
  );

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    reset = 0;
    player_x = 300;
    player_y = 400;
    x = 300;
    y = 400;
    speed_offset = 0;
  end

endmodule
