#!/bin/bash

cd /data/
./scripts/bash/migration.sh &
mongod --config ./config/mongod.conf

exit 0
