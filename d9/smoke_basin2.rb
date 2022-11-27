require 'rb_heap'

def out_of_bounds?(map, x, y)
  x.negative? || y.negative? || y >= map.length || x >= map[0].length
end

def find_basin_size(map, y, x)
  return 0 if out_of_bounds?(map, y, x) || map[y][x].nil? || map[y][x] == 9

  map[y][x] = nil
  size = 1
  DIRS.each do |dir|
    dy = y - dir[0]
    dx = x - dir[1]
    size += find_basin_size(map, dy, dx)
  end
  size
end

def find_basin_sizes(map)
  basin_sizes = Heap.new(:>)
  map.each_with_index do |row, y|
    row.each_with_index do |_el, x|
      next if map[y][x].nil? || map[y][x] == 9

      basin_sizes << find_basin_size(map, y, x)
    end
  end
  basin_sizes
end

DIRS = [[0, 1], [1, 0], [0, -1], [-1, 0]].freeze
filename = 'input.txt'
map = []
File.foreach(filename) do |row|
  map << row.chomp.split('').map { _1.to_i }
end

basin_sizes = find_basin_sizes(map)
puts basin_sizes.pop * basin_sizes.pop * basin_sizes.pop
