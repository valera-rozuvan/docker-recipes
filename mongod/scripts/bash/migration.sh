#!/bin/bash

# sleep 3

COUNTER=0
grep --quiet --no-messages 'waiting for connections on port' /data/log/mongod.log
while [[ $? -ne 0 && $COUNTER -lt 60 ]] ; do
    sleep 1
    let COUNTER+=1
    echo "Waiting for mongod to initialize... ($COUNTER seconds so far)"
    grep --quiet --no-messages 'waiting for connections on port' /data/log/mongod.log
done

echo "Creating users..."

mongo --quiet \
  admin \
  ./scripts/js/create-admin.js
mongo --quiet \
  -u admin \
  -p "u45y38r3h2jt803urhj30892r3htr0" \
  --authenticationDatabase admin \
  sharky \
  ./scripts/js/create-user.js

echo "[done]"

exit 0
