`timescale 1ns/1ns

module hecatia_tb;

  reg clk, reset, is_hit;
  reg [9:0] x, y;
  reg [25:0] speed_offset;
  wire [9:0] hecatia_x, hecatia_y;
  wire hecatia_on, die;
  wire [11:0] rgb_out;
  wire [7:0] health;

  hecatia hecatia_inst (
    .clk(clk),
    .reset(reset),
    .x(x),
    .y(y),
    .speed_offset(speed_offset),
    .is_hit(is_hit),
    .hecatia_x(hecatia_x),
    .hecatia_y(hecatia_y),
    .hecatia_on(hecatia_on),
    .rgb_out(rgb_out),
    .health(health),
    .die(die)
  );

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    reset = 0;
    x = 190;
    y = 100;
    speed_offset = 0;
    is_hit = 0;


    #100;
    is_hit = 0;
    #500;

    is_hit = 1;
    #50000000;

    is_hit = 0;


  end

endmodule
