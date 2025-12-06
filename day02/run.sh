#/usr/bin/env bash

docker run --rm --volume "$PWD:/app" --workdir "/app" haskell:9.12.2-slim-bookworm \
    sh -c "ghc solution1.hs && ./solution1 < input.txt && ghc solution2.hs && ./solution2 < input.txt"
