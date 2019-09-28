SHELL := /bin/bash
curdir = $(dir $(realpath $(firstword $(MAKEFILE_LIST))))

#bakes everything into the image
build:
	docker build -t christophstrasen/miwy_craft .
.PHONY: build

start: start_craft_dev start_uv4l
.PHONY: start

build_x86:
	docker build -f Dockerfile_x86 -t christophstrasen/miwy_craft_x86 .
.PHONY: build_x86

start_craft_dev:
	docker run -p 8080:8080 -i -t --privileged -v $(curdir)research/:/research/ christophstrasen/miwy_craft
.PHONY: start_craft_dev

start_craft_dev_x86:
	docker run -p 8080:8080 -i -t --privileged -v $(curdir)research/:/research/ christophstrasen/miwy_craft_x86
.PHONY: start_craft_dev_x86

start_uv4l:
	$(curdir)uv4l/uv4l_start.sh
.PHONY: start_uv4l

stop_uv4l:
	killall uv4l
.PHONY: stop_uv4l
