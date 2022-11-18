#!/bin/bash

# Get a dump from some remote postgres DB. Pass in 6 parameters. See below
# shell variable names for more information. For example:
#
#   ./pg_dump.sh localhost 5432 my_db db_user user_pass /tmp
#
# Pleas note - the `DUMP_DIR` path should be absolute.

HOST=$1
PORT=$2
DATABASE=$3
USER=$4
PASSWD=$5
DUMP_DIR=$6

docker build -t postgres_pg_dump -f pg_dump.Dockerfile .
docker run \
  -t \
  -i \
  --net=host \
  -e PGPASSWORD=$PASSWD \
  -v "${DUMP_DIR}:/data" \
  postgres_pg_dump \
  /usr/local/bin/pg_dump \
    -h $HOST \
    -d $DATABASE \
    -p $PORT \
    -U $USER \
    -N fts \
    -N remote \
    --exclude-table-data notifications \
    --exclude-table-data devices \
    -F c \
    -f "/data/${DATABASE}.dump"

echo "Done!"
exit 0
