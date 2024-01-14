module player(
    input clk, reset,
    input [9:0] x, y,
    input ctrl_up, ctrl_down, ctrl_left, ctrl_right,
    input collision,
    output [9:0] player_x, player_y,
    output reg [11:0] rgb_out,
    output player_on
);

localparam MAX_X = 384;
localparam MAX_Y = 448;
localparam TIME_MAX = 2000000;    

reg [9:0] player_x_reg, player_y_reg;
reg [9:0] player_x_next, player_y_next;
reg [25:0] time_reg;  
wire [25:0] time_next;  
assign time_next = (time_reg < TIME_MAX) ? time_reg + 1 : 0;        
wire tick = (time_reg == TIME_MAX ) ? 1 : 0;
reg [10:0] addr_reg;
wire [10:0] addr;
assign addr = addr_reg;
wire [11:0] rgb_out1, rgb_out2;
wire up, down, left, right;

assign up = (ctrl_up)? 1 : 0;
assign down = (ctrl_down)? 1 : 0;
assign left = (ctrl_left)? 1 : 0;
assign right = (ctrl_right)? 1 : 0;

initial begin
    player_x_next = 192;
    player_y_next = 400;
    time_reg = 0;
end

always @(posedge clk or posedge reset) begin
    if (reset) begin
        time_reg = 0;
        player_x_next = 192;
        player_y_next = 400;
        player_x_reg = player_x_next;
        player_y_reg = player_y_next;
    end
    else begin
        player_x_reg <= player_x_next;
        player_y_reg <= player_y_next;
        time_reg <= time_next;
    end
end

always @(posedge tick or posedge reset) begin
    player_x_next = player_x_reg;
    player_y_next = player_y_reg;
    if(reset) begin
        player_x_next = 192;
        player_y_next = 400;
    end
    else begin
        if(up) begin
            if(player_y_reg > 0) begin
                player_y_next = player_y_reg - 1;
            end
        end
        if(down) begin
            if(player_y_reg < 448) begin
                player_y_next = player_y_reg - 1;
            end
        end
        if(left) begin
            if(player_x_reg > 0) begin
                player_y_next = player_y_reg - 1;
            end
        end
        if(right) begin
            if(player_x_reg < 384) begin
                player_y_next = player_y_reg - 1;
            end
        end
    end
end

always @* begin
    if(x >= player_x_reg - 15 && x < player_x_reg + 16 && y >= player_y_reg - 23 && y < player_y_reg + 24) begin
        addr_reg = x - player_x_reg + 15 + (y - player_y_reg + 23) * 32;
    end
    else begin
        addr_reg = 0;
    end
end

player_dist_mem player_unit(
  .a(addr),      // input wire [10 : 0] a
  .spo(rgb_out1)  // output wire [11 : 0] spo
);

playerhit_dist_mem playerhit_unit(
  .a(addr),      // input wire [10 : 0] a
  .spo(rgb_out2)  // output wire [11 : 0] spo
);

always @(posedge clk) begin
    if(collision) begin
        rgb_out <= rgb_out1;
    end
    else begin
        rgb_out <= rgb_out2;
    end
end

wire cover_on = (x >= player_x_reg - 15 && x < player_x_reg + 16 && y >= player_y_reg - 23 && y < player_y_reg + 24) ? 1 : 0;
assign player_on = cover_on && (rgb_out != 12'b1100_1100_1100) ? 1 : 0;
assign player_x = player_x_reg;
assign player_y = player_y_reg;

endmodule