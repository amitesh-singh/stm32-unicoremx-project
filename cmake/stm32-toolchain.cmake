#
# stm32 cmake toolchain for unicore-mx
# Copyright (C) 2017 Amitesh Singh <singh.amitesh@gmail.com>
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.
#
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this library;
# if not, see <http://www.gnu.org/licenses/>.
#
include(CMakeForceCompiler)

set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_VERSION   1)
set(CMAKE_SYSTEM_PROCESSOR cortex-m3)

find_program(ARM_CC arm-none-eabi-gcc
    ${TOOLCHAIN_DIR}/bin)
find_program(ARM_CXX arm-none-eabi-g++
            ${TOOLCHAIN_DIR}/bin)
find_program(ARM_OBJCOPY arm-none-eabi-objcopy
            ${TOOLCHAIN_DIR}/bin)
find_program(ARM_SIZE_TOOL arm-none-eabi-size
            ${TOOLCHAIN_DIR}/bin)
find_program(ARM_AS arm-none-eabi-as
            ${TOOLCHAIN_DIR}/bin)

find_program(ARM_LD arm-none-eabi-ld
             ${TOOLCHAIN_DIR}/bin)
find_program(ARM_OBJCOPY arm-none-eabi-objcopy
             ${TOOLCHAIN_DIR}/bin)
find_program(ARM_SIZE arm-none-eabi-size
             ${TOOLCHAIN_DIR}/bin)
find_program(ARM_STRIP arm-none-eabi-strip
             ${TOOLCHAIN_DIR}/bin)

find_program(ST_FLASH st-flash)
find_program(ST_INFO st-info)

CMAKE_FORCE_C_COMPILER(${ARM_CC} GNU)
CMAKE_FORCE_CXX_COMPILER(${ARM_CXX} GNU)
set(CMAKE_ASM_FLAGS ${CMAKE_ASM_FLAGS} "-mcpu=cortex-m3 -mthumb")

set(BASE_PATH "${${PROJECT_NAME}_SOURCE_DIR}")
set(SRC_PATH "${BASE_PATH}/src")
set(LIB_PATH "${BASE_PATH}/lib")

if (NOT DEFINED MCU)
  set(MCU STM32F1)
endif ()

add_definitions(-D${MCU})

set(STM32FX_COMMONFLAGS "-Os -g -Wall -Wextra -Wshadow -mcpu=cortex-m3 -mthumb -mthumb-interwork \
    -fdata-sections -ffunction-sections -msoft-float -fno-common " CACHE STRING "")
set(STM32FX_CFLAGS " ${STM32FX_COMMONFLAGS} -fno-exceptions -Wimplicit-function-declaration \
    -Wredundant-decls -Wmissing-prototypes -Wstrict-prototypes " CACHE STRING "")
set(STM32FX_CXXFLAGS "${STM32FX_COMMONFLAGS} -fno-exceptions -Wextra -Wshadow -Wredundant-decls \
    -Weffc++" CACHE STRING "")

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS}  ${STM32FX_CFLAGS} -std=c99 " CACHE STRING "" )
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} --std=c++14 ${STM32FX_CXXFLAGS} " CACHE STRING "" )
# -lnosys --specs=rdimon.specs - removed
set(CMAKE_EXE_LINKER_FLAGS   " -flto -T ${CMAKE_SOURCE_DIR}/libucmx.ld -nostartfiles -lucmx_stm32f1 -lc \
    -specs=nosys.specs -Wl,--gc-sections -Wl,--relax" CACHE STRING "")

include_directories(${LIBUCMX_DIR}/include)
link_directories(${LIBUCMX_DIR}/lib)
link_libraries(ucmx_stm32f1)

function(add_executable_stm32fx NAME)
    add_executable(${NAME} ${ARGN})
    set_target_properties(${NAME} PROPERTIES OUTPUT_NAME "${NAME}.elf")
    set_directory_properties(PROPERTIES ADDITIONAL_MAKE_CLEAN_FILES "${NAME}.bin")

    add_custom_command(OUTPUT ${NAME}.bin
                      COMMAND ${ARM_STRIP} ${NAME}.elf
                      COMMAND ${CMAKE_OBJCOPY} -Obinary ${NAME}.elf ${NAME}.bin
                      COMMAND ${ARM_SIZE} ${NAME}.elf
                      DEPENDS ${NAME})
    add_custom_target(${NAME}-final ALL DEPENDS ${NAME}.bin)

    add_custom_target(${NAME}-size COMMAND ${ARM_SIZE} ${NAME}.elf)
    add_custom_target(${NAME}-probe COMMAND ${ST_INFO} --probe)
    add_custom_target(${NAME}-upload COMMAND ${ST_FLASH} write ${NAME}.bin 0x08000000)

endfunction(add_executable_stm32fx)
