SHELL := /bin/bash

.PHONY: all
all: bin init

.PHONY: docker
docker: Dockerfile
	docker build -t consulenvoy .

.PHONY: up
up:
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
