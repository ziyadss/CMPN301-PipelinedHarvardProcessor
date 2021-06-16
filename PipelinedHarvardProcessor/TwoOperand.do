vsim work.pipelinedprocessor
radix -hexadecimal
add wave -position insertpoint  \
sim:/pipelinedprocessor/clk \
sim:/pipelinedprocessor/reset \
sim:/pipelinedprocessor/inPort \
sim:/pipelinedprocessor/outPort \
sim:/pipelinedprocessor/Fetch/pcOut \
sim:/pipelinedprocessor/Decode/registerFileU/regOut \
sim:/pipelinedprocessor/Execute/CCREX/* \
sim:/pipelinedprocessor/Execute/ALUEX/Result

add wave  sim:/pipelinedprocessor/*
add wave  sim:/pipelinedprocessor/Fetch/*
add wave  sim:/pipelinedprocessor/IF_ID_Buffer/*
add wave  sim:/pipelinedprocessor/Decode/*
add wave  sim:/pipelinedprocessor/ID_EX_Buffer/*
add wave  sim:/pipelinedprocessor/Execute/*
add wave  sim:/pipelinedprocessor/EX_MEM_Buffer/*
add wave  sim:/pipelinedprocessor/Memory/*
add wave  sim:/pipelinedprocessor/MEM_WB_Buffer/*
add wave  sim:/pipelinedprocessor/WriteBack/*
add wave  sim:/pipelinedprocessor/FW_Unit/*
add wave  sim:/pipelinedprocessor/Execute/ALUEX/tempFlag
add wave  sim:/pipelinedprocessor/Execute/ALUEX/*
add wave  sim:/pipelinedprocessor/Execute/MUXOP1/*

mem load -i {D:/Uni/Sem6/CMPN301 Computer Architecture/Project/CMPN301-PipelinedHarvardProcessor/Assembler/TwoOperand.mem} -update_properties /pipelinedprocessor/Fetch/RAM1/ram

force -freeze sim:/pipelinedprocessor/clk 0 0
force -freeze sim:/pipelinedprocessor/reset 1 0
force -freeze sim:/pipelinedprocessor/inPort 16#00000000 0
run 50ps

force -freeze sim:/pipelinedprocessor/clk 1 0
run 50ps

force -freeze sim:/pipelinedprocessor/reset 0 0
force -freeze sim:/pipelinedprocessor/clk 0 0
run 50ps

force -freeze sim:/pipelinedprocessor/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/pipelinedprocessor/inPort 16#00000005 0
run
force -freeze sim:/pipelinedprocessor/inPort 16#00000019 0
run
force -freeze sim:/pipelinedprocessor/inPort 16#FFFFFFFF 0
run
force -freeze sim:/pipelinedprocessor/inPort 16#FFFFF320 0
run
run
run
run
run
run
run
run
run
run
run
run