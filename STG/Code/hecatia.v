module hecatia(
    input clk, reset,
    input [9:0] x, y, 
    input is_hit,
    output hecatia_on,
    output [9:0] hecatia_x, hecatia_y,
    output [11:0] rgb_out,
    output [7:0] health,
    output die
);

localparam MAX_X = 384;
localparam MAX_Y = 448;
localparam TIME_MAX = 4000;
reg [9:0] hecatia_x_reg, hecatia_y_reg;
reg [9:0] hecatia_x_next, hecatia_y_next;
reg [25:0] time_reg;  
wire [25:0] time_next;  
assign time_next = (time_reg < TIME_MAX) ? time_reg + 1 : 0;        
wire tick = (time_reg == TIME_MAX) ? 1 : 0;
reg [9:0] tick_reg, tick_next;
reg [12:0] addr_reg;
wire [12:0] addr;
assign addr = addr_reg;
reg [9:0] life;
wire clk_in;
assign clk_in = (die == 1) ? 0 : clk;

initial begin
    time_reg = 0;
    tick_next = 0;
    life = 1000;
    hecatia_x_next = 192;
    hecatia_y_next = 100;
end

always @(posedge clk_in or posedge reset) begin
    if (reset) begin
        time_reg = 0;
        tick_reg = 0;
        hecatia_x_next = 192;
        hecatia_y_next = 100;
    end
    else begin
        hecatia_x_reg <= hecatia_x_next;
        hecatia_y_reg <= hecatia_y_next;
        time_reg <= time_next;
        tick_reg <= tick_next;
    end
end

always @(posedge tick) begin
    hecatia_x_next = hecatia_x_reg;
    hecatia_x_next = hecatia_x_reg;
    tick_next = tick_reg;
    tick_next = tick_next + 1;
    if(reset) begin
        hecatia_x_next = 192;
        hecatia_y_next = 100;
    end
    else if(tick_reg > 10000000) begin
        hecatia_x_next = hecatia_x_reg + 1;
    end
    else if(25000000 > tick_reg > 15000000) begin
        hecatia_x_next = hecatia_x_reg - 1;
    end
    if(is_hit) begin
        life = life - 1;
    end
end

always @* begin
    if(x >= hecatia_x_reg - 31 && x <= hecatia_x_reg + 32 && y >= hecatia_y_reg - 47 && y <= hecatia_y_reg + 48) begin
        addr_reg = x - hecatia_x_reg + 31 + (y - hecatia_y_reg + 47) * 96;
    end
end

hecatia_dist_mem hecatia_unit (
  .a(addr),      // input wire [12 : 0] a
  .spo(rgb_out)  // output wire [11 : 0] spo
);

wire cover_on = (x >= hecatia_x_reg - 31 && x <= hecatia_x_reg + 32 && y >= hecatia_y_reg - 47 && y <= hecatia_y_reg + 48) ? 1 : 0;
assign hecatia_on = cover_on && (rgb_out != 12'b1100_1100_1100) && (life != 0) ? 1 : 0;
assign hecatia_x = hecatia_x_reg;
assign hecatia_y = hecatia_y_reg;
assign health = life;
assign die = (life == 0) ? 1 : 0;

endmodule