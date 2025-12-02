FROM bqcuongas/miyoo-buildroot AS buildroot
FROM ubuntu:24.04
ENV DEBIAN_FRONTEND=noninteractive

ENV TZ=Europe/Berlin

RUN apt-get -y update && apt-get -y install --no-install-recommends \
        build-essential \
        cmake autoconf autogen automake rsync \
        wget ca-certificates \
        git vim \
    && rm -rf /var/lib/apt/lists/*

COPY --from=buildroot /opt/miyoo-toolchain /opt/miyoo-toolchain

WORKDIR /root
COPY scripts ./scripts
RUN ./scripts/setup-sdl2.sh

ENV CROSS=/opt/miyoo-toolchain/usr/bin/arm-linux-gnueabihf-
ENV PATH=/opt/miyoo-toolchain/bin:$PATH

CMD ["/bin/bash"]
