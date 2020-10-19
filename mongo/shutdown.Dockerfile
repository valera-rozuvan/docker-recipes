from debian:buster-slim

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y gnupg2 wget tzdata
RUN wget -qO - https://www.mongodb.org/static/pgp/server-4.0.asc | apt-key add -
RUN echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.0.list
RUN apt-get update
RUN apt-get install -y mongodb-org

RUN mkdir -p /home/mongodb
RUN chown -R mongodb:mongodb /home/mongodb

USER mongodb

RUN touch /home/mongodb/.mongorc.js

CMD ["mongo", "--username", "sharky", "--password", "3m2n45b23nm4b23n55bn23m5b", "--authenticationDatabase", "sharky", "--host", "localhost", "--port", "27017", "sharky"]
