transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

asim +access +r +m+cover_blk_mem  -L xpm -L blk_mem_gen_v8_4_6 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.cover_blk_mem xil_defaultlib.glbl

do {cover_blk_mem.udo}

run 1000ns

endsim

quit -force
