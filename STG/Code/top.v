module Top_module(
    input clk, //rstn,        //clk & rst negative signal     
//    input SW,               //switch for controlling buzzer
//    output hsync, vsync,    //horizontal & vertical scan signal
//   output [11:0] rgb,      //rgb value to VGA port
    output buzzer           //buzzer module
);

wire beep;
assign buzzer = beep;

music_room music_unit(.clk(clk), .rst_n(1), .beep(beep));

endmodule