# es-snapshot

This is a small script to make an elasticsearch snapshot.

First it creates/updates a snapshot repository. Next it triggers a snapshot.

Script is controlled by following environment variables:

- `ELASTICSEARCH_SERVICE_HOST` - hostname/domain/ip-address to access elastic
  search API. (defaults to `localhost`).
- `ELASTICSEARCH_SERVICE_PORT` - port to access elastic search API. (defaults
  to `9200`).
- `ELASTICSEARCH_SNAPSHOT_REPOSITORY` - name of the snapshot repository.
  (defaults to `backups`).
- `ELASTICSEARCH_SNAPSHOT_TYPE` - type of the snapshot. (supported: `fs`,
  `s3`). (default: `fs`).
- `ELASTICSEARCH_SNAPSHOT_FS_LOCATION` - location of the snapshot. (default:
  `/var/lib/es/snapshots/$ELASTICSEARCH_SNAPSHOT_REPOSITORY`).
- `ELASTICSEARCH_SNAPSHOT_S3_BUCKET` - AWS S3 bucket name. (default:
  `es-snapshots-$ELASTICSEARCH_SNAPSHOT_REPOSITORY`).

Script itself is available [here](/es-snapshot.sh).

Usage is straightforward: `export ...` aforementioned environment variables and
run the script as `./es-snapshot.sh`.

## License

MIT License. [Read here](/LICENSE).
