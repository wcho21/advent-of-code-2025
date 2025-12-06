from itertools import groupby
import sys

# Solution
# Count the fresh IDs which are between the fresh ID ranges.

# read input lines
input_lines = (line.strip() for line in sys.stdin)
fresh_range_lines, available_lines = (list(group) for key, group in groupby(input_lines, key=lambda x: x == "") if not key)

# parse range lines
parse_fresh_range = lambda line: tuple(map(int, line.split("-")))
fresh_ranges = list(map(parse_fresh_range, fresh_range_lines))

# count available fresh id
is_in_fresh_range = lambda target_id: any(fresh_range[0] <= target_id <= fresh_range[1] for fresh_range in fresh_ranges)
num_fresh_ids = sum(1 if is_in_fresh_range(int(line)) else 0 for line in available_lines)

print(num_fresh_ids)
