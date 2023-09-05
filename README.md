# assetworks-docker

https://hub.docker.com/r/epicindustries/assetworks/


## Description

Docker container running latest Debian with git, node (10), npm (6), zip, imagemagick (7), ffmpeg, awscli, and texture packer installed

## Activate TexturePacker License

Run `TexturePacker --activate-license KEY` with your license key to activate texture packer (every time you use it) or set TP_FLOATING_LICENSE environment variable

## Building / Publishing

`docker login`

`docker build --tag=epicindustries/assetworks .`

`docker push epicindustries/assetworks`

## Credit

Thanks to https://github.com/AgreGAD for assistance