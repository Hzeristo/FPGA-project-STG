module PS2_Interface (
    input wire clk,  // Main clock
    input wire rst,  // Reset signal
    input wire ps2_data, // PS/2 Data line
    input wire ps2_clk, // PS/2 Clock line
    output reg [7:0] last_key // Last key pressed
);

    // State variables
    reg [3:0] bit_count = 0; // Count bits received
    reg [10:0] shift_reg = 0; // Shift register for incoming data

    // Detect falling edge of the PS/2 clock
    reg [2:0] ps2_clk_sync = 0;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            ps2_clk_sync <= 0;
        end else begin
            ps2_clk_sync <= {ps2_clk_sync[1:0], ps2_clk};
        end
    end

    wire negedge_ps2_clk = ps2_clk_sync[1] && !ps2_clk_sync[2];

    // Capture data at every falling edge of clock
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            bit_count <= 0;
            shift_reg <= 0;
        end else if(negedge_ps2_clk) begin
            if (bit_count < 11) begin
                shift_reg <= {ps2_data, shift_reg[10:1]};
                bit_count <= bit_count + 1;
            end else begin
                bit_count <= 0; // Reset bit count after one frame received
                // Save the 8-bit scan code (ignoring start, parity, and stop bits)
                last_key <= shift_reg[8:1];
            end
        end
    end

endmodule
