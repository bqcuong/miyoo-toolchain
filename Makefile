###############################################################################
TOOLCHAIN_IMAGE=bqcuongas/miyoo-toolchain
HOST_WORKSPACE=$(shell pwd)/workspace
GUEST_WORKSPACE=/root/workspace
###############################################################################

docker: Dockerfile
	docker build -t $(TOOLCHAIN_IMAGE) .

shell: docker
	docker run -it --rm -v $(HOST_WORKSPACE):$(GUEST_WORKSPACE) $(TOOLCHAIN_IMAGE) /bin/bash

clean:
	docker rmi $(TOOLCHAIN_IMAGE)
