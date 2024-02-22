/******************************************************************************
 ** Logisim-evolution goes FPGA automatic generated Verilog code             **
 ** https://github.com/logisim-evolution/                                    **
 **                                                                          **
 ** Component : Mux4to1b4                                                    **
 **                                                                          **
 *****************************************************************************/

module Mux4to1b4( D0,
                  D1,
                  D2,
                  D3,
                  S,
                  Y );

   /*******************************************************************************
   ** The inputs are defined here                                                **
   *******************************************************************************/
   input [3:0] D0;
   input [3:0] D1;
   input [3:0] D2;
   input [3:0] D3;
   input [1:0] S;

   /*******************************************************************************
   ** The outputs are defined here                                               **
   *******************************************************************************/
   output [3:0] Y;

   /*******************************************************************************
   ** The wires are defined here                                                 **
   *******************************************************************************/
   wire [3:0] s_logisimBus17;
   wire [3:0] s_logisimBus18;
   wire [3:0] s_logisimBus19;
   wire [3:0] s_logisimBus24;
   wire [3:0] s_logisimBus25;
   wire [1:0] s_logisimBus7;
   wire       s_logisimNet0;
   wire       s_logisimNet1;
   wire       s_logisimNet10;
   wire       s_logisimNet11;
   wire       s_logisimNet12;
   wire       s_logisimNet13;
   wire       s_logisimNet14;
   wire       s_logisimNet15;
   wire       s_logisimNet16;
   wire       s_logisimNet2;
   wire       s_logisimNet20;
   wire       s_logisimNet21;
   wire       s_logisimNet22;
   wire       s_logisimNet23;
   wire       s_logisimNet3;
   wire       s_logisimNet4;
   wire       s_logisimNet5;
   wire       s_logisimNet6;
   wire       s_logisimNet8;
   wire       s_logisimNet9;

   /*******************************************************************************
   ** The module functionality is described here                                 **
   *******************************************************************************/

   /*******************************************************************************
   ** Here all input connections are defined                                     **
   *******************************************************************************/
   assign s_logisimBus17[3:0] = D0;
   assign s_logisimBus18[3:0] = D1;
   assign s_logisimBus19[3:0] = D3;
   assign s_logisimBus24[3:0] = D2;
   assign s_logisimBus7[1:0]  = S;

   /*******************************************************************************
   ** Here all output connections are defined                                    **
   *******************************************************************************/
   assign Y = s_logisimBus25[3:0];

   /*******************************************************************************
   ** Here all sub-circuits are defined                                          **
   *******************************************************************************/

   Mux4to1b1   m0 (.D0(s_logisimBus17[0]),
                   .D1(s_logisimBus18[0]),
                   .D2(s_logisimBus24[0]),
                   .D3(s_logisimBus19[0]),
                   .S(s_logisimBus7[1:0]),
                   .Y(s_logisimBus25[0]));

   Mux4to1b1   m1 (.D0(s_logisimBus17[1]),
                   .D1(s_logisimBus18[1]),
                   .D2(s_logisimBus24[1]),
                   .D3(s_logisimBus19[1]),
                   .S(s_logisimBus7[1:0]),
                   .Y(s_logisimBus25[1]));

   Mux4to1b1   m2 (.D0(s_logisimBus17[2]),
                   .D1(s_logisimBus18[2]),
                   .D2(s_logisimBus24[2]),
                   .D3(s_logisimBus19[2]),
                   .S(s_logisimBus7[1:0]),
                   .Y(s_logisimBus25[2]));

   Mux4to1b1   m3 (.D0(s_logisimBus17[3]),
                   .D1(s_logisimBus18[3]),
                   .D2(s_logisimBus24[3]),
                   .D3(s_logisimBus19[3]),
                   .S(s_logisimBus7[1:0]),
                   .Y(s_logisimBus25[3]));

endmodule
