docker-build:
	docker build -t bazel_go_imagick .

docker-run:
	docker run --rm -d --name bazel_go_imagick v $(pwd):/app bazel_go_imagick

docker-bash:
	docker exec -it bazel_go_imagick bash

build:
	go build -o bazel_go_imagick main.go

build-static:
	go build -ldflags="-extldflags=-static" -o bazel_go_imagick 
