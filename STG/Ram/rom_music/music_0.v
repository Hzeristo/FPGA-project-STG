module music_0 (
    input clk,
    input rst_n;
    input address,
    output reg[32:0] note
);

//time intervals of each note
localparam     
         
M1=95602,           //1
M11=90253,          //1#
M2=85178,           //2
M21=80386,          //2#
M3=75872,           //3
M4=71633,           //4
M41=67568,          //4#
M5=63775,           //5
M51=60168,          //5#
M6=56818,           //6
M61=53648,          //6#
M7=50607,           //7

H1=47801,           //1
H11=45086,          //1#
H2=42553,           //2
H21=40161,          //2#
H3=37936,           //3
H4=35791,           //4
H41=33784,          //4#
H5=31888,           //5
H51=30102,          //5#
H6=28409,           //6
H61=26810,          //6#
H7=25303,           //7

HH1=23883,
HH2=22543,

D5=127551,          //5
D51=120482,         //5#
D6=113636,          //6
D61=107296,         //6#
D7=101215,          //7
S=2500             //休止符

always @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
    pre_set <= 0;  
  end else begin
    case(address)// 众神眷恋的幻想乡
0: pre_set <= S;
1: pre_set <= S;
2: pre_set <= S;
3: pre_set <= S;
4: pre_set <= M3;
5: pre_set <= M3;
6: pre_set <= M3;
7: pre_set <= S;
8: pre_set <= M3;
9: pre_set <= M3;
10: pre_set <= M3;
11: pre_set <= S;
12: pre_set <= M5;
13: pre_set <= M5;
14: pre_set <= M5;
15: pre_set <= S;
16: pre_set <= M6;
17: pre_set <= M6;
18: pre_set <= M6;
19: pre_set <= M6;
20: pre_set <= M6;
21: pre_set <= M6;
22: pre_set <= M5;
23: pre_set <= M6;
24: pre_set <= M5;
25: pre_set <= M5;
26: pre_set <= M3;
27: pre_set <= M3;
28: pre_set <= M2;
29: pre_set <= M2;
30: pre_set <= M5;
31: pre_set <= M5;
32: pre_set <= M3;
33: pre_set <= M3;
34: pre_set <= M3;
35: pre_set <= M3;
36: pre_set <= M3;
37: pre_set <= M3;
38: pre_set <= M3;
39: pre_set <= M3;
40: pre_set <= M3;
41: pre_set <= M3;
42: pre_set <= M3;
43: pre_set <= S;
44: pre_set <= M3;
45: pre_set <= M3;
46: pre_set <= M5;
47: pre_set <= M5;
48: pre_set <= M6;
49: pre_set <= M6;
50: pre_set <= M6;
51: pre_set <= M6;
52: pre_set <= M6;
53: pre_set <= S;
54: pre_set <= M5;
55: pre_set <= M6;
56: pre_set <= H1;  // high1
57: pre_set <= H1;
58: pre_set <= M7;
59: pre_set <= M7;
60: pre_set <= M6;
61: pre_set <= M6;
62: pre_set <= M5;
63: pre_set <= M5;
64: pre_set <= M6;
65: pre_set <= M6;
66: pre_set <= M6;
67: pre_set <= M6;
68: pre_set <= M6;
69: pre_set <= M6;
70: pre_set <= M6;
71: pre_set <= M6;
72: pre_set <= M6;
73: pre_set <= S;
74: pre_set <= M5;
75: pre_set <= M6;
76: pre_set <= M5;
77: pre_set <= M5;
78: pre_set <= M3;
79: pre_set <= M3;
80: pre_set <= M2;
81: pre_set <= M2;
82: pre_set <= M2;
83: pre_set <= M2;
84: pre_set <= M2;
85: pre_set <= M2;
86: pre_set <= M2;
87: pre_set <= M2;
88: pre_set <= M2;
89: pre_set <= S;
90: pre_set <= M5;
91: pre_set <= M6;
92: pre_set <= M5;
93: pre_set <= M5;
94: pre_set <= M2;
95: pre_set <= M2;
96: pre_set <= M1;
97: pre_set <= M1;
98: pre_set <= M1;
99: pre_set <= M1;
100: pre_set <= M1;
101: pre_set <= M1;
102: pre_set <= M1;
103: pre_set <= M1;
104: pre_set <= M1;
105: pre_set <= M1;
106: pre_set <= M1;
107: pre_set <= S;
108: pre_set <= D6;
109: pre_set <= D6;
110: pre_set <= D7;
111: pre_set <= D7;
112: pre_set <= M1;
113: pre_set <= M1;
114: pre_set <= M1;
115: pre_set <= M1;
116: pre_set <= M1;
117: pre_set <= M1;
118: pre_set <= M2;
119: pre_set <= M2;
120: pre_set <= D7;
121: pre_set <= D7;
122: pre_set <= D7;
123: pre_set <= D7;
124: pre_set <= D7;
125: pre_set <= D7;
126: pre_set <= D6;
127: pre_set <= D6;  // finish
default: pre_set <= 0;
    endcase
  end
end

endmodule