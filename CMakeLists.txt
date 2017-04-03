cmake_minimum_required(VERSION 3.5)

include(config.cmake)
set(CMAKE_TOOLCHAIN_FILE cmake/stm32-toolchain.cmake)

project(stm32f103c8t6 C CXX ASM)

#Add your projects
add_subdirectory(src)

#Add your libraries 
add_subdirectory(lib)
