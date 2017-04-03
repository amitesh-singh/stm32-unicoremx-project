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

# Always include this file before stm32-toolchain.cmake
#

set(MCU STM32F1)

#declare the UNICORE-MX library path
set(LIBUCMX_DIR "/home/ami/repos/unicore-mx")
