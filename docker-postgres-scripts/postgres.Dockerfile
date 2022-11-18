FROM postgres:10-alpine
RUN apk update && apk upgrade

COPY sql/init.sql /docker-entrypoint-initdb.d/
