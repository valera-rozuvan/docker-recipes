#!/bin/bash

sleep 3

echo "Creating users..."

mongo admin create-admin.js
mongo sharky create-user.js -u admin -p admin --authenticationDatabase admin

exit 0
