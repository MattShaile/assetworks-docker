FROM debian:latest

RUN useradd -m bamboo -p bamboo && usermod -a -G bamboo bamboo

COPY TexturePacker-4.8.3-ubuntu64.deb /tmp/TexturePacker.deb
COPY ImageMagick.tar.gz /tmp/ImageMagick.tar.gz

RUN apt-get update \
	&& apt-get -qq update \
	&& apt-get install -y libssl1.1 \
	&& apt install -y libglu1-mesa libglib2.0-0 \
	&& apt-get install build-essential -y \
	&& tar xvzf /tmp/ImageMagick.tar.gz \
	&& cd ImageMagick-6.9.10-61/ \
	&& ./configure --with-modules --enable-shared --with-perl \
	&& make \
	&& make install \
	&& ldconfig /usr/local/lib \
	&& make check \
	&& cd ../ \
	&& rm -rf /var/cache/apk/* \
	&& dpkg -i /tmp/TexturePacker.deb \
	&& rm -rf /tmp/TexturePacker.deb \
	&& echo 'agree' | TexturePacker --license-info \
	&& apt-get update && apt-get install -my wget gnupg \
	&& apt-get install curl -y \
	&& curl -sL https://deb.nodesource.com/setup_10.x | bash - \
	&& apt-get install -y nodejs \
	&& update-alternatives --install /usr/bin/node node /usr/bin/nodejs 10 \
	&& apt-get install ffmpeg -y

WORKDIR /tmp

RUN export PATH=/usr/bin/convert:$PATH && identify -version && identify -list resource && ffmpeg -version && node -v && npm -version && TexturePacker --version

