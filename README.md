# Docker Backup

![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-backup) ![Docker Pulls](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fpulls%2Fbackup) ![Docker Image Size](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fsize%2Fbackup) ![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/bfren/docker-backup/dev.yml?branch=main)

[Docker Repository](https://hub.docker.com/r/bfren/backup) - [bfren ecosystem](https://github.com/bfren/docker)

Uses [Duplicity](https://duplicity.gitlab.io/) and [rclone](https://rclone.org/) to perform scheduled backups, using end-to-end encryption.

Usage:

```bash
# start container
#  .. see docker-compose.yml for a sample file
docker compose up -d

# configure rclone
#  .. ensure the remote storage name is the same as environment variable BACKUP_RCLONE_STORAGE
docker exec -it backup rclone-config

# run an initial full backup
docker exec backup dup-full

# verify backup files
docker exec backup dup-verify

# list backup files
docker exec backup dup-list

# restore a file or directory
#  .. restored file or directory will be put in the /restore volume
docker exec backup dup-restore-file /path/to/file/or/directory
```

## Contents

* [Volumes](#volumes)
* [Licence / Copyright](#licence)

## Volumes

| Volume     | Purpose                                                        |
| ---------- | -------------------------------------------------------------- |
| `/b`       | Anything mounted in here will be backed up.                    |
| `/config`  | Persistent duplicity and rclone configuration, plus log files. |
| `/restore` | Restored files and directories are placed in here.             |

## Environment Variables

| Variable                      | Values  | Description                                                                                                    | Default                              |
| ----------------------------- | ------- | -------------------------------------------------------------------------------------------------------------- | ------------------------------------ |
| `BACKUP_CRON`                 | string  | Cron schedule on which backup will be run.                                                                     | 0 0 \* \* \* - every day at midnight |
| `BACKUP_PASSPHRASE`           | string  | End-to-end encryption passphrase - if changed, backups cannot be restored.                                     | *None* - required                    |
| `BACKUP_DUPLICITY_FULL_EVERY` | string  | How often to run a full backup (see [here](https://duplicity.gitlab.io/stable/duplicity.1.html#time-formats)). | 1M - one month                       |
| `BACKUP_DUPLICITY_KEEP_FULL`  | integer | How many full backups to keep - more than this will be removed as part of the schedule.                        | 3                                    |
| `BACKUP_RCLONE_STORAGE`       | string  | The name of the (configured) rclone storage provider.                                                          | *None* - required                    |
| `BACKUP_RCLONE_PATH`          | string  | The root path within the storage provider in which to put backup files.                                        | /                                    |

Additionally you can use `RCLONE_` to [configure rclone](https://rclone.org/docs/#environment-variables).

## Licence

> [MIT](https://mit.bfren.dev/2022)

## Copyright

> Copyright (c) 2022-2023 [bfren](https://bfren.dev) (unless otherwise stated)
