cmake_minimum_required(VERSION 3.12)

set(PICO_SDK_PATH ${TOP}/hw/mcu/raspberrypi/pico-sdk)
include(${PICO_SDK_PATH}/pico_sdk_init.cmake)

project(${PROJECT})

pico_sdk_init()

add_executable(${PROJECT})

# TinyUSB Stack source
set(SRC_TINYUSB
	${TOP}/src/tusb.c
	${TOP}/src/common/tusb_fifo.c
	${TOP}/src/device/usbd.c
	${TOP}/src/device/usbd_control.c
	${TOP}/src/class/audio/audio_device.c
	${TOP}/src/class/cdc/cdc_device.c
	${TOP}/src/class/dfu/dfu_rt_device.c
	${TOP}/src/class/hid/hid_device.c
	${TOP}/src/class/midi/midi_device.c
	${TOP}/src/class/msc/msc_device.c
	${TOP}/src/class/net/net_device.c
	${TOP}/src/class/usbtmc/usbtmc_device.c
	${TOP}/src/class/vendor/vendor_device.c
	${TOP}/src/portable/raspberrypi/${FAMILY}/dcd_rp2040.c
	${TOP}/src/portable/raspberrypi/${FAMILY}/rp2040_usb.c
)

target_sources(${PROJECT} PUBLIC
  ${TOP}/hw/bsp/${FAMILY}/family.c
  ${SRC_TINYUSB}
)

target_include_directories(${PROJECT} PUBLIC
  ${TOP}/hw
  ${TOP}/src
  ${TOP}/hw/bsp/${FAMILY}/boards/${BOARD}
)

target_compile_definitions(${PROJECT} PUBLIC
  CFG_TUSB_MCU=OPT_MCU_RP2040
  CFG_TUSB_OS=OPT_OS_PICO
)

target_link_libraries(${PROJECT} pico_stdlib)

pico_add_extra_outputs(${PROJECT})
