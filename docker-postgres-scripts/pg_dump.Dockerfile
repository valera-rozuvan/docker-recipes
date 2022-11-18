FROM postgres:10-alpine
RUN apk update && apk upgrade

RUN mkdir /data
