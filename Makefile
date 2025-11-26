.PHONY: shell
.PHONY: clean

###############################################################################
TOOLCHAIN_IMAGE=bqcuongas/miyoo-toolchain
HOST_WORKSPACE=$(shell pwd)/workspace
GUEST_WORKSPACE=/root/workspace
###############################################################################

.build: Dockerfile
	mkdir -p ./workspace
	docker build -t $(TOOLCHAIN_IMAGE) .
	touch .build

shell: .build
	docker run -it --rm -v $(HOST_WORKSPACE):$(GUEST_WORKSPACE) $(TOOLCHAIN_IMAGE) /bin/bash

clean:
	docker rmi $(TOOLCHAIN_IMAGE)
	rm -f .build
