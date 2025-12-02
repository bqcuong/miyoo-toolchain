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

shell:
	docker run --rm -it -v $(HOST_WORKSPACE):$(GUEST_WORKSPACE) $(TOOLCHAIN_IMAGE) /bin/bash

clean:
	docker rmi $(TOOLCHAIN_IMAGE)
