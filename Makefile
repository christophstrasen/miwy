SHELL := /bin/bash
curdir = $(dir $(realpath $(firstword $(MAKEFILE_LIST))))

run_client: run_client_resgate run_client_web
.PHONY: run_client

run_craft: run_craft_main_dev run_craft_uv4l
.PHONY: run_craft

run_test:
	echo $(curdir)

run_client_resgate: cleanup_client_resgate
	-docker network create res
	-docker run -d --name nats -p 4222:4222 --net res nats
	docker run --name resgate -p 4443:8080 -v /home/christoph/repo/miwy/secrets:/secrets --net res resgateio/resgate --nats nats://nats:4222 --tlscert /secrets/cert.pem --tlskey /secrets/key.pem --tls
.PHONY: run_client_resgate

cleanup_client_resgate:
	-docker stop resgate
	-docker stop nats
	-docker rm nats
	-docker rm resgate
	-docker network rm res
.PHONY: cleanup_client_resgate

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

build_craft_main:
	docker build -f craft.Dockerfile -t christophstrasen/miwy_craft .
.PHONY: build_craft_main

build_craft_main_x86:
	docker build -f craft_x86.Dockerfile -t christophstrasen/miwy_craft_x86 .
	.PHONY: build_craft_main_x86

run_craft_main_dev:
	docker run -i -t -p 8081:8081 --privileged -v $(curdir)/craft/scripts/:/opt/miwy-craft/scripts/ christophstrasen/miwy_craft
.PHONY: run_craft_main_dev

run_craft_main_dev_x86:
	docker run -i -t --privileged -v $(curdir)/craft/scripts/:/opt/miwy-craft/scripts/ christophstrasen/miwy_craft_x86
.PHONY: run_craft_main_dev_x86

# uv4l runs native, NOT in docker
run_craft_uv4l:
	$(curdir)/craft/uv4l/uv4l_start.sh
.PHONY: run_craft_uv4l

stop_craft_uv4l:
	killall uv4l
.PHONY: stop_uv4l
