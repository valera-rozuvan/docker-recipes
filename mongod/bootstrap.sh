#!/bin/bash

./migration.sh &

mongod --bind_ip "0.0.0.0"

exit 0
