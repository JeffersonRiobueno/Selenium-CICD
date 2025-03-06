#!/bin/bash

docker run --rm \
  --name selenium-test \
  -v $(pwd)/reports:/app/report/ \
  -w /app \
  selenium-test:run \
  mvn test