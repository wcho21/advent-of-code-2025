#/usr/bin/env bash

docker run --rm --volume "$PWD:/app" --workdir "/app" nickblah/lua:5.4.8-trixie \
    sh -c "lua solution1.lua < input.txt && lua solution2.lua < input.txt"
