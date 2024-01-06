module judge_collision(
    input clk, rst,
    input [9:0] player_x, player_y;
    input [9:0] moon_x, moon_y;
    input [9:0] hecatia_x, hecatia_y;
    output reg collision
);

always @(posedge clk or posedge rst) begin
    collision = 0;
    if(rst)
	   collision = 0;
	else begin
        if((player_x >= hecatia_x - 11 && player_x < hecatia_x + 12 && player_y >= hecatia_y - 19 && player_y < hecatia_y + 20))
            collision = 1;
        if(((player_x - moon_x) * (player_x - moon_x) + (player_y - moon_y) * (player_y - moon_y)) < 60)
            collision = 1;
	end
end

endmodule