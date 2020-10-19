#!/bin/bash

/data/scripts/bash/wait-for-db.sh

echo "Creating users..."

mongo --quiet \
  admin \
  /data/scripts/js/create-admin.js
mongo --quiet \
  -u admin \
  -p "u45y38r3h2jt803urhj30892r3htr0" \
  --authenticationDatabase admin \
  sharky \
  /data/scripts/js/create-user.js

echo "[done]"

exit 0
