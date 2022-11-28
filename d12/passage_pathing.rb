filename = 'input.txt'
graph = Hash.new { |h, k| h[k] = [] }
File.foreach(filename) do |line|
  node_a, node_b = line.chomp.split('-')
  graph[node_a] << node_b
  graph[node_b] << node_a
end

def nbr_paths(graph, node, visited)
  return 1 if node == 'end'

  paths = 0
  visited[node] = true if node == node.downcase
  graph[node].each do |dst|
    next if visited[dst]

    paths += nbr_paths(graph, dst, visited)
  end
  visited[node] = false if node == node.downcase
  paths
end

puts nbr_paths(graph, 'start', {})
