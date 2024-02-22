/******************************************************************************
 ** Logisim-evolution goes FPGA automatic generated Verilog code             **
 ** https://github.com/logisim-evolution/                                    **
 **                                                                          **
 ** Component : DisplaySync                                                  **
 **                                                                          **
 *****************************************************************************/

module DisplaySync( AN,
                    HEX,
                    LE,
                    LEs,
                    hexs,
                    point,
                    points,
                    scan );

   /*******************************************************************************
   ** The inputs are defined here                                                **
   *******************************************************************************/
   input [3:0]  LEs;
   input [15:0] hexs;
   input [3:0]  points;
   input [1:0]  scan;

   /*******************************************************************************
   ** The outputs are defined here                                               **
   *******************************************************************************/
   output [3:0] AN;
   output [3:0] HEX;
   output       LE;
   output       point;

   /*******************************************************************************
   ** The wires are defined here                                                 **
   *******************************************************************************/
   wire [3:0]  s_logisimBus0;
   wire [1:0]  s_logisimBus1;
   wire [3:0]  s_logisimBus17;
   wire [3:0]  s_logisimBus18;
   wire [3:0]  s_logisimBus19;
   wire [3:0]  s_logisimBus20;
   wire [15:0] s_logisimBus21;
   wire [3:0]  s_logisimBus22;
   wire [3:0]  s_logisimBus23;
   wire [3:0]  s_logisimBus4;
   wire        s_logisimNet10;
   wire        s_logisimNet11;
   wire        s_logisimNet12;
   wire        s_logisimNet13;
   wire        s_logisimNet14;
   wire        s_logisimNet15;
   wire        s_logisimNet16;
   wire        s_logisimNet2;
   wire        s_logisimNet3;
   wire        s_logisimNet9;

   /*******************************************************************************
   ** The module functionality is described here                                 **
   *******************************************************************************/

   /*******************************************************************************
   ** Here all input connections are defined                                     **
   *******************************************************************************/
   assign s_logisimBus1[1:0]   = scan;
   assign s_logisimBus21[15:0] = hexs;
   assign s_logisimBus22[3:0]  = points;
   assign s_logisimBus23[3:0]  = LEs;

   /*******************************************************************************
   ** Here all output connections are defined                                    **
   *******************************************************************************/
   assign AN    = s_logisimBus4[3:0];
   assign HEX   = s_logisimBus0[3:0];
   assign LE    = s_logisimNet3;
   assign point = s_logisimNet2;

   /*******************************************************************************
   ** Here all in-lined components are defined                                   **
   *******************************************************************************/

   // Constant
   assign  s_logisimBus17[3:0]  =  4'hE;


   // Constant
   assign  s_logisimBus18[3:0]  =  4'hD;


   // Constant
   assign  s_logisimBus19[3:0]  =  4'hB;


   // Constant
   assign  s_logisimBus20[3:0]  =  4'h7;


   /*******************************************************************************
   ** Here all sub-circuits are defined                                          **
   *******************************************************************************/

   Mux4to1b4   mux_hexs (.D0(s_logisimBus21[3:0]),
                         .D1(s_logisimBus21[7:4]),
                         .D2(s_logisimBus21[11:8]),
                         .D3(s_logisimBus21[15:12]),
                         .S(s_logisimBus1[1:0]),
                         .Y(s_logisimBus0[3:0]));

   Mux4to1b1   mux_points (.D0(s_logisimBus22[0]),
                           .D1(s_logisimBus22[1]),
                           .D2(s_logisimBus22[2]),
                           .D3(s_logisimBus22[3]),
                           .S(s_logisimBus1[1:0]),
                           .Y(s_logisimNet2));

   Mux4to1b1   mux_LE (.D0(s_logisimBus23[0]),
                       .D1(s_logisimBus23[1]),
                       .D2(s_logisimBus23[2]),
                       .D3(s_logisimBus23[3]),
                       .S(s_logisimBus1[1:0]),
                       .Y(s_logisimNet3));

   Mux4to1b4   nux_AN (.D0(s_logisimBus17[3:0]),
                       .D1(s_logisimBus18[3:0]),
                       .D2(s_logisimBus19[3:0]),
                       .D3(s_logisimBus20[3:0]),
                       .S(s_logisimBus1[1:0]),
                       .Y(s_logisimBus4[3:0]));

endmodule
