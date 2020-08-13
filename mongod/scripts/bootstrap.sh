#!/bin/bash

cd /data/
./scripts/migration.sh &
mongod --config ./config/mongod.conf

exit 0
