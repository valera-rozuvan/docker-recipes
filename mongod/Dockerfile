from ubuntu
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y gnupg2 wget tzdata
RUN wget -qO - https://www.mongodb.org/static/pgp/server-4.0.asc | apt-key add -
RUN echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.0.list
RUN apt-get update
RUN apt-get install -y mongodb-org

RUN mkdir -p /data/db

COPY bootstrap.sh /data
RUN chmod u+x /data/bootstrap.sh

COPY migration.sh /data
RUN chmod u+x /data/migration.sh

COPY create-admin.js /data
COPY create-user.js /data

WORKDIR /data

EXPOSE 27017
ENTRYPOINT ["/bin/bash", "/data/bootstrap.sh"]
