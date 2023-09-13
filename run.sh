#!/bin/sh

IMAGE=`cat VERSION`

docker buildx build \
    --load \
    --build-arg BF_IMAGE=backup \
    --build-arg BF_VERSION=${IMAGE} \
    -f Dockerfile \
    -t backup-dev \
    .

docker run -it \
    -e BF_DEBUG=1 \
    -e BACKUP_PASSPHRASE=fred \
    -e BACKUP_RCLONE_STORAGE=fred \
    -e BACKUP_RCLONE_PATH=/Backup/Test \
    -v $PWD/Dockerfile:/b/Dockerfile \
    -v $PWD/config:/config \
    -v $PWD/restore:/restore \
    backup-dev sh
