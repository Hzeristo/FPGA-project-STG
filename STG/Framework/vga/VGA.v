`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/19 11:17:41
// Design Name: 
// Module Name: VGA
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


module VGA(
    input clk_100mhz,
    input RSTN,
    output HSYNC,
    output VSYNC,
    output wire [3:0] Red,
    output wire [3:0] Green,
    output wire [3:0] Blue
    );
    wire [31:0] clkdiv;
    clkdiv u1(
    .rst(~RSTN),
    .clk(clk_100mhz),
    .clkdiv(clkdiv)
    );
    wire  [11:0]	pixel_data;   
    wire  [8:0] 	pixel_xpos;
    wire  [9:0]	pixel_ypos;
    VGA_display u2(
    .clk_25 (clkdiv[1]),
    .rst(~RSTN),
    .pixel_xpos(pixel_xpos),
    .pixel_ypos(pixel_ypos),
    .pixel_data(pixel_data)
    );
    
    VGA_drive u3(
    .clk(clkdiv[1]),
    .rst(~RSTN),
    .Din(pixel_data),
    .row(pixel_xpos),
    .col(pixel_ypos),
    .rdn(),
    .R(Red ),
    .G(Green),
    .B(Blue ),
    .HS(HSYNC),
    .VS(VSYNC)
    );
    
    
    
endmodule
