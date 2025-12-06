#!/usr/bin/env bash

# Solution
# For each input lint, we can find the maximum number as follows.
#
# Start with the rightmost twelve numbers.
# Suppose we're given the input line `818181911112111`.
# Then we have:
# 818181911112111
#    ^^^^^^^^^^^^
# For each digit, whenever we encounter a larger digit to its left, we'll replace it with that larger one.
#
# To determine the leftmost digit, scan to the left and pick the largest digit we encounter.
# This is the first digit of the answer:
# 818181911112111
# ^   ^^^^^^^^^^^
#
# To determine the second digit, scan to the left and pick the largest digit.
# In this case, scan up to the digit before the first digit we've chosen.
# 818181911112111
# ^ ^  ^^^^^^^^^^
#
# Repeat this process for the remaining digits.

function get_max {
    line="$1"

    len="${#line}"
    chosen_indices=()

    # for each digit, scan to the left
    for (( i=0; i<12; i++ )); do
        max_index=$((len-12+i))
        max_num="${line:max_index:1}"

        # determine the range to check
        j_beg=$((max_index-1))
        j_end=0
        if [ "${#chosen_indices[@]}" -ne 0 ]; then
            j_end="${chosen_indices[-1]}"
            (( j_end++ ))
        fi

        # scan to the left to get the maximum number and its index
        for (( j=$j_beg; j>=$j_end; j-- )); do
            num="${line:j:1}"
            if [ "${line:j:1}" -ge "$max_num" ]; then
                max_index="$j"
                max_num="$num"
            fi
        done
        chosen_indices=("${chosen_indices[@]}" "$max_index")
    done

    # print the solution
    for i in "${chosen_indices[@]}"; do
        echo -n "${line:i:1}"
    done
    echo ""
}

sum_maxes=0
while read line; do
    m="$(get_max $line)"
    sum_maxes=$((sum_maxes + m))
done

echo "$sum_maxes"
