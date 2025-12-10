-- Solution
-- Find the edge that connects all the boxes by counting visited edges.

-- split string by comma
function split(str)
    local result = {}
    for matched in string.gmatch(str, "([^,]*)") do
        table.insert(result, matched)
    end
    return result
end

-- parse two lines as coordinates and return the squared distance
function get_distance(line1, line2)
    split1 = split(line1)
    split2 = split(line2)

    distance = 0
    for i = 1, 3 do
        distance = distance + (split1[i] - split2[i])^2
    end
    return math.floor(distance)
end

-- helper function
function get_set_size(s)
    local size = 0
    for _ in pairs(s) do
        size = size + 1
    end
    return size
end

-- read input
lines = {}
for line in io.lines() do
    lines[#lines + 1] = line
end

-- get the distances and sort them
distance_edges = {}
for i = 1, #lines-1 do
    for j = i+1, #lines do
        local edge = {get_distance(lines[i], lines[j]), i, j}
        table.insert(distance_edges, edge)
    end
end
table.sort(distance_edges, function(a, b) return a[1] < b[1] end)

-- find the edge that connects all boxes and print the solution
visited = {}
for i = 1, #lines * (#lines-1) do
    local edge = distance_edges[i]
    local box1 = edge[2]
    local box2 = edge[3]
    visited[box1] = true
    visited[box2] = true

    if get_set_size(visited) == #lines then
        x1 = split(lines[box1])[1]
        x2 = split(lines[box2])[1]
        print(x1 * x2)
        break
    end
end
