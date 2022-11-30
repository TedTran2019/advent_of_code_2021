def display_map(map)
  map.each do |row|
    row.each { |el| print el }
    puts
  end
end

def out_of_bounds?(map, y, x)
  y.negative? || x.negative? || y >= map.length || x >= map[0].length
end

def fill_risk_map(map, risk_map, risk, y, x)
  return if out_of_bounds?(map, y, x)

  curr_risk = map[y][x] + risk
  return unless risk_map[y][x].nil? || risk_map[y][x] > curr_risk

  risk_map[y][x] = curr_risk
  DIRS.each do |dir|
    dy = y + dir[0]
    dx = x + dir[1]
    fill_risk_map(map, risk_map, curr_risk, dy, dx)
  end
end

DIRS = [[0, 1], [1, 0], [0, -1], [-1, 0]].freeze
filename = 'input2.txt'
map = []
File.foreach(filename) do |line|
  map << line.chomp.split('').map(&:to_i)
end

risk_map = Array.new(map.length) { Array.new(map[0].length) }
fill_risk_map(map, risk_map, 0, 0, 0)
puts risk_map[-1][-1] - risk_map[0][0]
