#!/bin/bash

# Setup SDL2 (custom build for Miyoo Mini(+), with CPU-based OpenGL ES implementation)

cd /root/workspace/

git clone https://github.com/steward-fu/sdl2.git
cd sdl2

make cfg
make gpu
make sdl2

mkdir ../sdl2_build
cp swiftshader/build/lib* sdl2/build/.libs/libSDL2-2.0.so.0* ../sdl2_build

# also copy the dependency libs for SDL2
#mkdir ../sdl2_build/dependencies
#cp examples/libSDL2_* examples/libjson-c.so.5 examples/libpng16.so.16 ../sdl2_build/dependencies/
