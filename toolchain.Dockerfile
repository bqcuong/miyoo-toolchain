FROM bqcuongas/miyoo-buildroot as buildroot
FROM ubuntu:24.04
ENV DEBIAN_FRONTEND=noninteractive

ENV TZ=Europe/Berlin

RUN apt-get -y update && apt-get -y install --no-install-recommends \
        build-essential \
        cmake autoconf autogen automake \
        wget ca-certificates \
        git vim \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /root

COPY scripts ./scripts
#RUN ./setup-toolchain.sh && rm ./setup-toolchain.sh

COPY --from=buildroot /opt/miyoo-toolchain /opt/miyoo-toolchain

ENV CROSS=/opt/miyoo-toolchain/usr/bin/arm-linux-gnueabihf-
ENV PATH=/opt/miyoo-toolchain/bin:$PATH

CMD ["/bin/bash"]
