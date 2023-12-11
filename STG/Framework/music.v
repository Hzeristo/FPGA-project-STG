module beep_music (
  input clk,
  input rst_n,
  output beep
);

reg [16:0] cnt0;
wire add_cnt0;
wire end_cnt0;

reg [8:0] cnt1;
wire add_cnt1;
wire end_cnt1;

reg [5:0] cnt2;
wire add_cnt2;
wire end_cnt2;

reg [16:0] pre_set;

localparam M1=95602, M2=85178, M3=75872, M4=71633, M5=63775, M6=56818, M7=50607;
localparam D5=127551;

always @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
    cnt0 <= 0;
  end else if (add_cnt0) begin
    if (end_cnt0)
      cnt0 <= 0;
    else
      cnt0 <= cnt0 + 1;  
  end
end

assign add_cnt0 = 1'b1;
assign end_cnt0 = add_cnt0 && cnt0 == pre_set - 1;
assign beep = (cnt0 >= (pre_set / 2)) ? 1 : 0;

always @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
    cnt1 <= 0;
  end else if (add_cnt1) begin
    if (end_cnt1)
      cnt1 <= 0;
    else
      cnt1 <= cnt1 + 1; 
  end
end

assign add_cnt1 = end_cnt0;
assign end_cnt1 = add_cnt1 && cnt1 == 300 - 1;

always @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
    cnt2 <= 0;  
  end else if (add_cnt2) begin
    if (end_cnt2)
      cnt2 <= 0;   
    else 
      cnt2 <= cnt2 + 1;
  end
end

assign add_cnt2 = end_cnt1;
assign end_cnt2 = add_cnt2 && cnt2 == 32 - 1;

always @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
    pre_set <= 0;  
  end else begin
    case(cnt2)
      0: pre_set <= M1;
      1: pre_set <= M2;
      2: pre_set <= M3;
      3: pre_set <= M1;
      4: pre_set <= M1;
      5: pre_set <= M2;
      6: pre_set <= M3;
      7: pre_set <= M1;
      8: pre_set <= M3;
      9: pre_set <= M4;
      10: pre_set <= M5;
      11: pre_set <= M3;
      12: pre_set <= M4;
      13: pre_set <= M5;
      14: pre_set <= M5;
      15: pre_set <= M6;
      16: pre_set <= M5;
      17: pre_set <= M4;
      18: pre_set <= M3;
      19: pre_set <= M1;
      20: pre_set <= M5;
      21: pre_set <= M6;
      22: pre_set <= M5;
      23: pre_set <= M4;
      24: pre_set <= M3;
      25: pre_set <= M1;
      26: pre_set <= M2;
      27: pre_set <= D5;
      28: pre_set <= M1;
      29: pre_set <= M2;
      30: pre_set <= D5;
      31: pre_set <= M1;
      default: pre_set <= 0;
    endcase
  end
end

endmodule
