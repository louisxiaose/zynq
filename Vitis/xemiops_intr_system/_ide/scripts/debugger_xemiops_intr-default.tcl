# Usage with Vitis IDE:
# In Vitis IDE create a Single Application Debug launch configuration,
# change the debug type to 'Attach to running target' and provide this 
# tcl script in 'Execute Script' option.
# Path of this script: D:\WorkSpace\Vitis\xemiops_intr_system\_ide\scripts\debugger_xemiops_intr-default.tcl
# 
# 
# Usage with xsct:
# To debug using xsct, launch xsct and run below command
# source D:\WorkSpace\Vitis\xemiops_intr_system\_ide\scripts\debugger_xemiops_intr-default.tcl
# 
connect -url tcp:127.0.0.1:3121
targets -set -nocase -filter {name =~"APU*"}
rst -system
after 3000
targets -set -nocase -filter {name =~"APU*"}
loadhw -hw D:/WorkSpace/Vitis/clg400_1_emio/export/clg400_1_emio/hw/ps_emio_wrapper.xsa -mem-ranges [list {0x40000000 0xbfffffff}] -regs
configparams force-mem-access 1
targets -set -nocase -filter {name =~"APU*"}
source D:/WorkSpace/Vitis/xemiops_intr/_ide/psinit/ps7_init.tcl
ps7_init
ps7_post_config
targets -set -nocase -filter {name =~ "*A9*#0"}
dow D:/WorkSpace/Vitis/xemiops_intr/Debug/xemiops_intr.elf
configparams force-mem-access 0
bpadd -addr &main
