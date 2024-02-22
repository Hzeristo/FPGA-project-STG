`timescale 1ns/1ps

module FSM_tb();

  reg clk, hard_reset, enter, bomb, collision, die;
  wire [3:0] num_bomb;
  wire [3:0] num_life;
  wire [3:0] game_state;
  wire game_en, game_reset;

  FSM uut (
    .clk(clk),
    .hard_reset(hard_reset),
    .enter(enter),
    .bomb(bomb),
    .collision(collision),
    .die(die),
    .num_bomb(num_bomb),
    .num_life(num_life),
    .game_state(game_state),
    .game_en(game_en),
    .game_reset(game_reset)
  );

  initial begin
    clk = 0;
    forever begin
        #5; clk = ~clk; 
    end
  end
  
  initial begin
    hard_reset = 0;
    enter = 0;
    bomb = 0;
    collision = 0;
    die = 0;
    #22000; enter = 1;
    #100; enter = 0;
    #100; bomb = 1;
    #100; bomb = 0; 
    #50000; bomb = 1;
    #100; bomb = 0; 
    #50000; bomb = 1;
    #100; bomb = 0; 
    #50000; bomb = 1;
    #100; bomb = 0; 

    #100; collision = 1;
    #100; collision = 0; 
    #50000; collision = 1;
    #100; collision = 0; 
    #50000; collision = 1;
    #100; collision = 0; 

    #100; die = 1;
    #100; die = 0;

    
  end

endmodule;