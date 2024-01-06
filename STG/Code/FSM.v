module FSM(
    input clk, hard_reset,
    input enter, shift,
    input collision,
    output [3:0] num_bomb,
    output [3:0] num_life,
    output [4:0] game_state,
    output game_en,
    output game_reset
);

localparam Initial = 4'b0000;
localparam Start = 4'b0001;
localparam Play = 4'b0010;
localparam Collision = 4'b1010;
localparam Bomb = 4'b0110;
localparam Gameover = 4'b1001;

reg [3:0] num_bomb_next;
reg [3:0] num_life_next;
reg [3:0] game_state_next;
reg game_en_next, enter_reg, shift_reg;
reg [31:0] timeout_reg, timeout_next;

wire enter_posedge = enter & ~enter_reg;
wire shift_posedge = shift & ~shift_reg;

always @(posedge clk or posedge hard_reset)
	if(hard_reset) begin
		enter_reg <= 0;
        shift_reg <= 0;
		game_state <= Initial;				//initialization
		timeout_reg <= 20000000;			//reset collision timer
		num_life <= 3;
        num_bomb <= 3;
		game_en  <= 0;
	end
	else begin
		enter_reg <= enter;
        shift_reg <= shift;jht
		game_state <= game_state_next;
		timeout_reg <= timeout_next;
		num_life <= life_next;
		game_en <= game_en_next;
	end

always @* begin
    game_state_next = game_state;
    timeout_next = timeout_reg;
    num_life_next = num_life;
end


endmodule