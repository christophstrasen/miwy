SHELL := /bin/bash
curdir = $(dir $(realpath $(firstword $(MAKEFILE_LIST))))

#bakes everything into the image
build:
	docker build -t christophstrasen/miwycraft .
.PHONY: build

build_x86:
	docker build -f Dockerfile_x86 -t christophstrasen/miwycraft_x86 .
.PHONY: build_x86

rundev:
	docker run -p 8080:8080 -i -t --privileged -v $(curdir)research/:/research/ christophstrasen/miwycraft
.PHONY: rundev

rundev_x86:
	docker run -p 8080:8080 -i -t --privileged -v $(curdir)research/:/research/ christophstrasen/miwycraft_x86
.PHONY: rundev_x86
