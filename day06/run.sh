#/usr/bin/env bash

docker run --rm --volume "$PWD:/app" --workdir "/app" denoland/deno:alpine-2.5.6 \
    sh -c "deno run --check solution1.ts < input.txt && deno run --check solution2.ts < input.txt"
