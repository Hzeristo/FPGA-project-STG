`timescale 1ns/1ns

module judge_collision_tb();

  reg clk, rst;
  reg [9:0] player_x, player_y;
  reg [9:0] moon_x, moon_y;
  reg [9:0] hecatia_x, hecatia_y;
  wire collision;

  judge_collision uut (
    .clk(clk),
    .rst(rst),
    .player_x(player_x),
    .player_y(player_y),
    .moon_x(moon_x),
    .moon_y(moon_y),
    .hecatia_x(hecatia_x),
    .hecatia_y(hecatia_y),
    .collision(collision)
  );

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end
  initial begin
    rst = 1;
    player_x = 0;
    player_y = 0;
    moon_x = 0;
    moon_y = 0;
    hecatia_x = 0;
    hecatia_y = 0;

    #10 rst = 0;
    player_x = 50;
    player_y = 50;
    moon_x = 100;
    moon_y = 100;
    hecatia_x = 200;
    hecatia_y = 200;
    #20 player_x = 210;
    player_y = 210;
    moon_x = 100;
    moon_y = 100;
    hecatia_x = 200;
    hecatia_y = 200;
    #20 player_x = 50;
    player_y = 50;
    moon_x = 50;
    moon_y = 50;
    hecatia_x = 200;
    hecatia_y = 200;
    #20 player_x = 50;
    player_y = 50;
    moon_x = 50;
    moon_y = 105;
    #20 player_x = 50;
    player_y = 50;
    moon_x = 105;
    moon_y = 50;
    #20 player_x = 50;
    player_y = 50;
    moon_x = 92;
    moon_y = 98;


  end


endmodule
