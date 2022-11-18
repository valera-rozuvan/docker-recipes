# Node.js + Postgres + Redis queue + Docker Compose

Project to demonstrate running Node.js with Postgres & Redis queue using Docker Compose.

## Prerequisites

Make sure you have the latest `docker-compose` installed. The compose scripts in this project are using some new syntax, so the `docker-compose` installed should support version `3.8` of compose scripts. See official docs on compose versions [here](https://docs.docker.com/compose/compose-file/compose-versioning/).

To install latest `docker-compose` on a Debian based system you might get away with running:

```
sudo curl -L https://github.com/docker/compose/releases/download/1.28.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
```

Followed by:

```
sudo chmod +x /usr/local/bin/docker-compose
```

Then you can check the version of installed `docker-compose` by running:

```
docker-compose --version
```

You should see something like:

```
docker-compose version 1.28.2, build 67630359
```

## Run everything

```sh
docker-compose up --build
```

## Test API

The API has a `ping` end-point to check on the server's status:

```sh
echo "$(curl -s http://localhost:3000/ping)"
```

You should see some information:

```
{"environment":"development","postgres_db":"up","pong":"OK","waiting_jobs":0,"active_jobs":0,"completed_jobs":2,"failed_jobs":0,"delayed_jobs":0}
```

You can also run a test script to demonstrate how `POST` end-point is working:

```sh
./api_test.sh
```

You should see the following:

```
API call #1. Don't process data:
{"data":{"organization":{"identifier":"aaaaa","businessName":"bbbbb","dba":"cccc","ein":"dddd","businessCity":"eeee"}}}

API call #2. Process data, with incorrect data passed:
{"error":"Organization validation failed."}

API call #3. Process correct data:
{"data":{"organization":{"identifier":"aaaaa","businessName":"bbbbb","dba":"cccc","ein":"dddd","businessCity":"eeee"}},"result":{"status":"PROCESSED","createdAt":"2020-09-11T12:40:48+00:00"}}
```

## Debug Node.js code

Open Chrome Developer Tools, go to Node.js debugging panel, and open `http://localhost:9229` to debug API Node.js process. Open `http://localhost:9230` for debugging worker Node.js process.

## Explore Postgres DB via PGAdmin

This projects also bundles PGAdmin. You can reach it at `http://localhost:8080/`. Use the following credentials to log in:

```
EMAIL=admin@admin.com
PASSWORD=postgres
```

Then setup a new server (`Host name` is `postgres`, `Username` is `postgres`, `Password` is `postgres`). You should be able to see something like this:

![PGAdmin demo](./pgadmin_demo.png)
