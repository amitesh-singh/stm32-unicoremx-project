add_executable_stm32fx(blink  main.c)
target_include_directories(blink PUBLIC
                           ${CMAKE_CURRENT_SOURCE_DIR}/../../lib/usart1
                          )
target_link_libraries(blink
                      -L${CMAKE_CURRENT_SOURCE_DIR}/../../lib/usart1 usart1
                     )
