#!/bin/bash

# Ejecutar el contenedor con los parámetros necesarios
docker run --rm \
  --name selenium-test \
  -v $(pwd)/reports:/app/report/ \
  -e JAVA_HOME=/opt/java/openjdk \
  -e PATH=/opt/java/openjdk/bin:$PATH \
  -e DISPLAY=:99 \
  -w /app \
  selenium-test:run \
  mvn clean install -U