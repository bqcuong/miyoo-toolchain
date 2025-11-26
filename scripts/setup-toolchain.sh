#! /bin/sh

TOOLCHAIN_VERSION=v0.0.1

TOOLCHAIN_ARCH=`uname -m`
if [ "$TOOLCHAIN_ARCH" = "aarch64" ]; then
    TOOLCHAIN_TAR="miyoo-toolchain-buildroot-aarch64.tar.xz"
else
    TOOLCHAIN_TAR="miyoo-toolchain-buildroot.tar.xz"
fi

cd /opt
wget "https://github.com/bqcuong/miyoo-toolchain/releases/download/$TOOLCHAIN_VERSION/$TOOLCHAIN_TAR"

echo "extracting remote toolchain $TOOLCHAIN_VERSION ($TOOLCHAIN_ARCH)"
tar xf "./$TOOLCHAIN_TAR"

rm -rf "./$TOOLCHAIN_TAR"
