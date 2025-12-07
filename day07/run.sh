#/usr/bin/env bash

docker run --rm --volume "$PWD:/app" --workdir "/app" eclipse-temurin:21.0.9_10-jdk-ubi9-minimal \
    sh -c "java Solution1.java < input.txt && java Solution2.java < input.txt"
