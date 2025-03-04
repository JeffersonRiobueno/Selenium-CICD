#!/bin/bash

# Ejecutar el contenedor con los parámetros necesarios
docker run --rm \
  --name selenium-test \
  -v $(pwd)/reports:/app/report/ \
  -w /app \
  selenium-test:run \
  mvn test