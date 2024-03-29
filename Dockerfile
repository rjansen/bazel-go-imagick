FROM golang:1.16-buster

# Ignore APT warnings about not having a TTY
ENV DEBIAN_FRONTEND noninteractive

# install build essentials
RUN apt update && apt install -y wget build-essential pkg-config --no-install-recommends

# Install ImageMagick deps
RUN apt -q -y install \
        libxml2-dev \
        libbz2-dev \
        libxext-dev \
        libopenexr-dev \
        libjpeg-dev \
        libpng-dev \ 
        libtiff-dev \
        libgif-dev \
        libx11-dev \
        libexpat1-dev \
        libfftw3-dev \
        libfreetype6-dev \
        --no-install-recommends

ENV IMAGEMAGICK_VERSION=6.9.10-11

RUN cd && \
	wget https://github.com/ImageMagick/ImageMagick6/archive/${IMAGEMAGICK_VERSION}.tar.gz && \
	tar xvzf ${IMAGEMAGICK_VERSION}.tar.gz && \
	cd ImageMagick* && \
	./configure \
        --enable-static \
	    --without-magick-plus-plus \
	    --without-perl \
	    --disable-openmp \
	    --with-gvc=no \
	    --disable-docs && \
	make -j$(nproc) && make install && ldconfig /usr/local/lib

WORKDIR /app
CMD ["sh", "-c", "tail -f /dev/null"]
