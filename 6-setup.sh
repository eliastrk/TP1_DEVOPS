#!/bin/bash

cat > docker-compose.yml <<'YML'
services:
  postgres:
    image: postgres:16.10-alpine
    container_name: postgres
    environment:
      - POSTGRES_USER=postgres
      - POSTGRES_PASSWORD=postgres
      - POSTGRES_DB=testdb
    ports:
      - "5432:5432"
    volumes:
      - postgresdata:/var/lib/postgresql/data
      - ./db/init:/docker-entrypoint-initdb.d

volumes:
  postgresdata: {}
YML

cat > db/init/init.sql <<'SQL'
CREATE TABLE IF NOT EXISTS users (
  id SERIAL PRIMARY KEY,
  username VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS products (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  price NUMERIC(10,2) NOT NULL,
  stock INTEGER NOT NULL DEFAULT 0
);
SQL

docker-compose up -d