ASM_FILE=tests/bonus.asm
MEM_FILE=tests/mem.asm
# You need to source this file.
alias vcom='~/intelFPGA/20.1/modelsim_ase/bin/vcom -2008 -work work -explicit -stats=none'
alias vsim='~/intelFPGA/20.1/modelsim_ase/bin/vsim'
# Kill the current modelsim instance if there were any.
pkill vish
# Remove the compiled work.
rm -rf work
# Generate all the buffers.
./Buffers/gen_all.py
# Generate mips.mpf.
./gen_mips.py
# Compile the vhd files.
vcom */*.vhd MIPS.vhd
# Generate the instruciton memory.
cat ins.sav > ins.mem
./assm.py -f hex -d $'\n' -i $ASM_FILE >> ins.mem
# Generate the data memory.
cat mem.sav > mem.mem
#./assm.py -f hex -d $'\n' -i $MEM_FILE >> mem.mem
# Open modelsim in the background.
vsim mips.mpf&
# Disown the current modelsim instance.
# NOTE: This disowns other programs when this script is sourced.
disown
