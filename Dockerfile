FROM debian:10

RUN useradd -m bamboo -p bamboo && usermod -a -G bamboo bamboo

COPY TexturePacker-7.0.3.deb /tmp/TexturePacker.deb

RUN apt-get update \
		&& apt-get -qq update \
		&&  apt-get -y install libegl1-mesa libgl1-mesa-glx \
                       libfontconfig libx11-6 libxkbcommon-x11-0 \
                       /tmp/TexturePacker.deb \
		&& apt-get update && apt-get install -my wget gnupg \
		&& apt-get install curl -y \
		&& curl -sL https://deb.nodesource.com/setup_10.x | bash - \
		&& apt-get install -y nodejs \
		&& apt-get install -y git \
		&& update-alternatives --install /usr/bin/node node /usr/bin/nodejs 10 \
		&& apt-get install imagemagick -y \
		&& apt-get install ffmpeg -y \
		&& sed -i 's/256MiB/8GiB/g' /etc/ImageMagick-6/policy.xml

WORKDIR /tmp