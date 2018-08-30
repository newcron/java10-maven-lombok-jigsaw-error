#!/bin/bash

docker build  -t maven-lombok-jigsaw-sample .
docker run -it --rm --name maven-lombok-jigsaw-sample-instance maven-lombok-jigsaw-sample ./mvnw clean install