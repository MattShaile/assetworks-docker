# assetworks-docker

https://hub.docker.com/r/epicindustries/assetworks/


## Description

Docker container running latest Debian with node, npm, imagemagick, ffmpeg and texture packer installed

## Activate TexturePacker License

Run `TexturePacker --activate-license KEY` with your license key to activate texture packer

## Bamboo CI (optional)

For convenience a user:group of bamboo:bamboo is available so files created can be be owned by bamboo:bamboo, rather than root:root. Run docker image with `--user="bamboo:bamboo"`

## Credit

Thanks to https://github.com/AgreGAD for assistance