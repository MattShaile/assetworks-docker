FROM debian:latest

COPY TexturePacker-4.5.0-ubuntu64.deb /tmp/TexturePacker.deb

RUN apt-get update \
		&& apt-get -qq update \
		&& apt install -y libglu1-mesa libglib2.0-0 \
        && rm -rf /var/cache/apk/* \
        && dpkg -i /tmp/TexturePacker.deb \
        && rm -rf /tmp/TexturePacker.deb \
        && echo 'agree' | TexturePacker --license-info \
		&& apt-get update && apt-get install -my wget gnupg \
		&& apt-get install curl -y \
		&& curl -sL https://deb.nodesource.com/setup_6.x | bash - \
		&& apt-get install -y nodejs \
		&& update-alternatives --install /usr/bin/node node /usr/bin/nodejs 10 \
		&& apt-get install imagemagick -y \
		&& apt-get install ffmpeg -y

WORKDIR /tmp

RUN identify -version && ffmpeg -version && node -v && npm -version && TexturePacker --version