FROM ubuntu:20.04

# Install dependencies
RUN apt-get update && apt-get -y install python3-pip

# Install awscli
RUN pip3 install awscli

COPY TexturePacker-7.0.3.deb /tmp/TexturePacker.deb

# Install remaining dependencies and TexturePacker, cleanup
RUN apt-get -y install libegl1-mesa libgl1-mesa-glx \
                       libfontconfig libx11-6 libxkbcommon-x11-0 \
                       /tmp/TexturePacker.deb \
&& rm -rf /var/lib/apt/lists/*

RUN echo agree | TexturePacker --version

# Install required packages
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
&& apt-get -y install curl \
&& curl -sL https://deb.nodesource.com/setup_10.x | bash - \
&& apt-get -y install nodejs git ffmpeg zip

# Install Git LFS
RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash \
&& apt-get -y install git-lfs

# Install dependencies for ImageMagick
RUN apt-get install -y build-essential libpng-dev libjpeg-dev libtiff-dev libx11-dev libxml2-dev

# Clone and build ImageMagick from source
WORKDIR /tmp
RUN git clone https://github.com/ImageMagick/ImageMagick.git ImageMagick-7.1.1
WORKDIR /tmp/ImageMagick-7.1.1
RUN ./configure
RUN make
RUN make install
RUN ldconfig /usr/local/lib

RUN git --version && identify -version && cat /usr/local/etc/ImageMagick-7/policy.xml && ffmpeg -version && node -v && npm -version && TexturePacker --version

WORKDIR /tmp