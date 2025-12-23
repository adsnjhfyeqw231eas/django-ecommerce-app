#!/bin/sh
docker-compose build --no-cache

docker-compose up -d 
# Run the script in a specific container using docker compose exec
docker compose exec your-service-name /path/to/your/script.sh

Flowchart?
MySQL container starts ->> Healthcheck passes ->> Web container starts ->> runApp.sh waits ->> App starts ONLY when DB is reachable

reset in case of issues:
docker-compose down -v
docker-compose build --no-cache
docker-compose up

access app at: http://ec2-ip:8000/admin
note: admin/ and api/ are 2 initial routing point to the app per dev code.
api/ endpoint works, after admin has added a product/order etc.
