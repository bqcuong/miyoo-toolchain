#!/bin/bash

# Setup SDL2 (custom build for Miyoo Mini(+), with CPU-based OpenGL ES implementation)
rsync -a --ignore-existing /root/scripts/sdl2/* /opt/miyoo-toolchain/arm-linux-gnueabihf/sysroot/usr
