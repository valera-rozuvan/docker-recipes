#!/bin/bash

docker build -t postgres-db --file postgres.Dockerfile .
docker run -t -i --net host -e POSTGRES_PASSWORD=postgrespasswd123 postgres-db

echo "Done!"
exit 0
