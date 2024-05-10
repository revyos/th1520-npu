#!/bin/sh
KERNEL_VER=$(uname -r)
BASE_PATH=/lib/modules/${KERNEL_VER}/extra

insmod $BASE_PATH/img_mem.ko
insmod $BASE_PATH/vha.ko onchipmem_phys_start=0xffe0001000 onchipmem_size=0x100000 freq_khz=792000
insmod $BASE_PATH/vha_info.ko

#if [ -f /sys/kernel/debug/dynamic_debug/control ]; then
#  echo -n 'module vha +p' > /sys/kernel/debug/dynamic_debug/control;
#  echo -n 'module img_mem +p' > /sys/kernel/debug/dynamic_debug/control;
#fi

chmod a+rw /dev/vha0
