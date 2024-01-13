module P2S
#(parameter BIT_WIDTH = 8)(
input clk,
input start,
input [BIT_WIDTH-1:0] par_in,
output sclk,
output sclrn,
output sout,
output EN
);

wire [BIT_WIDTH:0] Q;
wire finish;

SR_Latch sr_latch (
 .S(start),
.R(finish),
.Q(Q[BIT_WIDTH]),
 .Qn()
 );

ShiftReg8b #(.BIT_WIDTH(BIT_WIDTH)) shift_reg (
.clk(clk),
.shiftn_loadp(Q[BIT_WIDTH]),
.shift_in(start),
.par_in(par_in),
.Q(Q)
);

assign finish = (Q[BIT_WIDTH] == 1);

 assign EN = !start && finish;
assign sclk = finish | clk;
assign sclrn = 1'b1;
assign sout = Q[0];

endmodule