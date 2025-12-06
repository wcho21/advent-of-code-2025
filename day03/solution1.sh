#!/usr/bin/env bash

# Solution
# Get the maximum number in a brute-force manner.

sum_maxes=0
while read line; do
    max=0
    len="${#line}"
    for (( i=0; i<$len; i++ )); do
        for (( j=i+1; j<$len; j++ )); do
            two_batteries="${line:i:1}${line:j:1}"
            if [ "$two_batteries" -gt "$max" ]; then
                max="$two_batteries"
            fi
        done
    done
    sum_maxes=$((sum_maxes+max))
done

echo "$sum_maxes"
