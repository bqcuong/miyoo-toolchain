###############################################################################
TOOLCHAIN_IMAGE=bqcuongas/miyoo-toolchain
HOST_WORKSPACE=$(shell pwd)/workspace
GUEST_WORKSPACE=/root/workspace
###############################################################################

docker: Dockerfile
	docker build -t $(TOOLCHAIN_IMAGE) .

shell: docker
	docker run -it --rm -v $(HOST_WORKSPACE):$(GUEST_WORKSPACE) $(TOOLCHAIN_IMAGE) /bin/bash

setup-sdl2: docker
	cp scripts/setup-sdl2.sh $(HOST_WORKSPACE)
	docker run -it --rm -v $(HOST_WORKSPACE):$(GUEST_WORKSPACE) $(TOOLCHAIN_IMAGE) $(GUEST_WORKSPACE)/setup-sdl2.sh

clean:
	docker rmi $(TOOLCHAIN_IMAGE)
