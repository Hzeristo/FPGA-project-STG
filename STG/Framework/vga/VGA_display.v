`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/19 11:18:15
// Design Name: 
// Module Name: VGA_display
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module VGA_display(
input clk_25,
input rst,
input	    [8:0] 	pixel_xpos,
input 	    [9:0]	pixel_ypos,
output reg  [11:0]	pixel_data);
    parameter H_DISP = 10'd640;
    parameter V_DISP = 10'd480;
    localparam WHITE = 12'b1111_1111_1111;
    localparam BLACK = 12'b0000_0000_0000;
    localparam RED   = 12'b1111_0000_0000;
    localparam GREEN = 12'b0000_1111_0000;
    localparam BLUE  = 12'b0000_0000_1111;

always @(posedge clk_25 or posedge rst) begin
  if (rst)
      pixel_data <= 16'd0;
  else begin
      if((pixel_xpos >= 0) && (pixel_xpos <= (H_DISP/5)*1))
          pixel_data <= WHITE;
      else if((pixel_xpos >= (H_DISP/5)*1) && (pixel_xpos < (H_DISP/5)*2))
          pixel_data <= BLACK;
      else if((pixel_xpos >= (H_DISP/5)*2) && (pixel_xpos < (H_DISP/5)*3))
          pixel_data <= RED;
      else if((pixel_xpos >= (H_DISP/5)*3) && (pixel_xpos < (H_DISP/5)*4))
          pixel_data <= GREEN;
      else
          pixel_data <= BLUE;
   end
end

endmodule


