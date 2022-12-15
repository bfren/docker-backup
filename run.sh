#!/bin/sh

IMAGE=`cat VERSION`

docker buildx build \
    --build-arg BF_IMAGE=backup \
    --build-arg BF_VERSION=${IMAGE} \
    -f Dockerfile \
    -t backup-dev \
    . \
    && \
    docker run -it -e BACKUP_DUPLICITY_PASSPHRASE=fred -e BACKUP_RCLONE_STORAGE=fred backup-dev sh
