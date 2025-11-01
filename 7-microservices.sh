#!/bin/bash

cat > docker-compose.yml <<'YML'
services:
  api:
    build: ./microservices-app/api
    container_name: api
    ports:
      - "4000:4000"
    environment:
      - REDIS_HOST=redis
      - PGHOST=db
      - PGUSER=postgres
      - PGPASSWORD=postgres
      - PGDATABASE=appdb
    depends_on:
      - redis
      - db
    networks:
      - appnet

  worker:
    build: ./microservices-app/worker
    container_name: worker
    environment:
      - REDIS_HOST=redis
      - PGHOST=db
      - PGUSER=postgres
      - PGPASSWORD=postgres
      - PGDATABASE=appdb
    depends_on:
      - redis
      - db
    networks:
      - appnet

  db:
    image: postgres:16-alpine
    container_name: postgres2
    environment:
      - POSTGRES_USER=postgres
      - POSTGRES_PASSWORD=postgres
      - POSTGRES_DB=appdb
    volumes:
      - postgresdb:/var/lib/postgresql/data
    networks:
      - appnet

  redis:
    image: redis:alpine
    container_name: redis
    networks:
      - appnet

volumes:
  postgresdb: {}

networks:
  appnet:
    driver: bridge
YML

docker-compose up -d