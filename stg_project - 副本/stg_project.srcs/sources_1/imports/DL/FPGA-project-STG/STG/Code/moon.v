module moon(
    input clk, reset,
    input [9:0] player_x, player_y,
    input [9:0] x, y, 
    output [9:0] moon_x, moon_y,
    output moon_on,
    output [11:0] rgb_out
);

localparam MAX_X = 384;
localparam MAX_Y = 448;
localparam TIME_MAX = 500000;         //确定tick长度

reg [9:0] moon_x_reg, moon_y_reg;
reg [9:0] moon_x_next, moon_y_next;
reg [25:0] delay_reg, delay_next;
reg [25:0] time_reg;  
wire [25:0] time_next;  
assign time_next = (time_reg < TIME_MAX) ? time_reg + 1 : 0;        
wire tick = (time_reg == TIME_MAX) ? 1 : 0;
reg on_border;
reg [13:0] addr_reg;
wire [13:0] addr;
assign addr = addr_reg;
reg delta_x, delta_y;


initial begin
    on_border = 0;
    delay_next = 0;
    moon_x_next = 192;
    moon_y_next = 100;
    time_reg = 0;
    delta_x = 1;
    delta_y = 1;
end

always @* begin
    if(moon_x_reg == 64||moon_x_reg == 320||moon_y_reg == 64||moon_y_reg == 384)begin
        on_border = 1;
    end
    else begin
        on_border = 0;
    end
end

always @(posedge clk) begin
    if (reset) begin
        time_reg <= 0;
    end
    else begin
        moon_x_reg <= moon_x_next;
        moon_y_reg <= moon_y_next;
        delay_reg <= delay_next;
        time_reg <= time_next;
    end
end

always @(posedge tick or posedge reset) begin
    moon_x_next = moon_x_reg;
    moon_y_next = moon_y_reg;
    if(reset) begin
        moon_x_next = 192;
        moon_y_next = 100;
        delay_next = 0;
        delta_x = (moon_x_next < player_x) ? 1 : 0;
        delta_y = (moon_y_next < player_y) ? 1 : 0;
    end
    else if(on_border) begin
        delta_x = (moon_x_next < player_x) ? 1 : 0;
        delta_y = (moon_y_next < player_y) ? 1 : 0;
        if(delay_reg < 40) begin
            delay_next = delay_reg + 1;
        end
        else begin
            if(delta_x > 0) begin 
                moon_x_next = moon_x_reg + 1;
            end
            else begin
                moon_x_next = moon_x_reg - 1;
            end
            if(delta_y > 0) begin 
                moon_y_next = moon_y_reg + 1;
            end
            else begin
                moon_y_next = moon_y_reg - 1;
            end
        end
    end
    else begin
        delay_next <= 0;
        if(delta_x > 0) begin 
            moon_x_next = moon_x_reg + 1;
        end
        else begin
            moon_x_next = moon_x_reg - 1;
        end
        if(delta_y > 0) begin 
            moon_y_next = moon_y_reg + 1;
        end
        else begin
            moon_y_next = moon_y_reg - 1;
        end
    end
end

always @* begin
    if(x >= moon_x_reg - 63 && x <= moon_x_reg + 64 && y >= moon_y_reg - 63 && y <= moon_y_reg + 64) begin
        addr_reg = x - moon_x_reg + 63 + (y - moon_y_reg + 63) * 128;
    end
    else begin
        addr_reg = 0;
    end
end

moon_dist_mem moon_unit (
  .a(addr),      // input wire [13 : 0] a
  .spo(rgb_out)  // output wire [11 : 0] spo
);

wire cover_on = (x >= moon_x_reg - 63 && x <= moon_x_reg + 64 && y >= moon_y_reg - 63 && y <= moon_y_reg + 64) ? 1 : 0;
assign moon_on = cover_on && (rgb_out != 12'b1100_1100_1100) ? 1 : 0;
assign moon_x = moon_x_reg;
assign moon_y = moon_y_reg;

endmodule