#!/bin/bash

# Connect to a postgres DB using `psql` cli tool. Pass a single parameter,
# the DB connection string. For example:
#
#   ./psql.sh "postgres://db_user:user_pass@localhost/my_db"

CONNECTION_STRING=$1

docker build -t postgres_psql -f psql.Dockerfile .
docker run -t -i --net host postgres_psql /usr/local/bin/psql $CONNECTION_STRING

echo "Done!"
exit 0
