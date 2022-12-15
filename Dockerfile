FROM bfren/alpine-s6:alpine3.17-4.4.2

LABEL org.opencontainers.image.source="https://github.com/bfren/docker-backup"

ARG BF_IMAGE
ARG BF_VERSION

ENV \
    # cron-compatible schedule (see e.g. https://crontab.guru) - default every day at midnight
    BACKUP_CRON="0 0 * * *" \
    # the name of the (configured) rclone storage provider
    BACKUP_RCLONE_STORAGE= \
    # path within storage provider for putting backups - should start with a slash
    BACKUP_RCLONE_PATH=/ \
    # used to encrypt backup data - if not set, backup will not be run
    BACKUP_DUPLICITY_PASSPHRASE=

COPY ./overlay /

RUN bf-install

VOLUME [ "/config", "/source" ]
