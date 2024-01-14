module success (
    input clk,
    input [9:0] x, y,
    output [11:0] rgb
);

wire [18:0] addr;
assign addr =  y * 640 + x;

success_blk_mem success_unit (
  .clka(clk),    // input wire clka
  .addra(addr),  // input wire [18 : 0] addra
  .douta(rgb)  // output wire [11 : 0] douta
);

endmodule