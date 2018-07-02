#!/bin/bash

echo "Remove older versions"
rm -rf newrelic
rm -rf __MACOSX
docker stack rm encuestas

echo "Unzip newrelic"
unzip newrelic

echo "build Backend"
docker build -t encuestas-backend .

echo "Deploy encuestas"
# El paramatro es el archivo de docker-compose.yml
docker stack deploy --compose-file $1 encuestas
