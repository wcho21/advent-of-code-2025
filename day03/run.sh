#/usr/bin/env bash

docker run --rm --volume "$PWD:/app" --workdir "/app" bash:5.3.8 \
    sh -c "bash solution1.sh < input.txt && bash solution2.sh < input.txt"
