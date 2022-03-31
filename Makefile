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

CGO_CFLAGS_ALLOW='-fopenmp'
CGO_CFLAGS="`pkg-config --cflags MagickWand MagickCore`"
CGO_LDFLAGS="\
-lstdc++ -lXext -lX11 \
-Wl,-Bstatic \
    `pkg-config --libs MagickWand MagickCore` \
    -lgomp -lIlmImf -lImath -lHalf -lIlmThread -lIex -llcms -lfreetype -lxml2 -lexpat -lfftw3 -lbz2 -lm -lz \
    -lwebp -ljpeg -lpng16 -ltiff -lgif \
-Wl,-Bdynamic"

# CGO_LDFLAGS="\
# -lstdc++ -lXext -lX11 \
# -Wl,-Bstatic \
#     `pkg-config --libs MagickWand MagickCore` \
#     -lgomp -lIlmImf -lImath -lHalf -lIlmThread -lIex -llcms -lfreetype -lxml2 -lexpat -lfftw3 -lbz2 -lm -lz \
#     -lwebp -ljpeg -lpng16 -ltiff -lgif \
# -Wl,-Bdynamic"

build-static:
	CGO_CFLAGS_ALLOW=$(CGO_CFLAGS_ALLOW) CGO_CFLAGS=$(CGO_CFLAGS) CGO_LDFLAGS=$(CGO_LDFLAGS) go build -tags no_pkgconfig -ldflags="-extldflags=-static" -o $(NAME) 
