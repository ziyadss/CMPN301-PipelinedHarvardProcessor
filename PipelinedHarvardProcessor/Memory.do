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
sim:/pipelinedprocessor/Execute/ALUEX/Result \
sim:/pipelinedprocessor/Memory/stackIn \
sim:/pipelinedprocessor/Memory/stackOut

add wave -position insertpoint  \
sim:/pipelinedprocessor/*                      \
sim:/pipelinedprocessor/Fetch/*                \
sim:/pipelinedprocessor/IF_ID_Buffer/*         \
sim:/pipelinedprocessor/Decode/*               \
sim:/pipelinedprocessor/ID_EX_Buffer/*         \
sim:/pipelinedprocessor/Execute/*              \
sim:/pipelinedprocessor/EX_MEM_Buffer/*        \
sim:/pipelinedprocessor/Memory/*               \
sim:/pipelinedprocessor/MEM_WB_Buffer/*        \
sim:/pipelinedprocessor/WriteBack/*            \
sim:/pipelinedprocessor/FW_Unit/*              \
sim:/pipelinedprocessor/Execute/ALUEX/tempFlag \
sim:/pipelinedprocessor/Execute/ALUEX/*        \
sim:/pipelinedprocessor/Execute/MUXOP1/*

mem load -i {D:/Uni/Sem6/CMPN301 Computer Architecture/Project/CMPN301-PipelinedHarvardProcessor/Assembler/Memory.mem} -update_properties /pipelinedprocessor/Fetch/RAM1/ram

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
force -freeze sim:/pipelinedprocessor/inPort 16#00000019 0
run
force -freeze sim:/pipelinedprocessor/inPort 16#0000FFFF 0
run
force -freeze sim:/pipelinedprocessor/inPort 16#0000F320 0
run
force -freeze sim:/pipelinedprocessor/inPort 16#FFFFF320 0
run
force -freeze sim:/pipelinedprocessor/inPort 16#00000010 0
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
run
mem save -o C:/Users/Ziyad/Desktop/check.mem -f {} /pipelinedprocessor/Memory/Memory/ram