module ShiftReg8b(
    input       clk,
    input       shiftn_loadp,
    input       shift_in,
    input [7:0] par_in,
    output reg [7:0] Q
);

    always @(posedge clk) begin
        if (shiftn_loadp == 1'b0) begin
            Q <= {shift_in, Q[7:1]};
        end else begin
            Q <= par_in;
        end
    end

endmodule
