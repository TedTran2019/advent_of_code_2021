def fill_map(map, vent)
  if vent[0][0] == vent[1][0]
    x = vent[0][0] 
    y1 = [vent[0][1], vent[1][1]].min
    y2 = [vent[0][1], vent[1][1]].max
    fill_vert_vent(map, y1, y2, x)
  elsif vent[0][1] == vent[1][1]
    y = vent[0][1]
    x1 = [vent[0][0], vent[1][0]].min
    x2 = [vent[0][0], vent[1][0]].max
    fill_horiz_vent(map, x1, x2, y)
  else
    start = vent[0][0] >= vent[1][0] ? vent[1] : vent[0]
    stop = vent[0][0] >= vent[1][0] ? vent[0] : vent[1]
    if start[1] <= stop[1]
      fill_diag_vent(map, start, stop)
    else
      fill_rev_diag_vent(map, start, stop)
    end
  end
end

def fill_diag_vent(map, start, stop)
  y = start[1]
  start[0].upto(stop[0]) do |x|
    map[y][x] += 1
    y += 1
  end
end

def fill_rev_diag_vent(map, start, stop)
  y = start[1]
  start[0].upto(stop[0]) do |x|
    map[y][x] += 1
    y -= 1
  end
end

def fill_horiz_vent(map, x1, x2, y)
  x1.upto(x2) { |x| map[y][x] += 1 }
end

def fill_vert_vent(map, y1, y2, x)
  y1.upto(y2) { |y| map[y][x] += 1 }
end

filename = 'input.txt'
map = Array.new(1000) { Array.new(1000, 0) }
File.foreach(filename) do |line|
  vent = line.chomp.split(' -> ').map { |coors| coors.split(',').map(&:to_i) }
  fill_map(map, vent)
end

puts map.inject(0) { |sum, row| sum + row.count { |el| el > 1 } }
