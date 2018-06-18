rm -rf newrelic
unzip newrelic

docker build -t encuestas-backend .
docker-compose up