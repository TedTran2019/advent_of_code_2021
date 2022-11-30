require 'rb_heap'

def display_map(map)
  map.each do |row|
    row.each { |el| print el }
    puts
  end
end

def out_of_bounds?(map, y, x)
  y.negative? || x.negative? || y >= map.length || x >= map[0].length
end

# Think of map holding the edges, while risk_map holds the nodes
# Heap holds [coors, node_val]
# Update estimates, travel to lowest val unvisited
# If already visited, skip! (Once visited, confirmed it's the most efficient path)
def dijkstra(map, src, dst)
  risk_map = Array.new(map.length) { Array.new(map[0].length) }
  visit_map = Array.new(map.length) { Array.new(map[0].length) }
  min_heap = Heap.new { |a, b| a[1] < b[1] }
  min_heap << [src, 0]
  dst_y, dst_x = dst
  until visit_map[dst_y][dst_x]
    to_visit, risk = min_heap.pop
    y, x = to_visit
    next if visit_map[y][x]

    visit_map[y][x] = true
    DIRS.each do |dir|
      dy = y + dir[0]
      dx = x + dir[1]
      next if out_of_bounds?(map, dy, dx)

      path_risk = risk + map[dy][dx]
      next unless risk_map[dy][dx].nil? || risk_map[dy][dx] > path_risk

      risk_map[dy][dx] = path_risk
      min_heap << [[dy, dx], path_risk]
    end
  end
  risk_map[dst_y][dst_x]
end

DIRS = [[0, 1], [1, 0], [0, -1], [-1, 0]].freeze
filename = 'input.txt'
map = []
File.foreach(filename) do |line|
  map << line.chomp.split('').map(&:to_i)
end

dst = [map.length - 1, map[0].length - 1]
puts dijkstra(map, [0, 0], dst)
