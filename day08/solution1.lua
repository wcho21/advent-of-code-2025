-- Solution
-- To get the sizes of the three largest circuits:
-- (1) compute all the distances for each pair of boxes,
-- (2) find n shortest edges by sorting the distances, and
-- (3) get the sizes of circuits using depth-first search.

-- set this to be 10 for the example input; 1000 for the puzzle input
N = 10

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

-- initialize circuits adjacency list
circuits = {}
for i = 1, #lines do
    circuits[i] = {}
end

-- get the N shortest edges
for i = 1, N do
    local edge = distance_edges[i]
    local box1 = edge[2]
    local box2 = edge[3]

    table.insert(circuits[box1], box2)
    table.insert(circuits[box2], box1)
end

-- return the size of the circuit which a given node belongs to
visited = {}
function get_size_using_dfs(graph, node)
    if visited[node] ~= nil then
        return 0
    end
    visited[node] = true

    local size = 1
    for i = 1, #graph[node] do
        local next_node = graph[node][i]
        size = size + get_size_using_dfs(graph, next_node)
    end
    return size
end

-- get the sizes in decreasin gorder
sizes = {}
for i = 1, #circuits do
    if visited[i] == true then
        sizes[#sizes + 1] = 1
        ::continue_loop::
    end
    sizes[#sizes + 1] = get_size_using_dfs(circuits, i)
end
table.sort(sizes, function(a, b) return a > b end)

-- print the solution
print(sizes[1] * sizes[2] * sizes[3])
