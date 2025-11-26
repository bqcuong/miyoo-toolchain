FROM ubuntu:24.04
ENV DEBIAN_FRONTEND=noninteractive

ENV TZ=America/New_York
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get -y update && apt-get -y install --no-install-recommends \
        build-essential \
        autoconf cmake \
        wget ca-certificates \
        git vim \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /root

COPY scripts .
RUN ./setup-toolchain.sh && rm ./setup-toolchain.sh

ENV UNION_PLATFORM=miyoo
ENV CROSS_COMPILE=/opt/miyoo-toolchain/usr/bin/arm-linux-gnueabihf-
ENV PREFIX=/opt/miyoo-toolchain/usr/arm-linux-gnueabihf/sysroot/usr
ENV PATH=/opt/miyoo-toolchain/usr/bin:/opt/miyoo-toolchain/usr/arm-linux-gnueabihf/sysroot/bin:$PATH

CMD ["/bin/bash"]
