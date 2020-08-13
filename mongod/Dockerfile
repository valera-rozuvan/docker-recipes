from debian

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y gnupg2 wget tzdata
RUN wget -qO - https://www.mongodb.org/static/pgp/server-4.0.asc | apt-key add -
RUN echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.0.list
RUN apt-get update
RUN apt-get install -y mongodb-org

RUN mkdir -p /home/mongodb
RUN chown -R mongodb:mongodb /home/mongodb

RUN mkdir -p /data/db
RUN mkdir -p /data/log

COPY scripts/ /data/scripts
COPY config/ /data/config
RUN chmod u+x /data/scripts/bash/*.sh

RUN chown -R mongodb:mongodb /data

USER mongodb
WORKDIR /data

EXPOSE 27017
ENTRYPOINT ["/bin/bash", "/data/scripts/bash/bootstrap.sh"]
