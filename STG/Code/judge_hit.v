module judge_hit(
    input clk, rst,
    input laser_on,
    input [9:0] laser_x, laser_y,
    input [9:0] hecatia_x, hecatia_y,
    output reg hit
);

always @(posedge clk or posedge rst) begin
    hit = 0;
    if(rst)
	   hit = 0;
	else begin
        if((laser_x >= hecatia_x - 30 && laser_x < hecatia_x + 31 && laser_y < hecatia_y - 40))
            hit = 1;
	end
end

endmodule