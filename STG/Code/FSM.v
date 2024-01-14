module FSM(
    input clk, hard_reset,
    input enter, bomb,
    input collision,
    input die,
    output reg [3:0] num_bomb,
    output reg [3:0] num_life,
    output reg [3:0] game_state,
    output reg game_en,
    output reg game_reset
);

localparam Initial = 4'b0000;
localparam Start = 4'b0001;
localparam Play = 4'b0010;
localparam Collision = 4'b1010;
localparam Bomb = 4'b0110;
localparam Success = 4'b1000;
localparam Gameover = 4'b1001;

reg [3:0] num_bomb_next;
reg [3:0] num_life_next;
reg [3:0] game_state_next;
reg game_en_next, enter_reg, bomb_reg;
reg [31:0] timeout_reg, timeout_next;

wire enter_posedge = enter & ~enter_reg;
wire bomb_posedge = bomb & ~bomb_reg;

initial begin
    game_state <= Initial;
    timeout_reg <= 2000_000;       //2000_0000
    num_life <= 3;
    num_bomb <= 3;
	game_en  <= 0;
    enter_reg <= 0;
    bomb_reg <= 0;
end

always @(posedge clk or posedge hard_reset)
	if(hard_reset) begin
		enter_reg <= 0;
        bomb_reg <= 0;
		game_state <= Initial;				//initialization
		timeout_reg <= 2000_0000;			//reset collision timer, should be 2000_0000
		num_life <= 3;
        num_bomb <= 3;
		game_en  <= 0;
	end
	else begin
		enter_reg <= enter;
        bomb_reg <= bomb;
		game_state <= game_state_next;
		timeout_reg <= timeout_next;
		num_life <= num_life_next;
		num_bomb <= num_bomb_next;
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
            timeout_next = timeout_reg - 1;
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
        game_en_next = 1;
        if(bomb_posedge && num_bomb > 0) begin
            num_bomb_next = num_bomb - 1;
            game_state_next = Bomb;
            timeout_next = 4000_0000;
        end	
        if(die) begin
            game_state_next = Success;
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
				timeout_next = 2000_0000; 	
			end
		end
	end
    Collision: begin
        if(bomb && num_bomb > 0) begin
            num_bomb_next = num_bomb - 1;
            game_state_next = Bomb;
            timeout_next = 2000_0000;
        end
        if(die) begin
            game_state_next = Success;
        end						
		if(timeout_reg > 0)              	
			timeout_next = timeout_reg - 1;	
		else 
			game_state_next = Play;   			
	end
    Bomb: begin
        if(die) begin
            game_state_next = Success;
        end
        if(timeout_reg > 0) begin
            timeout_next = timeout_reg - 1;
        end
        else begin
            game_state_next = Play;
        end
    end
    Success: begin
        if(enter_posedge) begin        			
			num_life_next = 3;
            num_bomb_next = 3;
            game_reset = 1;          
            timeout_next = 0;
            game_en_next = 0;
            game_state_next = Initial;	             			       			
		end
    end
    Gameover: begin
		if(enter_posedge) begin            			
			num_life_next = 3;
            num_bomb_next = 3;
            timeout_next = 0;  
            game_en_next = 0;           			
			game_state_next = Initial;		
			game_reset = 1;          			
		end
	end
	endcase
end

endmodule