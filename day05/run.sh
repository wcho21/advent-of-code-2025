#/usr/bin/env bash

docker run --rm --volume "$PWD:/app" --workdir "/app" python:3.14.1-slim-trixie \
    sh -c "python solution1.py < input.txt && python solution2.py < input.txt"
