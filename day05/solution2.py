from itertools import groupby
import sys

# Solution
# Merge ID ranges and get the sum of ranges.

# read input lines
input_lines = (line.strip() for line in sys.stdin)
fresh_range_lines, _ = (list(group) for key, group in groupby(input_lines, key=lambda x: x == "") if not key)

# parse range lines
parse_fresh_range = lambda line: tuple(map(int, line.split("-")))
fresh_ranges = list(sorted(map(parse_fresh_range, fresh_range_lines)))

# merge ranges
merged_ranges = []
for i, r in enumerate(fresh_ranges):
    if i == len(fresh_ranges)-1 or fresh_ranges[i][1] < fresh_ranges[i+1][0]:
        merged_ranges.append(fresh_ranges[i])
    else:
        # drop the current range and expand the next range to include both
        fresh_ranges[i+1] = (fresh_ranges[i][0], max(fresh_ranges[i][1], fresh_ranges[i+1][1]))

sum_ranges = sum(a[1] - a[0] + 1 for a in merged_ranges)
print(sum_ranges)
