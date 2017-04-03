## stm32 unicore-mx cmake template

### Introduction
This template is for developers who want to develop stm32 based firmware and use unicore-mx (https://github.com/insane-adding-machines/unicore-mx) which is a fork of libopencm3.
I have been using this template for my stm32f1 based projects. It suits my working style (make/vim). It might be useful for others.


### minimal setup

#### Arch linux
- pacman -S arm-none-eabi-gcc arm-none-eabi-newlib

#### Ubuntu
- sudo apt-get install arm-none-eabi-gcc arm-none-eabi-newlib

#### Build

    $ git clone https://github.com/amitesh-singh/stm32-unicoremx-project  

    $ cmake .  

    $ make  

    To upload the code to stm32f103
    $ make blink-upload   
    where blink is the project name.


#### how to use
- libraries can be added in lib/**your_new_library** and then add the entry
of your new library in *lib/CMakeLists.txt*
- projects can be added in src/**your_project_code** and then add the entry
of your new project in *src/CMakeLists.txt*
- **unicore-mx** library path can be mentioned in *config.cmake*. 
