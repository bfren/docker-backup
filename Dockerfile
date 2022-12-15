FROM bfren/alpine-s6:alpine3.17-4.4.2

LABEL org.opencontainers.image.source="https://github.com/bfren/docker-backup"

ARG BF_IMAGE
ARG BF_VERSION

ENV \
    # cron-compatible schedule (see e.g. https://crontab.guru) - default every day at midnight
    BACKUP_CRON="0 0 * * *" \
    # used to encrypt backup data - if not set, backup will not be run
    BACKUP_DUPLICITY_PASSPHRASE= \
    # how often to run a full backup (default: one month - see https://duplicity.gitlab.io/stable/duplicity.1.html#time-formats)
    BACKUP_DUPLICITY_FULL_EVERY=1M \
    # the number of full backups to keep
    DUPLICITY_KEEP_FULL=3 \
    # the name of the (configured) rclone storage provider
    BACKUP_RCLONE_STORAGE= \
    # path within storage provider for putting backups - should start with a slash
    BACKUP_RCLONE_PATH=/

COPY ./overlay /

RUN bf-install

VOLUME [ "/config", "/restore" ]
