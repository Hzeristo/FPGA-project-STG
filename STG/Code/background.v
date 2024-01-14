module background (
    input clk,
    input [9:0] x, y,
    output [11:0] rgb
);

wire [17:0] addr;
assign addr = (x < 384 && x >= 0 && y < 448 && y >= 0) ? y * 384 + x : 1'b1;

background_blk_mem background_unit (
  .clka(clk),    // input wire clka
  .addra(addr),  // input wire [17 : 0] addra
  .douta(rgb)  // output wire [11 : 0] douta
);

endmodule