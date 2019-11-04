SHELL := /bin/bash
curdir = $(dir $(realpath $(firstword $(MAKEFILE_LIST))))

build_client_web:
	docker build -f client.Dockerfile -t christophstrasen/miwy_client .
.PHONY: build_client_web

run_client_web: 
	docker run -p 443:443 christophstrasen/miwy_client
.PHONY: run_client_web

#pull web directory from the host computer so you can change the contents and simply refresh your browser
run_client_web_dev:
	docker run -t -i -v $(curdir)/client/web/:/usr/share/nginx/web/ -p 443:443 christophstrasen/miwy_client	
.PHONY: run_client_web_dev

build_craft:
	docker build -f craft.Dockerfile -t christophstrasen/miwy_craft .
.PHONY: build_craft

build_craft_x86:
	docker build -f craft_x86.Dockerfile -t christophstrasen/miwy_craft_x86 .
	.PHONY: build_craft_x86

run_craft_dev:
	docker run -i -t -p 8081:8081 --privileged -v $(curdir)/craft/scripts/:/opt/miwy-craft/scripts/ christophstrasen/miwy_craft
.PHONY: run_craft_dev

run_craft_dev_x86:
	docker run -i -t --privileged -v $(curdir)/craft/scripts/:/opt/miwy-craft/scripts/ christophstrasen/miwy_craft_x86
.PHONY: run_craft_dev_x86

# uv4l runs native, NOT in docker
run_craft_uv4l:
	$(curdir)/craft/uv4l/uv4l_start.sh
.PHONY: run_craft_uv4l

stop_craft_uv4l:
	killall uv4l
.PHONY: stop_uv4l
