module FSM(
    input clk, hard_reset,
    input enter, bomb,
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
reg game_en_next, enter_reg, bomb_reg;
reg [31:0] timeout_reg, timeout_next;

wire enter_posedge = enter & ~enter_reg;
wire bomb_posedge = bomb & ~bomb_reg;

always @(posedge clk or posedge hard_reset)
	if(hard_reset) begin
		enter_reg <= 0;
        bomb_reg <= 0;
		game_state <= Initial;				//initialization
		timeout_reg <= 20000000;			//reset collision timer
		num_life <= 3;
        num_bomb <= 3;
		game_en  <= 0;
	end
	else begin
		enter_reg <= enter;
        bomb_reg <= bomb;
		game_state <= game_state_next;
		timeout_reg <= timeout_next;
		num_life <= life_next;
		game_en <= game_en_next;
	end

always @* begin
    game_state_next = game_state;
    timeout_next = timeout_reg;
    num_life_next = num_life;
    num_bomb_next = num_bomb;
    game_en_next = game_en;
    game_reset = 0;

    case(game_state)
    Initial: begin
        if(timeout_reg > 0) begin
            timeout_reg = timeout_reg - 1;
        end
        else begin
            game_state_next = Start;
        end
    end
    Start: begin
        if(enter_posedge) begin						
			game_en_next = 1;             	
			game_reset = 1;            		
			game_state_next = Play; 
		end
    end
    Play: begin
        if(bomb && num_bomb > 0) begin
            game_state_next = Bomb;
            timeout_next = 4000_0000_0;
        end	
		if(collision) begin				
			if(num_life == 0) begin    	
				num_life_next = num_life - 1;	
				game_en_next = 0;          	
				game_state_next = Gameover;
			end
			else begin
				num_life_next = num_life - 1; 	
				game_state_next = Collision;
				timeout_next = 2000_0000_0; 	
			end
		end
	end
    Collision: begin
        if(bomb && num_bomb > 0) begin
            game_state_next = Bomb;
            timeout_next = 4000_0000_0;
        end						
		if(timeout_reg > 0)              	
			timeout_next = timeout_reg - 1;	
		else 
			game_state_next = Play;   			
	end
    endcase
    Bomb: begin
        if(timeout_reg > 0) begin
            timeout_reg = timeout_reg - 1;
        end
        else begin
            game_state_next = Play;
        end
    end
    Gameover: begin
		if(enter_posedge) begin            			
			heart_next = 3;           			
			game_state_next = Initial;		
			game_reset = 1;          			
		end
	end
end

endmodule