#!/bin/bash

# Restore a dump file to a running database. See below shell variable names
# for more information. For example:
#
#   ./pg_restore.sh my_db db_user /tmp
#
# Pleas note - the `DUMP_DIR` path should be absolute.

DB_NAME=$1
DB_USER=$2
DUMP_DIR=$3

docker build -t postgres_pg_restore -f pg_restore.Dockerfile .
docker run \
  -t \
  -i \
  --net=host \
  -v "${DUMP_DIR}:/data" \
  postgres_pg_restore \
  /usr/local/bin/pg_restore \
    -h localhost \
    -p 5432 \
    -d $DB_NAME \
    -U $DB_USER \
    --disable-triggers \
    -xO \
    -j 4 \
    "/data/${DB_NAME}.dump"

echo "Done!"
exit 0
