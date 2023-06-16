# assetworks-docker

https://hub.docker.com/r/epicindustries/assetworks/


## Description

Docker container running latest Debian with git, node (10), npm (6), imagemagick, ffmpeg and texture packer installed

## Activate TexturePacker License

Run `TexturePacker --activate-license KEY` with your license key to activate texture packer (every time you use it) or set TP_FLOATING_LICENSE environment variable

## Bamboo CI (optional)

For convenience a user:group of bamboo:bamboo is available so files created can be be owned by bamboo:bamboo, rather than root:root. Run docker image with `--user="bamboo:bamboo"`

## Building / Publishing

`docker login`

`docker build --tag=epicindustries/assetworks .`

`docker push epicindustries/assetworks`

## Credit

Thanks to https://github.com/AgreGAD for assistance