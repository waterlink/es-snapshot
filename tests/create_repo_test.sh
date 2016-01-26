#!/usr/bin/env bash

source ./tests/lib.sh

export ELASTICSEARCH_SERVICE_PORT=9977

TEST "Simplest usecase"
./es-snapshot.sh
recorder is -j "type" PUT /_snapshot/backups = "fs"
recorder is -j "settings/location" PUT /_snapshot/backups = "/var/lib/es/snapshots/backups"

TEST "Custom snapshot repository name"
ELASTICSEARCH_SNAPSHOT_REPOSITORY="custom-backups" \
  ./es-snapshot.sh
recorder is -j "type" PUT /_snapshot/custom-backups = "fs"
recorder is -j "settings/location" PUT /_snapshot/custom-backups = "/var/lib/es/snapshots/custom-backups"

TEST "Explicitly specified fs type"
ELASTICSEARCH_SNAPSHOT_TYPE=fs \
  ./es-snapshot.sh
recorder is -j "type" PUT /_snapshot/backups = "fs"
recorder is -j "settings/location" PUT /_snapshot/backups = "/var/lib/es/snapshots/backups"

TEST "Custom fs location"
ELASTICSEARCH_SNAPSHOT_TYPE=fs \
  ELASTICSEARCH_SNAPSHOT_FS_LOCATION="/opt/my/custom/location" \
  ./es-snapshot.sh
recorder is -j "type" PUT /_snapshot/backups = "fs"
recorder is -j "settings/location" PUT /_snapshot/backups = "/opt/my/custom/location"

TEST "Explicitly specified s3 type"
ELASTICSEARCH_SNAPSHOT_TYPE=s3 \
  ./es-snapshot.sh
recorder is -j "type" PUT /_snapshot/backups = "s3"
recorder is -j "settings/bucket" PUT /_snapshot/backups = "es-snapshots-backups"

TEST "Custom snapshot repository name affects default s3 bucket name"
ELASTICSEARCH_SNAPSHOT_TYPE=s3 \
  ELASTICSEARCH_SNAPSHOT_REPOSITORY=awesome-backups \
  ./es-snapshot.sh
recorder is -j "type" PUT /_snapshot/awesome-backups = "s3"
recorder is -j "settings/bucket" PUT /_snapshot/awesome-backups = "es-snapshots-awesome-backups"

TEST "Custom s3 bucket name"
ELASTICSEARCH_SNAPSHOT_TYPE=s3 \
  ELASTICSEARCH_SNAPSHOT_S3_BUCKET="my-custom-bucket" \
  ./es-snapshot.sh
recorder is -j "type" PUT /_snapshot/backups = "s3"
recorder is -j "settings/bucket" PUT /_snapshot/backups = "my-custom-bucket"

TEST "Invalid snapshot type"
! ELASTICSEARCH_SNAPSHOT_TYPE=abracadabra \
  ./es-snapshot.sh
