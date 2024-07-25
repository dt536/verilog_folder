# Run with "vivado -mode batch -source vivado_script.tcl"
# This file creates a vivado project. Uncomment the last part of the script to generate a bitstream right away
file mkdir ./vivado
set outputdir ./vivado

# Note: This is specifically for the artix-7 chip used in the Cmod A7-15T. 
# Change the part number and edit the constraints if you are using something else!
create_project -force 7seg ./vivado -part xc7a35tcpg236-2

add_files -fileset constrs_1 ./cmoda7_constraints.xdc 
add_files { ./7seg_statemachine.v}

set_property top 7seg_statemachine [current_fileset]
update_compile_order -fileset sources_1

# Launch synthesis and implementation
launch_runs synth_1
wait_on_run synth_1
launch_runs impl_1 -to_step write_bitstream
wait_on_run impl_1
