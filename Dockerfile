FROM ubuntu:20.04

# Install dependencies including libltdl-dev
RUN apt-get update && apt-get -y install python3-pip build-essential libltdl-dev

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
&& curl -sL https://deb.nodesource.com/setup_22.x | bash - \
&& apt-get -y install nodejs git ffmpeg zip

# Copy ImageMagick 7 tarball
COPY ImageMagick.tar.gz /tmp/

# Install ImageMagick 7 from local tarball
RUN cd /tmp \
    && tar xvzf ImageMagick.tar.gz \
    && cd ImageMagick-7.1.1-38 \
    && ./configure --with-modules \
    && make \
    && make install \
    && ldconfig /usr/local/lib \
    && identify -version

# Install Git LFS
RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash \
&& apt-get -y install git-lfs

# Modify ImageMagick 7's memory policy
RUN sed -i 's/256MiB/8GiB/g' /usr/local/etc/ImageMagick-7/policy.xml

# Verify versions of installed tools
RUN git --version && identify -version && cat /usr/local/etc/ImageMagick-7/policy.xml && ffmpeg -version && node -v && npm -version && TexturePacker --version

WORKDIR /tmp
