module judge_hit(
    input clk, rst,
    input laser_on,
    input [9:0] player_x, player_y,
    input [9:0] hecatia_x, hecatia_y,
    output reg hit
);

always @(posedge clk or posedge rst) begin
    hit = 0;
    if(rst)
	   hit = 0;
    else begin
        if((player_x >= hecatia_x - 30 && player_x < hecatia_x + 31 && player_y > hecatia_y && laser_on == 1))
            hit = 1;
    end
end

endmodule