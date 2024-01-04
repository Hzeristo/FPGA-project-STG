onbreak {quit -f}
onerror {quit -f}

vsim  -lib xil_defaultlib moon_dist_mem_opt

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {wave.do}

view wave
view structure
view signals

do {moon_dist_mem.udo}

run 1000ns

quit -force
