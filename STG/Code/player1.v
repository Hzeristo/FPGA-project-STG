module player(
    input clk,
    input v_up, v_down, h_left, h_right,
    output wire [11:0] rgb,
);

wire locked;
wire rdn;

wire clk_25MHz;
wire [8:0] pixel_Y;
wire [9:0] pixel_X;
wire [13:0] addr;
wire [11:0] data_in;
wire [11:0] spo1;
wire [11:0] spo2;


reg [11:0] data_reg;
reg [11:0] spo_reg;
reg [13:0] addr_reg;
reg [13:0] horizonal_temp;
reg [13:0] veritical_temp;
reg [13:0] horizonal;
reg [13:0] veritical;
reg [26:0] count;

initial begin
horizonal <= 0;
veritical <= 0;
count <= 0;
end

clkdiv_25MHz test_clk(.clk(clk), .clk_out(clk_25MHz));

moon_dist_mem test_rom1(
  .a(addr),      // input wire [13 : 0] a
  .spo(spo1)  // output wire [11 : 0] spo
);

hecatia_dist_mem test_rom2(
  .a(addr),      // input wire [13 : 0] a
  .spo(spo2)  // output wire [11 : 0] spo
);


always @(posedge clk)begin

  if (pixel_X == 0 && pixel_Y == 0)begin
    count = count + 1;
    if (count == 20) begin 
        count = 0;
        horizonal = horizonal_temp;
        veritical = veritical_temp;
        end
  end
  
  if (v_up == 0 || v_down == 0 || h_left == 0 || h_right == 0)begin
    
    if (h_right == 0) begin
        if (horizonal_temp == 200) begin 
            horizonal_temp = 0;
        end
        else begin
            horizonal_temp = horizonal_temp + 20;
        end
    end
    if (h_left == 0) begin
        if (horizonal_temp == 0) begin 
            horizonal_temp = 200;
        end
        else begin
            horizonal_temp = horizonal_temp - 20;
        end
    end
    if (v_up == 0) begin
        if (veritical_temp == 0) begin 
            veritical_temp = 200;
        end
        else begin
            veritical_temp = veritical_temp - 20;
        end
    end
    if (v_down == 0) begin
        if (veritical_temp == 200) begin 
            veritical_temp = 0;
        end
        else begin
            veritical_temp = veritical_temp + 20;
        end
    end
    
    end

  if((pixel_X >= horizonal && pixel_Y >= veritical && pixel_X < 128 + horizonal && pixel_Y < 128 + veritical && rdn == 0))begin
    addr_reg <= (pixel_Y - veritical)  * 128 + pixel_X - horizonal; 
    data_reg <= spo1;
  end
  else begin
    addr_reg <= 0;
    data_reg <= 12'b0000_0000_0000;
  end
end

assign addr = addr_reg;

assign data_in = data_reg;

assign BTN_X = 1'b0;

endmodule