-include .env.mk

.env.mk: .env
		sed 's/"//g ; s/=/:=/' < $< > $@

.PHONY: all build push
.DEFAULT_GOAL := build

all: build push

up:
	sed -i 's/^TINC_HOSTNAME=.*$//TINC_HOSTNAME=$(shell hostname -s)/' .env
	sudo docker-compose up -d
down:
	sudo docker-compose down
restart: down up

develop:
	sed -i 's/^TINC_HOSTNAME=.*$//TINC_HOSTNAME=$(shell hostname -s)/' .env
	sudo docker-compose up --build
build:
	sudo docker-compose build
push:
	sudo docker push azmo/tinc:latest

cli:
	sudo docker-compose exec tinc tinc --pidfile /run/tinc.${TINC_NETWORK}.pid
edges:
	sudo docker-compose exec tinc tinc --pidfile /run/tinc.${TINC_NETWORK}.pid dump edges
generate-keys:
	sudo docker-compose run --rm -v $(shell pwd):/tmp/keys --entrypoint tinc tinc -n ${TINC_NETWORK} generate-ed25519-keys

