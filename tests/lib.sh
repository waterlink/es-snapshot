set -e
set -x

RECORDER_PORT=${RECORDER_PORT:-"9977"}

MAX_WAIT_RETRIES=20
RECORDER_ENDPOINT=${RECORDER_ENDPOINT:-"http://localhost:$RECORDER_PORT"}

clean_data() {
  if [[ -d "/tmp/.recorder" ]]; then
    rm -r /tmp/.recorder
  fi
}

wait_for_port() {
  retries=0
  while ! nc -z localhost $1 && [[ $retries -lt $MAX_WAIT_RETRIES ]]; do
    sleep 0.1
    retries=$((retries+1))
  done
  sleep 0.5
  [[ $retries -lt $MAX_WAIT_RETRIES ]]
}

setup() {
  clean_data
  recorder daemon -l :$RECORDER_PORT &
  wait_for_port $RECORDER_PORT
}

cleanup() {
  curl -X_TERMINATE $RECORDER_ENDPOINT || true
  clean_data
}

TEST() {
	:
	: "		=== TEST: $@ ==="
	:
}

setup
trap cleanup EXIT
