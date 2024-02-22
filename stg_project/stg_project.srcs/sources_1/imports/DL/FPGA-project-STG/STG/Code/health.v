module health(
    input clk, rst, is_hit,
    output reg [3:0] health,
    output wire die
);

localparam TIME_MAX = 1000000;

reg [25:0] time_reg;  
wire [25:0] time_next;  
assign time_next = (time_reg < TIME_MAX) ? time_reg + 1 : 0;        
wire tick = (time_reg == TIME_MAX) ? 1 : 0;

reg [7:0] life_reg, life_next;

initial begin
    life_reg = 100;
    life_next = 100;
    time_reg = 0;
    health = 0;
end

always @(posedge clk or posedge rst) begin
    if(rst) begin
        life_reg = 100;
    end
    else begin
        life_reg = life_next;
        health = life_next;
        time_reg = time_next;
    end
end

always @(posedge tick or posedge rst) begin
    life_next = life_reg;
    if(rst) begin
        life_next = 100;
    end
    else if(is_hit && life_reg != 0) begin
        life_next = life_reg - 1;
    end
end

assign die = (life_reg == 1)? 1 : 0;  

endmodule