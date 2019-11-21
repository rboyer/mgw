SHELL := /bin/bash

.PHONY: all
all: bin init

.PHONY: docker
docker: Dockerfile
	docker build -t consulenvoy .

.PHONY: tls
tls: cache/tls.done
cache/tls.done:
	# TODO(rb): take a node name arg and do this for the user
	@mkdir -p cache
	@cd cache ; consul tls ca create
	@cd cache ; consul tls cert create -dc=dc1 -server -additional-dnsname='dc1-server1-node.server.dc1.consul'
	@cd cache ; consul tls cert create -dc=dc2 -server -additional-dnsname='dc2-server1-node.server.dc2.consul'
	@cd cache ; consul tls cert create -dc=dc1 -client
	@cd cache ; consul tls cert create -dc=dc2 -client
	@touch cache/tls.done

# wangossip-stream.dc1-server1-node.server.dc1.consul

.PHONY: up-pri
up-pri: tls docker
	docker-compose up -d dc1-server1-node dc1-server1 dc1-client1-node dc1-client1 dc1-mesh-gateway1

.PHONY: up-sec
up-sec: tls docker
	docker-compose up -d dc2-server1-node dc2-server1 dc2-client1-node dc2-client1 dc2-mesh-gateway1

.PHONY: up
up: tls docker
	docker-compose up -d

.PHONY: down
down:
	docker-compose down -v --remove-orphans

.PHONY: restart
restart:
	docker-compose down
	docker-compose up -d

.PHONY: members
members:
	@./consul.sh dc1 members

.PHONY: services
services:
	@./consul.sh dc1 catalog services
