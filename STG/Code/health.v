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

reg [3:0] life_reg, life_next;
reg flag, die_reg;

initial begin
    life_reg = 10;
    life_next = 10;
    flag = 0; 
    die_reg = 0;
    health = 0;
end

always @(posedge clk) begin
    if(rst) begin
        life_reg <= 10;
        life_next <= 10;
        flag <= 0; 
        die_reg <= 0;
    end
    else begin
        life_reg <= life_next;
        health <= life_reg;
        if(life_reg == 0) begin
            flag <= 1;
        end
    end
end

always @(posedge tick) begin
    life_next <= life_reg;
    if(is_hit) begin
        life_next <= life_reg - 1;
    end
end

always @(posedge flag) begin
    die_reg <= 1;
end

assign die = (die_reg == 1)? 1 : 0;  

endmodule