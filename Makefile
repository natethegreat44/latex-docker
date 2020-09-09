NS = blang
REPO = latex
IMAGE = $(NS)/$(REPO)

.PHONY: build build_ubuntu build_ubuntu_xenial build_ubuntu_focal build_basic build_full

build: build_ubuntu build_basic build_full

build_ubuntu: build_ubuntu_xenial build_ubuntu_focal
	@docker tag $(IMAGE):ubuntu-focal $(IMAGE):ubuntu

build_ubuntu_xenial: Dockerfile.ubuntu
	@docker build --pull -f Dockerfile.ubuntu --build-arg BASE_TAG=xenial -t $(IMAGE):ubuntu-xenial .
	
build_ubuntu_focal: Dockerfile.ubuntu
	@docker build --pull -f Dockerfile.ubuntu --build-arg BASE_TAG=focal -t $(IMAGE):ubuntu-focal .

build_basic: Dockerfile.basic
	@docker build --pull -f Dockerfile.basic -t $(IMAGE):ctanbasic .

build_full: build_basic Dockerfile.full
	@docker build -f Dockerfile.full --build-arg BASE_IMAGE=$(IMAGE):ctanbasic  -t $(IMAGE):ctanfull .

default: build
