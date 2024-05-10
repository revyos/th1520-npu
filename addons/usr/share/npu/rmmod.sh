#!/bin/sh

#if [ -f /sys/kernel/debug/dynamic_debug/control ]; then
#  echo -n 'module vha -p' > /sys/kernel/debug/dynamic_debug/control;
#  echo -n 'module img_mem -p' > /sys/kernel/debug/dynamic_debug/control;
#fi

rmmod vha_info
rmmod vha
rmmod img_mem
