from debian:buster-slim

RUN apt-get update && apt-get upgrade -y && apt-get install -y gnupg2 wget tzdata
RUN wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | apt-key add -
RUN echo "deb http://repo.mongodb.org/apt/debian buster/mongodb-org/4.2 main" | tee /etc/apt/sources.list.d/mongodb-org-4.2.list
RUN apt-get update
RUN apt-get install -y mongodb-org=4.2.9 mongodb-org-server=4.2.9 mongodb-org-shell=4.2.9 mongodb-org-mongos=4.2.9 mongodb-org-tools=4.2.9

RUN mkdir -p /home/mongodb
RUN chown -R mongodb:mongodb /home/mongodb

USER mongodb

RUN touch /home/mongodb/.mongorc.js

CMD ["mongo", "--username", "sharky", "--password", "3m2n45b23nm4b23n55bn23m5b", "--authenticationDatabase", "sharky", "--host", "localhost", "--port", "27017", "sharky"]
#CMD ["mongo", "mongodb+srv://{USER}:{PASSWORD}@{HOST}/{DB_NAME}"]
