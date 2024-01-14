module laser(
    input clk, reset,
    input [9:0] x, y,
    input [9:0] player_x, player_y,
    input shooting,
    output [11:0] rgb_out,
    output [9:0] laser_x, laser_y,
    output laser_on
);

localparam MAX_X = 384;
localparam MAX_Y = 448;
localparam TIME_MAX = 2000000;    

reg [9:0] laser_x_reg, laser_y_reg;
reg [9:0] laser_x_next, laser_y_next;
reg [25:0] time_reg;  
wire [25:0] time_next;  
assign time_next = (time_reg < TIME_MAX) ? time_reg + 1 : 0;        
wire tick = (time_reg == TIME_MAX) ? 1 : 0;
reg [12:0] addr_reg;
wire [12:0] addr;
assign addr = addr_reg;


initial begin
    laser_x_next = 192;
    laser_y_next = 399;
    time_reg = 0;
end

always @(posedge clk or posedge reset) begin
    if (reset) begin
        time_reg <= 0;
        laser_x_reg <= laser_x_next;
        laser_y_reg <= laser_y_next;
    end
    else begin
        laser_x_reg <= laser_x_next;
        laser_y_reg <= laser_y_next;
        time_reg <= time_next;
    end
end

always @(posedge tick or posedge reset) begin
    laser_x_next = laser_x_reg;
    laser_y_next = laser_y_reg;
    if(reset) begin
        laser_x_next = 192;
        laser_y_next = 399;
    end
    else begin
        laser_x_next = player_x;
        laser_y_next = player_y - 1;
    end
end

always @* begin
    if(x >= laser_x_reg && x < laser_x_reg + 16 && y >= 0 && y < laser_y_reg) begin
        addr_reg = x - laser_x_reg + y * 16;
    end
    else begin
        addr_reg = 0;
    end
end

laser_dist_mem laser_unit(
  .a(addr),      // input wire [10 : 0] a
  .spo(rgb_out)  // output wire [11 : 0] spo
);

wire cover_on = (x >= laser_x_reg - 15 && x < laser_x_reg + 16) ? 1 : 0;
assign laser_on = cover_on && shooting && (rgb_out != 12'b0000_0000_0000) ? 1 : 0;
assign laser_x = laser_x_reg;
assign laser_y = laser_y_reg;

endmodule