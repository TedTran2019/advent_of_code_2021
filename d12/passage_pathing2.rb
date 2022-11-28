filename = 'input.txt'
graph = Hash.new { |h, k| h[k] = [] }
File.foreach(filename) do |line|
  node_a, node_b = line.chomp.split('-')
  graph[node_a] << node_b
  graph[node_b] << node_a
end

def nbr_paths(graph, node, visited, double_visit)
  return 1 if node == 'end'
  return 0 if visited[node].positive? && double_visit

  double_visit = true if visited[node].positive?
  paths = 0
  visited[node] += 1 if node == node.downcase
  graph[node].each do |dst|
    next if dst == 'start'

    paths += nbr_paths(graph, dst, visited, double_visit)
  end
  visited[node] -= 1 if node == node.downcase
  paths
end

puts nbr_paths(graph, 'start', Hash.new(0), false)
