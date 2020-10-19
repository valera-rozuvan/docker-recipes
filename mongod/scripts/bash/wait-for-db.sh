#!/bin/bash

COUNTER=0
grep --quiet --no-messages 'waiting for connections on port' /data/log/mongod.log
while [[ $? -ne 0 && $COUNTER -lt 60 ]] ; do
    sleep 1
    let COUNTER+=1
    echo "Waiting for mongod to initialize... ($COUNTER seconds so far)"
    grep --quiet --no-messages 'waiting for connections on port' /data/log/mongod.log
done

exit 0
