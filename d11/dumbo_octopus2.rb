DIRS = [
  [1, 0], [-1, 0], [0, 1], [0, -1],
  [1, 1], [1, -1], [-1, 1], [-1, -1]
].freeze

def out_of_bounds?(energy, y, x)
  x.negative? || y.negative? || y >= energy.length || x >= energy[0].length
end

def step(energy)
  flashed = {}
  flashes = 0
  energy.each_with_index do |row, y|
    row.each_with_index do |_el, x|
      flashes += flash(energy, y, x, flashed)
    end
  end
  flashes
end

def flash(energy, y, x, flashed)
  return 0 if out_of_bounds?(energy, y, x) || flashed[[y, x]]

  flashes = 0
  energy[y][x] += 1
  return 0 unless energy[y][x] > 9

  flashed[[y, x]] = true
  energy[y][x] = 0
  flashes += 1
  DIRS.each do |dir|
    dy = y + dir[0]
    dx = x + dir[1]
    flashes += flash(energy, dy, dx, flashed)
  end
  flashes
end

filename = 'input.txt'
energy = []
File.foreach(filename) do |line|
  energy << line.chomp.split('').map { _1.to_i }
end

octopuses = energy.length * energy[0].length
steps = 1
steps += 1 until octopuses == step(energy)
puts steps
