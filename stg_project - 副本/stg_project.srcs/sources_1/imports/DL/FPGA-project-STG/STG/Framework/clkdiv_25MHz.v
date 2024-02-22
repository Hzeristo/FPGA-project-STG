`timescale 1ns / 1ps

module clkdiv_25MHz( 
	input clk, 
	output reg clk_out
);
	 
	reg [31:0] cnt;

	initial begin
		cnt = 32'b0;
		clk_out = 0;
	end

	wire[31:0] cnt_next;
	assign cnt_next = cnt + 1'b1;

	always @(posedge clk) begin
		if(cnt<1)begin
			cnt <= cnt_next;
		end
		else begin
			cnt <= 0;
			clk_out <= ~clk_out;
		end
	end

endmodule
