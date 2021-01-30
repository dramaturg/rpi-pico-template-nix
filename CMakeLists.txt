cmake_minimum_required(VERSION 3.12)

# initialize the SDK based on PICO_SDK_PATH
# note: this must happen before project()
include(pico_sdk_import.cmake)

get_filename_component(ProjectId ${CMAKE_CURRENT_LIST_DIR} NAME)
string(REPLACE " " "_" ProjectId ${ProjectId})
project(${ProjectId} C CXX ASM)

set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_C_COMPILER_WORKS ON)
set(CMAKE_CXX_COMPILER_WORKS ON)
#set(CMAKE_RULE_MESSAGES OFF)
#set(CMAKE_VERBOSE_MAKEFILE ON)

set(COMMON_FLAGS "${COMMON_FLAGS} -Wall")
#SDK# set(COMMON_FLAGS "${COMMON_FLAGS} -Wconversion")
set(COMMON_FLAGS "${COMMON_FLAGS} -Wdouble-promotion")
set(COMMON_FLAGS "${COMMON_FLAGS} -Werror")
set(COMMON_FLAGS "${COMMON_FLAGS} -Wextra")
set(COMMON_FLAGS "${COMMON_FLAGS} -Wformat=2")
set(COMMON_FLAGS "${COMMON_FLAGS} -Wno-error=implicit-function-declaration")
set(COMMON_FLAGS "${COMMON_FLAGS} -Wno-error=return-type")
set(COMMON_FLAGS "${COMMON_FLAGS} -Wshadow")
set(COMMON_FLAGS "${COMMON_FLAGS} -Wno-sign-compare") #SDK
set(COMMON_FLAGS "${COMMON_FLAGS} -Wstack-usage=1000")
set(COMMON_FLAGS "${COMMON_FLAGS} -Wunreachable-code")
set(COMMON_FLAGS "${COMMON_FLAGS} -fno-common")
set(COMMON_FLAGS "${COMMON_FLAGS} -fstack-usage")
set(COMMON_FLAGS "${COMMON_FLAGS} -ffunction-sections")
set(COMMON_FLAGS "${COMMON_FLAGS} -fdata-sections")
set(COMMON_FLAGS "${COMMON_FLAGS} --data-sections")
set(COMMON_FLAGS "${COMMON_FLAGS} -Wduplicated-cond")
set(COMMON_FLAGS "${COMMON_FLAGS} -Wduplicated-branches")
set(COMMON_FLAGS "${COMMON_FLAGS} -Wlogical-op")
set(COMMON_FLAGS "${COMMON_FLAGS} -Wrestrict")
#SDK# set(COMMON_FLAGS "${COMMON_FLAGS} -Wnull-dereference")
set(COMMON_FLAGS "${COMMON_FLAGS} -Wdouble-promotion")
set(COMMON_FLAGS "${COMMON_FLAGS} -Wcast-align")
#SDK# set(COMMON_FLAGS "${COMMON_FLAGS} -Wcast-qual")
#SDK# set(COMMON_FLAGS "${COMMON_FLAGS} -Wformat-signedness")
set(COMMON_FLAGS "${COMMON_FLAGS} -Wframe-larger-than=32768")
set(COMMON_FLAGS "${COMMON_FLAGS} -Wno-error=maybe-uninitialized")
set(COMMON_FLAGS "${COMMON_FLAGS} -Wno-ignored-attributes")
set(COMMON_FLAGS "${COMMON_FLAGS} -Wno-missing-field-initializers")
set(COMMON_FLAGS "${COMMON_FLAGS} -Wno-strict-overflow")
set(COMMON_FLAGS "${COMMON_FLAGS} -Wno-unused-function")
set(COMMON_FLAGS "${COMMON_FLAGS} -Wno-unused-parameter") #SDK
set(COMMON_FLAGS "${COMMON_FLAGS} -Wno-variadic-macros")
set(COMMON_FLAGS "${COMMON_FLAGS} -Wodr")
#SDK# set(COMMON_FLAGS "${COMMON_FLAGS} -Wpedantic")
set(COMMON_FLAGS "${COMMON_FLAGS} -Wshift-overflow=2")
set(COMMON_FLAGS "${COMMON_FLAGS} -Wstrict-aliasing=2")
set(COMMON_FLAGS "${COMMON_FLAGS} -Wsuggest-final-methods")
set(COMMON_FLAGS "${COMMON_FLAGS} -Wsuggest-final-types")
set(COMMON_FLAGS "${COMMON_FLAGS} -Wsync-nand")
set(COMMON_FLAGS "${COMMON_FLAGS} -Wtrampolines")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${COMMON_FLAGS}")
#SDK# set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wjump-misses-init")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${COMMON_FLAGS}")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-sized-deallocation") #SDK

include_directories( lib )

# initialize the Pico SDK
pico_sdk_init()

# rest of your project
add_executable(main
    main.c
)

# Add pico_stdlib library which aggregates commonly used features
target_link_libraries(main pico_stdlib)

# enable usb output, disable uart output
pico_enable_stdio_usb(main 1)
pico_enable_stdio_uart(main 0)

# create map/bin/hex/uf2 file in addition to ELF.
pico_add_extra_outputs(main)
