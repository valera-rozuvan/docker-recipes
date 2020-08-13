#!/bin/bash

sleep 3

echo "Creating users..."

mongo admin ./scripts/create-admin.js \
  --quiet
mongo sharky ./scripts/create-user.js \
  -u admin \
  -p "u45y38r3h2jt803urhj30892r3htr0" \
  --authenticationDatabase admin \
  --quiet

echo "Done."

exit 0
