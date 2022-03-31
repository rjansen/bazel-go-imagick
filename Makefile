NAME := bazel_go_imagick
IMAGE_NAME ?= $(NAME)
CONTAINER_NAME ?= $(NAME)

docker-build:
	docker build -t $(IMAGE_NAME) .

docker-run: docker-build
	docker run --rm -d --name $(CONTAINER_NAME) -v $(shell pwd):/app $(IMAGE_NAME)

docker-bash: docker-kill docker-run
	docker exec -it $(CONTAINER_NAME) bash

docker-kill: 
	-docker kill $(CONTAINER_NAME)

build:
	go build -o $(NAME) main.go

build-static:
	go build -ldflags="-extldflags=-static" -o $(NAME) 
