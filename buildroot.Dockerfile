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

# we have to stick with this buildroot version, as OnionUI uses the same
ARG BUILDROOT_VERSION=buildroot-2019.11.3
RUN wget https://buildroot.org/downloads/$BUILDROOT_VERSION.tar.gz \
    && tar -xf $BUILDROOT_VERSION.tar.gz \
    && rm -f $BUILDROOT_VERSION.tar.gz \
    && mv $BUILDROOT_VERSION buildroot

ENV FORCE_UNSAFE_CONFIGURE=1
RUN cd buildroot \
    && patch -p1 < ../buildroot-scripts/libpng12.patch \
    && patch -p1 < ../buildroot-scripts/m4.patch \
    && patch -p1 < ../buildroot-scripts/fakeroot.patch \
    && cp ../buildroot-scripts/miyoo.config .config \
    && make sdk -j8

RUN mv buildroot/output/host/opt/ext-toolchain /opt/miyoo-toolchain
WORKDIR /opt/miyoo-toolchain

RUN ln -s . ./usr && ln -s libc ./arm-linux-gnueabihf/sysroot
RUN rsync -a --ignore-existing /root/buildroot/output/host/arm-buildroot-linux-gnueabihf/sysroot/* ./arm-linux-gnueabihf/sysroot
RUN rsync -a --ignore-existing /root/buildroot-scripts/my354/* ./arm-linux-gnueabihf/sysroot/usr

RUN rm -rf /root/buildroot
