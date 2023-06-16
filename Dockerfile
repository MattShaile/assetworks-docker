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
&& apt-get -y install nodejs git imagemagick ffmpeg

# Install Git LFS
RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash \
&& apt-get -y install git-lfs

RUN sed -i 's/256MiB/8GiB/g' /etc/ImageMagick-6/policy.xml

RUN git --version && identify -version && cat /etc/ImageMagick-6/policy.xml && ffmpeg -version && node -v && npm -version && TexturePacker --version

WORKDIR /tmp