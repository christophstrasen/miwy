SHELL := /bin/bash
curdir = $(dir $(realpath $(firstword $(MAKEFILE_LIST))))

run_nats: 
	docker run -v $(curdir)/secrets:/secrets -p 4222:4222 -ti nats:latest --tls --tlscert=/secrets/nats_cert.pem --tlskey=/secrets/nats_key.pem
.PHONY: run_nats
