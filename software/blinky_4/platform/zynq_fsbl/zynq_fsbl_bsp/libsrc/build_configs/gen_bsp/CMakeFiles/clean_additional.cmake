# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "")
  file(REMOVE_RECURSE
  "/home/richard/code/jarvis/software/blinky_4/platform/zynq_fsbl/zynq_fsbl_bsp/include/diskio.h"
  "/home/richard/code/jarvis/software/blinky_4/platform/zynq_fsbl/zynq_fsbl_bsp/include/ff.h"
  "/home/richard/code/jarvis/software/blinky_4/platform/zynq_fsbl/zynq_fsbl_bsp/include/ffconf.h"
  "/home/richard/code/jarvis/software/blinky_4/platform/zynq_fsbl/zynq_fsbl_bsp/include/sleep.h"
  "/home/richard/code/jarvis/software/blinky_4/platform/zynq_fsbl/zynq_fsbl_bsp/include/xilffs.h"
  "/home/richard/code/jarvis/software/blinky_4/platform/zynq_fsbl/zynq_fsbl_bsp/include/xilffs_config.h"
  "/home/richard/code/jarvis/software/blinky_4/platform/zynq_fsbl/zynq_fsbl_bsp/include/xilrsa.h"
  "/home/richard/code/jarvis/software/blinky_4/platform/zynq_fsbl/zynq_fsbl_bsp/include/xiltimer.h"
  "/home/richard/code/jarvis/software/blinky_4/platform/zynq_fsbl/zynq_fsbl_bsp/include/xtimer_config.h"
  "/home/richard/code/jarvis/software/blinky_4/platform/zynq_fsbl/zynq_fsbl_bsp/lib/libxilffs.a"
  "/home/richard/code/jarvis/software/blinky_4/platform/zynq_fsbl/zynq_fsbl_bsp/lib/libxilrsa.a"
  "/home/richard/code/jarvis/software/blinky_4/platform/zynq_fsbl/zynq_fsbl_bsp/lib/libxiltimer.a"
  )
endif()
