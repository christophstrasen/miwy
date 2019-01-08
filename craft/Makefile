SHELL := /bin/bash
curdir = $(dir $(realpath $(firstword $(MAKEFILE_LIST))))

#bakes everything into the image
build:
	docker build -t christophstrasen/miwycraft .
.PHONY: build

rundev:
	docker run -i -t --privileged christophstrasen/miwycraft
.PHONY: run-dev

