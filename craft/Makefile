SHELL := /bin/bash
curdir = $(dir $(realpath $(firstword $(MAKEFILE_LIST))))

#bakes everything into the image
build:
	docker build -t christophstrasen/miwycraft .
.PHONY: build

rundev:
	docker run -p 8080:8080 -i -t --privileged -v $(curdir)research/:/research/ christophstrasen/miwycraft
.PHONY: rundev

