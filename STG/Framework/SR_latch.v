module SR_Latch (
    input S, // Set input
    input R, // Reset input
    output Q, // Q output
    output Qn // Q' (inverted Q) output
);

    reg Q, Qn; 

    always @(S, R) begin
        if (R && S == 0) begin
            Q <= 1'b0;
            Qn <= 1'b1;
        end else if (S && R == 0) begin
            Q <= 1'b1;
            Qn <= 1'b0;
        end
    end

endmodule