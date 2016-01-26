#!/usr/bin/env bash

source ./tests/lib.sh

export ELASTICSEARCH_SERVICE_PORT=9977

export FAKE_EXPECTED_DATE_PATTERN="+%Y%m%d-%H%M%S-%s"
export FAKE_FIXED_DATE="20160126-004400-1234567"

TEST "Makes a snapshot"
PATH="./tests/fake-path:$PATH" \
  ./es-snapshot.sh
recorder is POST /_snapshot/backups/snapshot_${FAKE_FIXED_DATE} = ""

TEST "Makes a snapshot of custom repository"
PATH="./tests/fake-path:$PATH" \
  ELASTICSEARCH_SNAPSHOT_REPOSITORY=my-custom-repository \
  ./es-snapshot.sh
recorder is POST /_snapshot/my-custom-repository/snapshot_${FAKE_FIXED_DATE} = ""
