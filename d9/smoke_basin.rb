def out_of_bounds?(map, x, y)
  x.negative? || y.negative? || y >= map.length || x >= map[0].length
end

def find_low_points(map)
  low_points = []
  map.each_with_index do |row, y|
    row.each_with_index do |_el, x|
      low_points << [y, x] if DIRS.all? do |dir|
        dy = y + dir[0]
        dx = x + dir[1]
        out_of_bounds?(map, dx, dy) || map[y][x] < map[dy][dx]
      end
    end
  end
  low_points
end

def sum_risk_level(low_points, map)
  low_points.inject(0) { |sum, coor| sum + map[coor[0]][coor[1]] + 1 }
end

filename = 'input.txt'
map = []
File.foreach(filename) do |row|
  map << row.chomp.split('').map { _1.to_i }
end

DIRS = [[0, 1], [1, 0], [0, -1], [-1, 0]].freeze

low_points = find_low_points(map)
puts sum_risk_level(low_points, map)
