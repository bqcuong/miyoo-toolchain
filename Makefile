###############################################################################
TOOLCHAIN_IMAGE=bqcuongas/miyoo-toolchain
BUILDROOT_IMAGE=bqcuongas/miyoo-buildroot
HOST_WORKSPACE=$(shell pwd)/workspace
GUEST_WORKSPACE=/root/workspace
###############################################################################

# targets for buildroot
buildroot-docker: buildroot.Dockerfile
	docker build -t $(BUILDROOT_IMAGE) -f buildroot.Dockerfile .

# targets for toolchain
docker: toolchain.Dockerfile
	docker build -t $(TOOLCHAIN_IMAGE) -f toolchain.Dockerfile .

shell: docker
	docker run -it -v $(HOST_WORKSPACE):$(GUEST_WORKSPACE) $(TOOLCHAIN_IMAGE) /bin/bash

setup-sdl2: docker
	cp scripts/setup-sdl2.sh $(HOST_WORKSPACE)
	docker run -it --rm -v $(HOST_WORKSPACE):$(GUEST_WORKSPACE) $(TOOLCHAIN_IMAGE) $(GUEST_WORKSPACE)/setup-sdl2.sh

clean:
	docker rmi $(TOOLCHAIN_IMAGE)
