module music_1 (
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
    case(address)// mokou
0:pre_set<=S;
1:pre_set<=S;
2:pre_set<=S;
3:pre_set<=S;
4:pre_set<=S;
5:pre_set<=S;
6:pre_set<=M3;
7:pre_set<=M5;
8:pre_set<=M6;
9:pre_set<=M6;
10:pre_set<=M6;
11:pre_set<=M6;
12:pre_set<=M7;
13:pre_set<=H1;
14:pre_set<=H3;
15:pre_set<=H3;
16:pre_set<=M6;
17:pre_set<=M6;
18:pre_set<=M6;
19:pre_set<=M6;
20:pre_set<=S;
21:pre_set<=M3;
22:pre_set<=M6;
23:pre_set<=M7;
24:pre_set<=H1;
25:pre_set<=H1;
26:pre_set<=M6;
27:pre_set<=M6;
28:pre_set<=M7;
29:pre_set<=M7;
30:pre_set<=M5;
31:pre_set<=M5;
32:pre_set<=M3;
33:pre_set<=M3;
34:pre_set<=M3;
35:pre_set<=M3;
36:pre_set<=M3;
37:pre_set<=M3;
38:pre_set<=M3;
39:pre_set<=S;
40:pre_set<=D6;
41:pre_set<=D6;
42:pre_set<=D6;
43:pre_set<=D6;
44:pre_set<=D7;
45:pre_set<=M1;
46:pre_set<=M3;
47:pre_set<=M3;
48:pre_set<=D6;
49:pre_set<=D6;
50:pre_set<=D6;
51:pre_set<=D6;
52:pre_set<=D51;
53:pre_set<=D51;
54:pre_set<=D51;
55:pre_set<=D51;
56:pre_set<=D6;
57:pre_set<=D7;
58:pre_set<=M1;
59:pre_set<=M3;
60:pre_set<=M1;
61:pre_set<=D7;
62:pre_set<=D6;
63:pre_set<=D7;
64:pre_set<=M1;
65:pre_set<=M2;
66:pre_set<=M3;
67:pre_set<=M5;
68:pre_set<=M6;
69:pre_set<=M6;
70:pre_set<=M6;
71:pre_set<=M6;//finish
72:pre_set<=S;
73:pre_set<=S;
74:pre_set<=S;
75:pre_set<=S;
76:pre_set<=S;
77:pre_set<=S;
78:pre_set<=D7;
79:pre_set<=M2;
80:pre_set<=M6;
81:pre_set<=M6;
82:pre_set<=M6;
83:pre_set<=M6;
84:pre_set<=M7;
85:pre_set<=H1;
86:pre_set<=H3;
87:pre_set<=H3;
88:pre_set<=M6;
89:pre_set<=M6;
90:pre_set<=M6;
91:pre_set<=M6;
92:pre_set<=S;
93:pre_set<=H3;
94:pre_set<=H6;
95:pre_set<=H7;
96:pre_set<=HH1;
97:pre_set<=HH1;
98:pre_set<=H6;
99:pre_set<=H6;
100:pre_set<=H7;
101:pre_set<=H7;
102:pre_set<=H5;
103:pre_set<=H5;
104:pre_set<=H3;
105:pre_set<=H3;
106:pre_set<=H3;
107:pre_set<=H3;
108:pre_set<=H3;
109:pre_set<=H3;
110:pre_set<=H3;
111:pre_set<=S;
112:pre_set<=M6;
113:pre_set<=M6;
114:pre_set<=M6;
115:pre_set<=M6;
116:pre_set<=M7;
117:pre_set<=H1;
118:pre_set<=H3;
119:pre_set<=H3;
120:pre_set<=M6;
121:pre_set<=M6;
122:pre_set<=M6;
123:pre_set<=M6;
124:pre_set<=M51;
125:pre_set<=M51;
126:pre_set<=M51;
127:pre_set<=M51;
128:pre_set<=M6;
129:pre_set<=M7;
130:pre_set<=H1;
131:pre_set<=H3;
132:pre_set<=H1;
133:pre_set<=M7;
134:pre_set<=M6;
135:pre_set<=M7;
136:pre_set<=H1;
137:pre_set<=H2;
138:pre_set<=H3;
139:pre_set<=H5;
140:pre_set<=H6;
141:pre_set<=H6;
142:pre_set<=H6;
143:pre_set<=H6;//finish
default:pre_set<=0;

    endcase
  end
end

endmodule