transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vmap -link {D:/CodesPractice/learning/DL/FPGA-project-STG/stg_project/stg_project.cache/compile_simlib/riviera}
vlib riviera/xpm
vlib riviera/dist_mem_gen_v8_0_13
vlib riviera/xil_defaultlib

vlog -work xpm  -incr -l xpm -l dist_mem_gen_v8_0_13 -l xil_defaultlib \
"D:/Xilinx/Vivado/2023.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93  -incr \
"D:/Xilinx/Vivado/2023.1/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work dist_mem_gen_v8_0_13  -incr -v2k5 -l xpm -l dist_mem_gen_v8_0_13 -l xil_defaultlib \
"../../../ipstatic/simulation/dist_mem_gen_v8_0.v" \

vlog -work xil_defaultlib  -incr -v2k5 -l xpm -l dist_mem_gen_v8_0_13 -l xil_defaultlib \
"../../../../stg_project.gen/sources_1/ip/playerhit_dist_mem/sim/playerhit_dist_mem.v" \


vlog -work xil_defaultlib \
"glbl.v"

