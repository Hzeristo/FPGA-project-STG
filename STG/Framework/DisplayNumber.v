/******************************************************************************
 ** Logisim-evolution goes FPGA automatic generated Verilog code             **
 ** https://github.com/logisim-evolution/                                    **
 **                                                                          **
 ** Component : DisplayNumber                                                **
 **                                                                          **
 *****************************************************************************/

module DisplayNumber( AN,
                      LEs,
                      SEGMENT,
                      clk,
                      hexs,
                      points,
                      rst );

   /*******************************************************************************
   ** The inputs are defined here                                                **
   *******************************************************************************/
   input [3:0]  LEs;
   input        clk;
   input [15:0] hexs;
   input [3:0]  points;
   input        rst;

   /*******************************************************************************
   ** The outputs are defined here                                               **
   *******************************************************************************/
   output [3:0] AN;
   output [7:0] SEGMENT;

   /*******************************************************************************
   ** The wires are defined here                                                 **
   *******************************************************************************/
   wire [7:0]  s_logisimBus10;
   wire [15:0] s_logisimBus11;
   wire [3:0]  s_logisimBus12;
   wire [3:0]  s_logisimBus2;
   wire [31:0] s_logisimBus21;
   wire [3:0]  s_logisimBus8;
   wire [3:0]  s_logisimBus9;
   wire        s_logisimNet0;
   wire        s_logisimNet13;
   wire        s_logisimNet14;
   wire        s_logisimNet15;
   wire        s_logisimNet16;
   wire        s_logisimNet17;
   wire        s_logisimNet18;
   wire        s_logisimNet19;
   wire        s_logisimNet20;
   wire        s_logisimNet22;
   wire        s_logisimNet23;
   wire        s_logisimNet3;
   wire        s_logisimNet4;
   wire        s_logisimNet5;
   wire        s_logisimNet6;
   wire        s_logisimNet7;

   /*******************************************************************************
   ** The module functionality is described here                                 **
   *******************************************************************************/

   /*******************************************************************************
   ** Here all input connections are defined                                     **
   *******************************************************************************/
   assign s_logisimBus11[15:0] = hexs;
   assign s_logisimBus8[3:0]   = points;
   assign s_logisimBus9[3:0]   = LEs;
   assign s_logisimNet22       = clk;
   assign s_logisimNet23       = rst;

   /*******************************************************************************
   ** Here all output connections are defined                                    **
   *******************************************************************************/
   assign AN      = s_logisimBus2[3:0];
   assign SEGMENT = s_logisimBus10[7:0];

   /*******************************************************************************
   ** Here all sub-circuits are defined                                          **
   *******************************************************************************/

   MyMC14495   m0 (.D0(s_logisimBus12[0]),
                   .D1(s_logisimBus12[1]),
                   .D2(s_logisimBus12[2]),
                   .D3(s_logisimBus12[3]),
                   .LE(s_logisimNet7),
                   .a(s_logisimBus10[0]),
                   .b(s_logisimBus10[1]),
                   .c(s_logisimBus10[2]),
                   .d(s_logisimBus10[3]),
                   .e(s_logisimBus10[4]),
                   .f(s_logisimBus10[5]),
                   .g(s_logisimBus10[6]),
                   .p(s_logisimBus10[7]),
                   .point(s_logisimNet0));

   DisplaySync   d0 (.AN(s_logisimBus2[3:0]),
                     .HEX(s_logisimBus12[3:0]),
                     .LE(s_logisimNet7),
                     .LEs(s_logisimBus9[3:0]),
                     .hexs(s_logisimBus11[15:0]),
                     .point(s_logisimNet0),
                     .points(s_logisimBus8[3:0]),
                     .scan(s_logisimBus21[18:17]));

   clkdiv   c0 (.clk(s_logisimNet22),
                .div_res(s_logisimBus21[31:0]),
                .rst(s_logisimNet23));

endmodule
