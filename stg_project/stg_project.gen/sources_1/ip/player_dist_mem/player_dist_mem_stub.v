// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.1 (win64) Build 3865809 Sun May  7 15:05:29 MDT 2023
// Date        : Thu Jan  4 17:20:58 2024
// Host        : SRZbook running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               d:/CodesPractice/learning/DL/FPGA-project-STG/stg_project/stg_project.gen/sources_1/ip/player_dist_mem/player_dist_mem_stub.v
// Design      : player_dist_mem
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k160tffg676-2L
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "dist_mem_gen_v8_0_13,Vivado 2023.1" *)
module player_dist_mem(a, spo)
/* synthesis syn_black_box black_box_pad_pin="a[10:0],spo[11:0]" */;
  input [10:0]a;
  output [11:0]spo;
endmodule
