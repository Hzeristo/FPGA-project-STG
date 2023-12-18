module music_room (
  input clk,
  input rst_n,
  input music_name,
  output beep
);

reg [16:0] cnt0;  //control the frequency of buzzer
wire add_cnt0;
wire end_cnt0;

reg [10:0] cnt1;   //control the length of each note
wire add_cnt1;
wire end_cnt1;

reg [10:0] cnt2;   //control the length of whole music
wire add_cnt2;
wire end_cnt2;

reg [16:0] note_to_be_played, note0, note1, note2, note3;
reg [10:0] /*num_cnt1,*/ num_cnt2;

reg [32:0] clk0, clk1, clk2, clk3;

music_0 get_note0(.clk(clk0), .rst_n(rst_n), .address(cnt2), .note(note0));
music_1 get_note1(.clk(clk1), .rst_n(rst_n), .address(cnt2), .note(note1));
music_2 get_note2(.clk(clk2), .rst_n(rst_n), .address(cnt2), .note(note2));
music_3 get_note3(.clk(clk3), .rst_n(rst_n), .address(cnt2), .note(note3));

always @(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
    num_cnt2 <= 0;
  end else begin
    if(music_name == 0) begin //神恋
      num_cnt2 <= 127;
    end else if(music_name == 1) begin //mokou
      num_cnt2 <= 143;
    end else if(music_name == 2) begin //稻田姬
      num_cnt2 <= 383;
    end else if(music_name == 3) begin //纯狐
      num_cnt2 <= 1024;
    end
  end
end

always @(posedge clk or negedge clk or negedge rst_n) begin
    if(music_name == 0) begin //神恋
      clk0 <= clk;
      note_to_be_played <= note0;
    end else if(music_name == 1) begin //mokou
      clk1 <= clk;
      note_to_be_played <= note1;
    end else if(music_name == 2) begin //稻田姬
      clk2 <= clk;
      note_to_be_played <= note2;
    end else if(music_name == 3) begin //纯狐
      clk3 <= clk;
      note_to_be_played <= note3;
    end
end

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
assign end_cnt0 = add_cnt0 && cnt0 == note_to_be_played - 1;
assign beep = (cnt0 >= (note_to_be_played / 2)) ? 1 : 0;      //second half wave is high

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
assign end_cnt1 = add_cnt1 && cnt1 == 300 - 1;      //each note oscillate for 300 times, about 1s.

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
assign end_cnt2 = add_cnt2 && cnt2 >= num_cnt2 - 1;

endmodule