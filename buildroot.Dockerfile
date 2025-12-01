FROM ubuntu:24.04
ENV DEBIAN_FRONTEND=noninteractive

ENV TZ=Europe/Berlin

RUN apt-get -y update && apt-get -y install --no-install-recommends \
        build-essential \
        cmake autoconf autogen automake \
        libncurses5-dev rsync cpio file bc unzip \
        wget ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /root
COPY scripts/buildroot/ ./buildroot-scripts

ARG BUILDROOT_VERSION=buildroot-2025.08.2
RUN wget https://buildroot.org/downloads/$BUILDROOT_VERSION.tar.gz \
    && tar -xf $BUILDROOT_VERSION.tar.gz \
    && rm -f $BUILDROOT_VERSION.tar.gz \
    && mv $BUILDROOT_VERSION buildroot

RUN cd buildroot && patch -p1 < ../buildroot-scripts/libpng12.patch && cp ../buildroot-scripts/miyoo.config .config \
    && make sdk -j8

RUN mv buildroot/output/host/opt/ext-toolchain /opt/miyoo-toolchain
WORKDIR /opt/miyoo-toolchain

RUN ln -s . ./usr && ln -s libc ./arm-none-linux-gnueabihf/sysroot
RUN rsync -a --ignore-existing /root/buildroot/output/host/arm-buildroot-linux-gnueabihf/sysroot/* ./arm-none-linux-gnueabihf/sysroot
RUN rsync -a --ignore-existing /root/buildroot-scripts/my354/* ./arm-none-linux-gnueabihf/sysroot/usr

RUN rm -rf /root/buildroot
