FROM postgres:alpine as run

WORKDIR /app

ADD ./init-db.sh /docker-entrypoint-initdb.d/
