FROM ubuntu:24.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update && apt-get -y install --no-install-recommends \
        build-essential \
        cmake autoconf autogen automake \
        wget ca-certificates \
        git vim \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /root

#COPY scripts .
#RUN ./setup-toolchain.sh && rm ./setup-toolchain.sh

#ENV CROSS=/opt/mini/usr/bin/arm-linux-gnueabihf-
#ENV PATH=/opt/mini/bin:$PATH

CMD ["/bin/bash"]
