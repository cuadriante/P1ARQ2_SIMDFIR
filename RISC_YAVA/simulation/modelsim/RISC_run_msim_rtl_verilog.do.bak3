transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/Joseff01/Documents/Git/P1ARQ2_SIMDFIR/RISC_YAVA {C:/Users/Joseff01/Documents/Git/P1ARQ2_SIMDFIR/RISC_YAVA/VMult.v}
vlog -vlog01compat -work work +incdir+C:/Users/Joseff01/Documents/Git/P1ARQ2_SIMDFIR/RISC_YAVA {C:/Users/Joseff01/Documents/Git/P1ARQ2_SIMDFIR/RISC_YAVA/VAdder.v}
vlog -vlog01compat -work work +incdir+C:/Users/Joseff01/Documents/Git/P1ARQ2_SIMDFIR/RISC_YAVA {C:/Users/Joseff01/Documents/Git/P1ARQ2_SIMDFIR/RISC_YAVA/Writeback_Cycle.v}
vlog -vlog01compat -work work +incdir+C:/Users/Joseff01/Documents/Git/P1ARQ2_SIMDFIR/RISC_YAVA {C:/Users/Joseff01/Documents/Git/P1ARQ2_SIMDFIR/RISC_YAVA/Sign_Extend.v}
vlog -vlog01compat -work work +incdir+C:/Users/Joseff01/Documents/Git/P1ARQ2_SIMDFIR/RISC_YAVA {C:/Users/Joseff01/Documents/Git/P1ARQ2_SIMDFIR/RISC_YAVA/Register_File.v}
vlog -vlog01compat -work work +incdir+C:/Users/Joseff01/Documents/Git/P1ARQ2_SIMDFIR/RISC_YAVA {C:/Users/Joseff01/Documents/Git/P1ARQ2_SIMDFIR/RISC_YAVA/Pipeline_top.v}
vlog -vlog01compat -work work +incdir+C:/Users/Joseff01/Documents/Git/P1ARQ2_SIMDFIR/RISC_YAVA {C:/Users/Joseff01/Documents/Git/P1ARQ2_SIMDFIR/RISC_YAVA/PC_Adder.v}
vlog -vlog01compat -work work +incdir+C:/Users/Joseff01/Documents/Git/P1ARQ2_SIMDFIR/RISC_YAVA {C:/Users/Joseff01/Documents/Git/P1ARQ2_SIMDFIR/RISC_YAVA/PC.v}
vlog -vlog01compat -work work +incdir+C:/Users/Joseff01/Documents/Git/P1ARQ2_SIMDFIR/RISC_YAVA {C:/Users/Joseff01/Documents/Git/P1ARQ2_SIMDFIR/RISC_YAVA/Mux.v}
vlog -vlog01compat -work work +incdir+C:/Users/Joseff01/Documents/Git/P1ARQ2_SIMDFIR/RISC_YAVA {C:/Users/Joseff01/Documents/Git/P1ARQ2_SIMDFIR/RISC_YAVA/Memory_Cycle.v}
vlog -vlog01compat -work work +incdir+C:/Users/Joseff01/Documents/Git/P1ARQ2_SIMDFIR/RISC_YAVA {C:/Users/Joseff01/Documents/Git/P1ARQ2_SIMDFIR/RISC_YAVA/Main_Decoder.v}
vlog -vlog01compat -work work +incdir+C:/Users/Joseff01/Documents/Git/P1ARQ2_SIMDFIR/RISC_YAVA {C:/Users/Joseff01/Documents/Git/P1ARQ2_SIMDFIR/RISC_YAVA/Instruction_Memory.v}
vlog -vlog01compat -work work +incdir+C:/Users/Joseff01/Documents/Git/P1ARQ2_SIMDFIR/RISC_YAVA {C:/Users/Joseff01/Documents/Git/P1ARQ2_SIMDFIR/RISC_YAVA/Fetch_Cycle.v}
vlog -vlog01compat -work work +incdir+C:/Users/Joseff01/Documents/Git/P1ARQ2_SIMDFIR/RISC_YAVA {C:/Users/Joseff01/Documents/Git/P1ARQ2_SIMDFIR/RISC_YAVA/Execute_Cycle.v}
vlog -vlog01compat -work work +incdir+C:/Users/Joseff01/Documents/Git/P1ARQ2_SIMDFIR/RISC_YAVA {C:/Users/Joseff01/Documents/Git/P1ARQ2_SIMDFIR/RISC_YAVA/Decode_Cycle.v}
vlog -vlog01compat -work work +incdir+C:/Users/Joseff01/Documents/Git/P1ARQ2_SIMDFIR/RISC_YAVA {C:/Users/Joseff01/Documents/Git/P1ARQ2_SIMDFIR/RISC_YAVA/Data_Memory.v}
vlog -vlog01compat -work work +incdir+C:/Users/Joseff01/Documents/Git/P1ARQ2_SIMDFIR/RISC_YAVA {C:/Users/Joseff01/Documents/Git/P1ARQ2_SIMDFIR/RISC_YAVA/Control_Unit_Top.v}
vlog -vlog01compat -work work +incdir+C:/Users/Joseff01/Documents/Git/P1ARQ2_SIMDFIR/RISC_YAVA {C:/Users/Joseff01/Documents/Git/P1ARQ2_SIMDFIR/RISC_YAVA/ALU_Decoder.v}
vlog -vlog01compat -work work +incdir+C:/Users/Joseff01/Documents/Git/P1ARQ2_SIMDFIR/RISC_YAVA {C:/Users/Joseff01/Documents/Git/P1ARQ2_SIMDFIR/RISC_YAVA/ALU.v}
vlog -vlog01compat -work work +incdir+C:/Users/Joseff01/Documents/Git/P1ARQ2_SIMDFIR/RISC_YAVA {C:/Users/Joseff01/Documents/Git/P1ARQ2_SIMDFIR/RISC_YAVA/Hazard_Unit.v}

vlog -sv -work work +incdir+C:/Users/Joseff01/Documents/Git/P1ARQ2_SIMDFIR/RISC_YAVA {C:/Users/Joseff01/Documents/Git/P1ARQ2_SIMDFIR/RISC_YAVA/ALU_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  ALU_tb

add wave *
view structure
view signals
run -all
