DOCKER_CMD = $(if $(shell command -v docker 2>/dev/null), docker, podman)

NS = blang
REPO = latex
IMAGE = $(NS)/$(REPO)

.PHONY: build build_ubuntu build_ubuntu_xenial build_ubuntu_focal build_basic build_full

build: build_ubuntu build_basic build_full

build_ubuntu: build_ubuntu_xenial build_ubuntu_focal
	@$(DOCKER_CMD) tag $(IMAGE):ubuntu-focal $(IMAGE):ubuntu

build_ubuntu_noble: Dockerfile.ubuntu
	@$(DOCKER_CMD) build --pull -f Dockerfile.ubuntu --build-arg BASE_TAG=noble -t $(IMAGE):ubuntu-noble .

build_ubuntu_xenial: Dockerfile.ubuntu
	@$(DOCKER_CMD) build --pull -f Dockerfile.ubuntu --build-arg BASE_TAG=xenial -t $(IMAGE):ubuntu-xenial .
	
build_ubuntu_focal: Dockerfile.ubuntu
	@$(DOCKER_CMD) build --pull -f Dockerfile.ubuntu --build-arg BASE_TAG=focal -t $(IMAGE):ubuntu-focal .

build_ubuntu_impish: Dockerfile.ubuntu
	@$(DOCKER_CMD) build --pull -f Dockerfile.ubuntu --build-arg BASE_TAG=impish -t $(IMAGE):ubuntu-impish .

build_basic: Dockerfile.basic
	@$(DOCKER_CMD) build --pull -f Dockerfile.basic -t $(IMAGE):ctanbasic .

build_full: build_basic Dockerfile.full
	@$(DOCKER_CMD) build -f Dockerfile.full --build-arg BASE_IMAGE=$(IMAGE):ctanbasic  -t $(IMAGE):ctanfull .

default: build
