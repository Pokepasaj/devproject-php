FROM mongo:4.2-bionic

WORKDIR /docker-entrypoint-initdb.d
COPY init-mongo.js /docker-entrypoint-initdb.d/

EXPOSE 27017
