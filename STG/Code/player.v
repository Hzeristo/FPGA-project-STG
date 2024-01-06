module player(
    input clk, reset,                       //clock & reset signal               
    input ctrl_up, ctrl_down, ctrl_left, ctrl_right,   //keyboard controller signal
    input [9:0] x, y,                       //VGA scan location
    output reg [9:0] player_x, player_y,        //player's location
    );
   