#/usr/bin/env bash

docker run --rm --volume "$PWD:/app" --workdir "/app" gcc:15.2.0 \
    sh -c "gcc -Wall -Wextra solution1.c -o solution1 && ./solution1 < input.txt && gcc -Wall -Wextra solution2.c -o solution2 && ./solution2 < input.txt"
