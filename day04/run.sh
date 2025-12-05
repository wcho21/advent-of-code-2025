#/usr/bin/env bash

docker run --rm --volume "$PWD:/app" --workdir "/app" gcc:15.2.0 \
    sh -c "g++ -Wall -Wextra solution1.cpp -o solution1 && ./solution1 < input.txt && g++ -Wall -Wextra solution2.cpp -o solution2 && ./solution2 < input.txt"
