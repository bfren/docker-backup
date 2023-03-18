FROM bfren/alpine-s6:alpine3.17-4.4.12

LABEL org.opencontainers.image.source="https://github.com/bfren/docker-backup"

ARG BF_IMAGE
ARG BF_VERSION

ENV \
    # backup command to run on the cron schedule (default: dup-default) - technically you can put anything you want here
    BACKUP_COMMAND=dup-default \
    # cron-compatible schedule (see e.g. https://crontab.guru) - default every day at midnight
    BACKUP_CRON="0 0 * * *" \
    # used to encrypt backup configuration and data - if not set, backup cannot be run
    BACKUP_PASSPHRASE= \
    # how often to run a full backup (default: one month - see https://duplicity.gitlab.io/stable/duplicity.1.html#time-formats)
    BACKUP_DUPLICITY_FULL_EVERY=1M \
    # the number of full backups to keep
    BACKUP_DUPLICITY_KEEP_FULL=3 \
    # sets the duplicity volume size in MB (default: 200MB)
    BACKUP_DUPLICITY_VOLSIZE_IN_MB=200 \
    # the name of the (configured) rclone storage provider
    BACKUP_RCLONE_STORAGE= \
    # path within storage provider for putting backups - should start with a slash but must not end with one
    BACKUP_RCLONE_PATH= \
    # use in conjunction with BACKUP_COMMAND=rclone-custom to run rclone however you want
    BACKUP_RCLONE_CUSTOM_CMD= \
    BACKUP_RCLONE_CUSTOM_ARG= \
    # skip based on checksum (if available) & size, not mod-time & size (to disable set RCLONE_CHECKSUM=false)
    RCLONE_CHECKSUM=true \
    # log info about each transfer and statistics (default: INFO) - see https://rclone.org/docs/#log-level-level
    RCLONE_LOG_LEVEL=INFO

COPY ./overlay /

RUN bf-install

VOLUME [ "/config", "/restore" ]
