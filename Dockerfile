FROM debian:latest

RUN useradd -m bamboo -p bamboo && usermod -a -G bamboo bamboo

COPY TexturePacker-4.8.3-ubuntu64.deb /tmp/TexturePacker.deb

RUN apt-get update \
		&& apt-get -qq update \
        && apt-get install -y libssl1.1 \
		&& apt install -y libglu1-mesa libglib2.0-0 \
        && rm -rf /var/cache/apk/* \
        && dpkg -i /tmp/TexturePacker.deb \
        && rm -rf /tmp/TexturePacker.deb \
        && echo 'agree' | TexturePacker --license-info \
		&& apt-get update && apt-get install -my wget gnupg \
		&& apt-get install curl -y \
		&& curl -sL https://deb.nodesource.com/setup_10.x | bash - \
		&& apt-get install -y nodejs \
		&& update-alternatives --install /usr/bin/node node /usr/bin/nodejs 10 \
		&& apt-get install imagemagick -y \
		&& apt-get install ffmpeg -y \
		&& sed -i 's/256MiB/8GiB/g' /etc/ImageMagick-6/policy.xml

WORKDIR /tmp

RUN identify -version && cat /etc/ImageMagick-6/policy.xml && ffmpeg -version && node -v && npm -version && TexturePacker --version
