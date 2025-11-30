FROM ubuntu:24.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update && apt-get -y install --no-install-recommends \
        build-essential \
        cmake autoconf autogen automake \
        libncurses5-dev rsync cpio file bc unzip \
        wget ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /root
COPY scripts/buildroot .

ARG BUILDROOT_VERSION=buildroot-2025.08.2
RUN wget https://buildroot.org/downloads/$BUILDROOT_VERSION.tar.gz \
    && tar -xf $BUILDROOT_VERSION.tar.gz \
    && rm -f $BUILDROOT_VERSION.tar.gz \
    && mv $BUILDROOT_VERSION buildroot

RUN cd buildroot && patch -p1 < ../libpng12.patch && cp ../miyoo.config .config \
    && make sdk -j8
