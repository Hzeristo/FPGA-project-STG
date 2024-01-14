module Top_module(
    input clk, rstn,        //clk & rst negative signal     
    input SW,               //switch for controlling buzzer
    input PS2_data,         
    input PS2_clk,    
    output hsync, vsync,    //horizontal & vertical scan signal
    output [11:0] rgb,      //rgb value to VGA port
    output buzzer,           //buzzer module
    output [3:0] game_state_out,
    output [3:0] AN,
    output [7:0] SEGMENT
);

wire clk25;
wire hard_reset = ~rstn;
wire beep;
wire enter, bomb, ctrl_up, ctrl_down, ctrl_left, ctrl_right;
assign buzzer = beep && SW;
wire [3:0] game_state;
wire game_en, game_reset;
wire reset = hard_reset || game_reset;
wire [3:0] num_life, num_bomb;
wire collision, die;
wire gamestate_collision = (game_state == 4'b1010) ? 1 : 0;
wire [9:0] x, y;
wire [9:0] player_x, player_y;
wire [9:0] hecatia_x, hecatia_y;
wire [9:0] moon_x, moon_y;
wire [9:0] laser_x, laser_y;
wire hecatia_on, is_hit;
wire moon_on, player_on;
reg [11:0] rgb_out, rgb_next;
wire video_off;
wire [11:0] background_rgb, cover_rgb, success_rgb, /*gameover_rgb*/ hecatia_rgb, moon_rgb, player_rgb, laser_rgb;
wire [3:0] r,g,b;
wire [7:0] last_key;
wire [3:0] health;

initial begin
    rgb_out = 0;
    rgb_next = 0;
end

clkdiv_25MHz clkdiv_25MHz_unit (
    .clk(clk),
    .clk_out(clk25)
);

PS2_Interface PS2_Interface_unit (
    .clk(clk),
    .rst(reset),
    .ps2_data(PS2_data),
    .ps2_clk(PS2_clk),
    .w(ctrl_up),
    .a(ctrl_left),
    .s(ctrl_down),
    .d(ctrl_right),
    .z(shooting),
    .x(bomb),
    .enter(enter)
);

FSM FSM_unit (
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

player player_unit (
    .clk(clk),
    .reset(reset),
    .x(x),
    .y(y),
    .ctrl_up(ctrl_up),
    .ctrl_down(ctrl_down),
    .ctrl_left(ctrl_left),
    .ctrl_right(ctrl_right),
    .collision(gamestate_collision),
    .player_x(player_x),
    .player_y(player_y),
    .rgb_out(player_rgb),
    .player_on(player_on)
);

hecatia hecatia_unit (
    .clk(clk),
    .reset(reset),
    .x(x),
    .y(y),
    .is_hit(is_hit),
    .hecatia_on(hecatia_on),
    .hecatia_x(hecatia_x),
    .hecatia_y(hecatia_y),
    .rgb_out(hecatia_rgb)
);

judge_collision judge_collision_unit (
    .clk(clk),
    .rst(reset),
    .player_x(player_x),
    .player_y(player_y),
    .moon_x(moon_x),
    .moon_y(moon_y),
    .hecatia_x(hecatia_x),
    .hecatia_y(hecatia_y),
    .collision(collision)
);

judge_hit judge_hit_unit (
    .clk(clk),
    .rst(reset),
    .laser_on(laser_on),
    .player_x(player_x),
    .player_y(player_y),
    .hecatia_x(hecatia_x),
    .hecatia_y(hecatia_y),
    .hit(is_hit)
);

moon moon_unit (
    .clk(clk),
    .reset(reset),
    .player_x(player_x),
    .player_y(player_y),
    .x(x),
    .y(y),
    .moon_x(moon_x),
    .moon_y(moon_y),
    .moon_on(moon_on),
    .rgb_out(moon_rgb)
);

laser laser_unit (
    .clk(clk),
    .reset(reset),
    .x(x),
    .y(y),
    .player_x(player_x),
    .player_y(player_y),
    .shooting(shooting),
    .laser_x(laser_x),
    .laser_y(laser_y),
    .rgb_out(laser_rgb),
    .laser_on(laser_on)
);

vgac vgac_unit (
    .d_in(rgb_out),
    .vga_clk(clk25),
    .clrn(rstn),
    .row_addr(y),
    .col_addr(x),
    .r(r),
    .g(g),
    .b(b),
    .rdn(video_off),
    .hs(hsync),
    .vs(vsync)
);

health health_unit(
    .clk(clk),
    .rst(reset),
    .is_hit(is_hit),
    .die(die),
    .health(health)
);

background background_unit(
    .clk(clk),
    .x(x),
    .y(y),
    .rgb(background_rgb)
);

cover cover_unit(
    .clk(clk),
    .x(x),
    .y(y),
    .rgb(cover_rgb)
);

success success_unit(
    .clk(clk),
    .x(x),
    .y(y),
    .rgb(success_rgb)
);

 DisplayNumber disp_unit(
        .clk(clk),
        .rst(1'b0),
        .hexs({7'b0, is_hit, 4'b0, health}),
        .points(4'b0),
        .LEs(4'b0),
        .AN(AN),
        .SEGMENT(SEGMENT)
    );


always @* begin
        if(video_off) begin
            rgb_next = 0;
        end
        else if(game_state == 4'b0001 || game_state == 4'b0000) begin
            rgb_next = cover_rgb;
        end
        else if(game_state == 4'b1000) begin
            rgb_next = success_rgb;
        end
        else if(game_state == 4'b1001) begin
            rgb_next = success_rgb;
        end
        else if(game_en && moon_on) begin
            rgb_next = moon_rgb;
        end
        else if(game_en && hecatia_on) begin
            rgb_next = hecatia_rgb;
        end
        else if(game_en && player_on) begin
            rgb_next = player_rgb;
        end
        else if(game_en && laser_on) begin
            rgb_next = player_rgb;
        end
        else begin
            rgb_next = background_rgb;
        end
end

always @(posedge clk) begin
    rgb_out = rgb_next;
end

assign rgb = rgb_out;

music_room music_unit(.clk(clk), .rst_n(1), .beep(beep));

assign game_state_out = game_state;

endmodule