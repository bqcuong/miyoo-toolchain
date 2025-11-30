#! /bin/sh

TOOLCHAIN_VERSION=v1.0
TOOLCHAIN_TAR="mini_toolchain-$TOOLCHAIN_VERSION.tar.gz"

cd /opt
wget "https://github.com/steward-fu/website/releases/download/miyoo-mini/$TOOLCHAIN_TAR"

tar xf "./$TOOLCHAIN_TAR"
rm -rf "./$TOOLCHAIN_TAR"
